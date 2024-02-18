class ClickModel {
  List<NewsPost>? news;

  ClickModel({this.news});

  ClickModel.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <NewsPost>[];
      json['news'].forEach((v) {
        news!.add(new NewsPost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.news != null) {
      data['news'] = this.news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsPost {
  int? id;
  int? categoryId;
  String? title;
  String? img;
  int? dateTime;
  String? content;

  NewsPost(
      {this.id,
      this.categoryId,
      this.title,
      this.img,
      this.dateTime,
      this.content});

  NewsPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    img = json['img'];
    dateTime = json['date_time'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['img'] = this.img;
    data['date_time'] = this.dateTime;
    data['content'] = this.content;
    return data;
  }
}
