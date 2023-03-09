import 'package:flutter/material.dart';
import 'package:wortschatz/model/highscore/db_helper.dart';

import '../../viewmodels/settings/settings.dart';
import 'db_helperprogress.dart';

class Progress {
  String schwierigkeit;
  String kategorie;
  String wort;
  int roderf;
  int hilfe;


  Progress(this.schwierigkeit, this.kategorie,this.wort,this.roderf, this.hilfe);
}

class ProgressItems with ChangeNotifier {
  List<Progress> _items = [];
  List<Progress> get item {
    _items = _items..sort((b, a) => a.kategorie.compareTo(b.kategorie));
    return [..._items];
  }

  void addProgress(schwierigkeit,kategorie, wort,roderf,hilfe) {
    final progress = Progress(schwierigkeit,kategorie, wort, roderf,hilfe);
    _items.add(progress);
    notifyListeners();
  }

  Future<List<Progress>> fetchData() async {
    final db = await DBHelperProgress.database();
    List<Map<String, dynamic>> table = await db.query('Progress2');
    _items = [];
    for (var item in table) {
      _items.add(Progress(item['schwierigkeit'], item['kategorie'],item['wort'],item['roderf'],item['hilfe']));
    }
    return [..._items];
  }
}