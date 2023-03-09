import 'package:hive/hive.dart';
import 'package:wortschatz/model/progress/progressWord.dart';

class Boxes {
  static Box<Word> getWords() =>
      Hive.box<Word>('einzelWorter');
}