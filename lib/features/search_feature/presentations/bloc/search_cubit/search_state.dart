part of 'search_cubit.dart';

class SearchState {
  final StatusSearch status;
  int start;

  bool hasNextPage;
  bool isLoadMoreRunning;

  List<NewsGet> news;

  SearchState(
      {required this.status,
      this.start = 0,
      this.hasNextPage = true,
      this.isLoadMoreRunning = false,
      this.news = const []});

  SearchState copyWith(
      {StatusSearch? status,
      int? start,
      bool? hasNextPage,
      bool? isLoadMoreRunning,
      List<NewsGet>? news}) {
    return SearchState(
        status: status ?? this.status,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        isLoadMoreRunning: isLoadMoreRunning ?? this.isLoadMoreRunning,
        start: start ?? this.start,
        news: news ?? this.news);
  }
}
