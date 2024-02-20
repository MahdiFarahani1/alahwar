abstract class StatusSearch {}

class InitSearch extends StatusSearch {}

class LoadingSearch extends StatusSearch {}

class ErrorSearch extends StatusSearch {}

class ComplateSearch extends StatusSearch {
  final List data;

  ComplateSearch({required this.data});
}
