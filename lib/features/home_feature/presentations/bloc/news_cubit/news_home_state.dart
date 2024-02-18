part of 'news_home_cubit.dart';

class NewsHomeState {
  final StatusNewsHome status;
  final NewsHomeModel? model;
  final String? error;

  int start;

  bool hasNextPage;
  bool isLoadMoreRunning;

  List<NewsGet> news;
  NewsHomeState(
      {this.start = 0,
      this.news = const [],
      required this.status,
      this.model,
      this.error,
      this.hasNextPage = true,
      this.isLoadMoreRunning = false});

  NewsHomeState copyWith({
    StatusNewsHome? status,
    NewsHomeModel? model,
    String? error,
    int? start,
    bool? isFirstLoadRunning,
    bool? hasNextPage,
    bool? isLoadMoreRunning,
    List<NewsGet>? news,
  }) {
    return NewsHomeState(
      status: status ?? this.status,
      model: model ?? this.model,
      error: error ?? this.error,
      start: start ?? this.start,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoadMoreRunning: isLoadMoreRunning ?? this.isLoadMoreRunning,
      news: news ?? this.news,
    );
  }
}
