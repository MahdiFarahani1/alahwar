import 'package:flutter_application_1/features/home_feature/data/model/news_home_model.dart';

class StatusNewsHome {
  final StateNewsHome state;
  final NewsHomeModel? data;
  final String? erorr;
  StatusNewsHome({required this.state, this.data, this.erorr});
}

enum StateNewsHome { loading, complate, error }
