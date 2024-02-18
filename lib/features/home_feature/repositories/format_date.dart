class FormatData {
  static String formatDate(DateTime date, List<String> format) {
    String formattedDate = '';
    for (String part in format) {
      if (part == 'yyyy') {
        formattedDate += date.year.toString();
      } else if (part == 'MM') {
        formattedDate += date.month.toString().padLeft(2, '0');
      } else if (part == 'dd') {
        formattedDate += date.day.toString().padLeft(2, '0');
      } else {
        formattedDate += part;
      }
    }
    return formattedDate;
  }

  static String result(int apiData) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(apiData * 1000);
    String formattedDate = formatDate(date, ['yyyy', '-', 'MM', '-', 'dd']);

    return formattedDate.replaceAll("-", "/");
  }
}
