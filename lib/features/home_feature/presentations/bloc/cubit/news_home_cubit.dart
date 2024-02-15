import 'package:bloc/bloc.dart';

import 'package:flutter_application_1/features/home_feature/data/model/news_home_model.dart';
import 'package:flutter_application_1/features/home_feature/data/repository/api_news_provider.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/cubit/status_news.dart';

part 'news_home_state.dart';

class NewsHomeCubit extends Cubit<NewsHomeState> {
  NewsHomeCubit()
      : super(NewsHomeState(
            status: StatusNewsHome(state: StateNewsHome.loading)));

  fetchData() async {
    emit(NewsHomeState(status: StatusNewsHome(state: StateNewsHome.loading)));
    try {
      var response = await ApiNewsProvider().provider();

      if (response.statusCode == 200) {
        List<dynamic> newsList = response.data['news'];
        print(newsList);
        List<News> newsModel =
            newsList.map((json) => News.fromJson(json)).toList();
        emit(NewsHomeState(
            status: StatusNewsHome(
                state: StateNewsHome.complate, data: newsModel, erorr: null)));
      } else {
        emit(NewsHomeState(
            status: StatusNewsHome(
                state: StateNewsHome.error,
                data: null,
                erorr: "Unable to load data")));
      }
    } catch (e) {
      print(e);
      emit(NewsHomeState(
          status: StatusNewsHome(
              state: StateNewsHome.error,
              data: null,
              erorr: "The server has a problem")));
    }
  }
}
