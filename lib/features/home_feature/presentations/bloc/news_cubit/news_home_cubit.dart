import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/features/home_feature/data/model/news_home_model.dart';
import 'package:flutter_application_1/features/home_feature/data/repository/api_news_provider.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/news_cubit/status_news.dart';

part 'news_home_state.dart';

class NewsHomeCubit extends Cubit<NewsHomeState> {
  NewsHomeCubit()
      : super(NewsHomeState(
            status: StatusNewsHome(state: StateNewsHome.loading)));

  void loadMore(ScrollController controller) async {
    if (state.hasNextPage == true &&
        state.isLoadMoreRunning == false &&
        controller.position.extentAfter < 300) {
      emit(state.copyWith(isLoadMoreRunning: true));

      try {
        var res = await ApiNewsProvider().providerGet(state.start);
        state.start += 20;

        if (res.statusCode == 200) {
          List<dynamic> newsList = res.data['news'];
          List<NewsGet> newsModel =
              newsList.map((json) => NewsGet.fromJson(json)).toList();
          List<NewsGet> updatedNewsList = List.from(state.news)
            ..addAll(newsModel);

          emit(state.copyWith(news: updatedNewsList));
        } else {
          emit(state.copyWith(hasNextPage: false));
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      emit(state.copyWith(isLoadMoreRunning: false));
    }
  }

  fetchDataFristTime(int number) async {
    emit(NewsHomeState(status: StatusNewsHome(state: StateNewsHome.loading)));
    try {
      var response = await ApiNewsProvider().providerGet(number);

      if (response.statusCode == 200) {
        List<dynamic> newsList = response.data['news'];
        List<NewsGet> newsModel =
            newsList.map((json) => NewsGet.fromJson(json)).toList();
        emit(NewsHomeState(
            status: StatusNewsHome(
                state: StateNewsHome.complate, data: newsModel, erorr: null)));
        emit(state.copyWith(news: newsModel));
      } else {
        emit(NewsHomeState(
            status: StatusNewsHome(
                state: StateNewsHome.error,
                data: null,
                erorr: "Unable to load data")));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(NewsHomeState(
          status: StatusNewsHome(
              state: StateNewsHome.error,
              data: null,
              erorr: "Your internet has a problem")));
    }
  }
}
