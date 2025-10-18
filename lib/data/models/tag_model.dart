import 'package:hive/hive.dart';
part 'tag_model.g.dart';

@HiveType(typeId: 1)
class TagModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int colorValue; // نخزن اللون كـ int

  TagModel({
    required this.name,
    required this.colorValue,
  });
}
