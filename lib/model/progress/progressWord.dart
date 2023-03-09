import 'package:hive/hive.dart';

part 'progressWord.g.dart';

@HiveType(typeId: 0)
class Word extends HiveObject{
  @HiveField(0)
  late String diff;
  @HiveField(1)
  late String freq;
  @HiveField(2)
  late String category;
  @HiveField(3)
  late String word;
  @HiveField(4)
  late String rOderF;
  @HiveField(5)
  late int H1;
  @HiveField(6)
  late int H2;
  @HiveField(7)
  late int H3;
  @HiveField(8)
  late int H4;
}