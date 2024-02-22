import 'package:hive/hive.dart';

part 'database.g.dart';

@HiveType(typeId: 1)
class ObjectDataBase {
  ObjectDataBase({
    required this.pathImage,
    required this.title,
    required this.dateTime,
  });
  @HiveField(0)
  String title;

  @HiveField(1)
  String pathImage;

  @HiveField(2)
  String dateTime;
}
