import 'package:newsapp/newsmodel.dart';

abstract class Newsstate {}
class NewsInitialState extends Newsstate{}
class NewLoadingState extends Newsstate{}
class NewsLoadedState extends Newsstate{
  final newsmodel NewsModel;
  NewsLoadedState({required this.NewsModel});
}
class NewsErrorState extends Newsstate{
  final String error;
  NewsErrorState({required this.error});
}