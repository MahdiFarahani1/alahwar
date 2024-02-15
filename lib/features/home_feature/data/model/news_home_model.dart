class NewsHomeModel {
  List<News>? news;

  NewsHomeModel({this.news});

  NewsHomeModel.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (news != null) {
      data['news'] = news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  int? id;
  int? categoryId;
  String? title;
  String? img;
  int? dateTime;

  News({this.id, this.categoryId, this.title, this.img, this.dateTime});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      categoryId: json['category_id'],
      title: json['title'],
      img: json['img'],
      dateTime: json['date_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'title': title,
      'img': img,
      'date_time': dateTime,
    };
  }
}
