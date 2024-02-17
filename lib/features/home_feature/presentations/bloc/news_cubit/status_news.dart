class StatusNewsHome {
  final StateNewsHome state;
  final dynamic data;
  final String? erorr;
  StatusNewsHome({required this.state, this.data, this.erorr});
}

enum StateNewsHome { loading, complate, error }
