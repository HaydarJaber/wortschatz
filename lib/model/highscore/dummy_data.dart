import 'package:flutter/material.dart';
import 'package:wortschatz/model/highscore/db_helper.dart';

import '../../viewmodels/settings/settings.dart';

class HighScore {
  String date;
  int score;
  String diff;

  HighScore(this.date, this.score,this.diff);
}

class HighScoreItems with ChangeNotifier {
  List<HighScore> _items = [];
  List<HighScore> get item {
    _items = _items..sort((b, a) => a.score.compareTo(b.score));
    return [..._items];
  }

  void addHighScore(date, score, diff) {
    final highScore = HighScore(date, score, diff);
    _items.add(highScore);
    notifyListeners();
  }

  Future<List<HighScore>> fetchData() async {
    final db = await DBHelper.database();
    List<Map<String, dynamic>> table = await db.query('SCORE2');
    _items = [];
    for (var item in table) {
      _items.add(HighScore(item['date'], item['score'], item['diff']));
    }
    return [..._items];
  }
}


Map<String, int> alphabets = {
  'A': 0,
  'B': 0,
  'C': 0,
  'D': 0,
  'E': 0,
  'F': 0,
  'G': 0,
  'H': 0,
  'I': 0,
  'J': 0,
  'K': 0,
  'L': 0,
  'M': 0,
  'N': 0,
  'O': 0,
  'P': 0,
  'Q': 0,
  'R': 0,
  'S': 0,
  'T': 0,
  'U': 0,
  'V': 0,
  'W': 0,
  'X': 0,
  'Y': 0,
  'Z': 0,
  'Ä': 0,
  'Ö': 0,
  'Ü': 0,
  'ß': 0
};

List images_coins = [
  "assets/images/coins12.gif",
  "assets/images/coins11.gif",
  "assets/images/coins10.gif",
  "assets/images/coins9.gif",
  "assets/images/coins8.gif",
  "assets/images/coins7.gif",
  "assets/images/coins6.gif",
  "assets/images/coins5.gif",
  "assets/images/coins4.gif",
  "assets/images/coins3.gif",
  "assets/images/coins2.gif",
  "assets/images/coins1.gif",
  "assets/images/coins0.gif"
];
