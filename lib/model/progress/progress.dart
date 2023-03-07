import 'package:flutter/material.dart';
import 'package:wortschatz/model/highscore/db_helper.dart';

import '../../viewmodels/settings/settings.dart';

class Progress {
  String schwierigkeit;
  String wort;
  int roderf;
  int hilfe;


  Progress(this.schwierigkeit, this.wort,this.roderf, this.hilfe);
}

class ProgressItems with ChangeNotifier {
  List<Progress> _items = [];

  void addProgress(schwierigkeit, wort,roderf,hilfe) {
    final progress = Progress(schwierigkeit, wort, roderf,hilfe);
    _items.add(progress);
    notifyListeners();
  }

  Future<List<Progress>> fetchData() async {
    final db = await DBHelper.database();
    List<Map<String, dynamic>> table = await db.query('Progress');
    _items = [];
    for (var item in table) {
      _items.add(Progress(item['schwierigkeit'], item['wort'],item['roderf'],item['hilfe']));
    }
    return [..._items];
  }
}