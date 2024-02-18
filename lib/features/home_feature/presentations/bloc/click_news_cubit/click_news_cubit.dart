import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/features/home_feature/data/model/click_news_model.dart';

import 'package:flutter_application_1/features/home_feature/data/model/news_home_model.dart';
import 'package:flutter_application_1/features/home_feature/data/repository/api_news_provider.dart';
import 'package:flutter_application_1/features/home_feature/presentations/bloc/click_news_cubit/status_click_news.dart';

part 'click_news_state.dart';

class ClickNewsCubit extends Cubit<ClickNewsState> {
  ClickNewsCubit()
      : super(ClickNewsState(
            status: StatusClickNews(state: StateClickNews.loading)));

  fetchData(int id) async {
    emit(
        ClickNewsState(status: StatusClickNews(state: StateClickNews.loading)));
    try {
      var response = await ApiNewsProvider().providerPost(id);

      if (response.statusCode == 200) {
        List<dynamic> newsList = response.data['news'];

        List<NewsPost> newsModel =
            newsList.map((json) => NewsPost.fromJson(json)).toList();
        emit(ClickNewsState(
            status: StatusClickNews(
                state: StateClickNews.complate, data: newsModel, erorr: null)));
      } else {
        emit(ClickNewsState(
            status: StatusClickNews(
                state: StateClickNews.error,
                data: null,
                erorr: "Unable to load data")));
      }
    } catch (e) {
      print(e);
      emit(ClickNewsState(
          status: StatusClickNews(
              state: StateClickNews.error,
              data: null,
              erorr: "Your internet has a problem")));
    }
  }
}
