class StatusClickNews {
  final StateClickNews state;
  final dynamic data;
  final String? erorr;
  StatusClickNews({required this.state, this.data, this.erorr});
}

enum StateClickNews { loading, complate, error }
