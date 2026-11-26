import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:newsapp/newsState.dart';
import 'package:http/http.dart ' as http;

import 'newsmodel.dart';

class NewCubit extends Cubit<Newsstate>{
NewCubit():super(NewsInitialState());
  Future<void>getNews({required String query})async {
    try {
      emit(NewLoadingState());
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=$query&from=2026-10-20&sortBy=publishedAt&apiKey=1346f2c6ffa54ba3b71faa90e845c143'));
      if (response.statusCode == 200) {
        final Newmodal = jsonDecode(response.body);
        final NewsModel = newsmodel.fromJson(Newmodal);
        emit(NewsLoadedState(NewsModel: NewsModel));
      }
      else {
        emit(NewsErrorState(error: response.body));
      }
    }
    catch (ex) {
      emit(NewsErrorState(error: ex.toString()));
    }
  }
}