import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_feature/data/model/news_home_model.dart';
import 'package:flutter_application_1/features/search_feature/data/repository/provider.dart';
import 'package:flutter_application_1/features/search_feature/presentations/bloc/search_cubit/status.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState(status: InitSearch()));

  initPage() {
    emit(SearchState(status: InitSearch()));
  }

  Future<void> search(
      {required int start,
      required String sw,
      required int sctitle,
      required int sctxt,
      required int categoryID}) async {
    emit(SearchState(status: LoadingSearch()));
    try {
      var response = await ApiSearchProvider().providerGet(
          sw: sw,
          sctitle: sctitle,
          sctxt: sctxt,
          start: start,
          categoryId: categoryID);

      if (response.statusCode == 200) {
        List<dynamic> newsList = response.data['news'];
        List<NewsGet> newsModel =
            newsList.map((json) => NewsGet.fromJson(json)).toList();
        emit(SearchState(status: ComplateSearch(data: newsModel)));
        emit(state.copyWith(news: newsModel));
      } else {
        emit(SearchState(status: ErrorSearch()));
      }
    } catch (e) {
      emit(SearchState(status: ErrorSearch()));
    }
  }

  void loadMore(
      {required ScrollController controller,
      required int sctitle,
      required int sctxt,
      required String sw,
      required int categoryID}) async {
    if (state.hasNextPage == true &&
        state.isLoadMoreRunning == false &&
        controller.position.extentAfter < 300) {
      emit(state.copyWith(isLoadMoreRunning: true));

      try {
        state.start += 20;

        var res = await ApiSearchProvider().providerGet(
            start: state.start,
            sw: sw,
            sctitle: sctitle,
            sctxt: sctxt,
            categoryId: categoryID);

        if (res.statusCode == 200) {
          List<dynamic> newsList = res.data['news'];
          if (newsList.isEmpty) {
            emit(state.copyWith(hasNextPage: false));
          } else {
            List<NewsGet> newsModel =
                newsList.map((json) => NewsGet.fromJson(json)).toList();
            List<NewsGet> updatedNewsList = List.from(state.news)
              ..addAll(newsModel);

            emit(state.copyWith(news: updatedNewsList));
          }
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      emit(state.copyWith(isLoadMoreRunning: false));
    }
  }
}
