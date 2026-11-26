import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/newcubit.dart';

import 'package:newsapp/newsState.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>NewCubit()..getNews(query: 'tesla'),
      child: MaterialApp(home: NewsApp(),),);
  }
}
class NewsApp extends StatelessWidget {
  final TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NEWSAPP"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: BlocBuilder<NewCubit,Newsstate>(builder: (context,states) {
        if (states is NewLoadingState) {
        return  Center(child: CircularProgressIndicator());
        }
        else if (states is NewsErrorState) {
          return Center(child: Text(states.error));
        }
        else if (states is NewsLoadedState) {
          return Column(
            children: [
              TextField(
                controller: searchController,
                onSubmitted: (value){
                  context.read<NewCubit>()..getNews(query: value);
                },
                // onChanged: (value){
                //   context.read<NewCubit>()..getNews(query: value);
                // },
              ),
              SizedBox(height: 20,),
              Expanded(
                child: ListView.builder(itemBuilder: (context, index) {
                  final data = states.NewsModel.articles?[index];
                  return ListTile(
                    leading: CircleAvatar(
                        backgroundImage: data!.urlToImage==""
                            ? NetworkImage(
                            'https://www.magnific.com/free-photos-vectors/default')
                            : NetworkImage(data.urlToImage.toString())
                    ),
                    title: data.title=="" ? Text('sorry') : Text(
                        data.title.toString()),
                    subtitle: data.description==""? Text('sorry') : Text(
                        data.description.toString()),
                  );
                }, itemCount: states.NewsModel.articles!.length),
              ),
            ],
          );
        }
        return Center(child: Text('BAND KARDE'));
      }
    )
    );
  }

}