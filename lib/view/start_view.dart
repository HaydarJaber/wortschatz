import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wortschatz/model/words/hf_words.dart';
import 'package:wortschatz/model/settings/local_storage_settings_persistence.dart';
import 'package:wortschatz/model/settings/settings_persistence.dart';
import 'package:wortschatz/model/settings/memory_settings_persistence.dart';
import 'package:wortschatz/model/constants/routes.dart';
import 'package:wortschatz/model/highscore/db_helper.dart';
import 'package:wortschatz/view/Infopage_view.dart';
import 'package:wortschatz/view/settings_view.dart';
import 'package:wortschatz/viewmodels/router/app_router.dart';
import '../model/constants/categories.dart';
import '../model/highscore/dummy_data.dart';
import '../model/progress/progressWord.dart';
import '../model/progress/progressWord_boxes.dart';
import '../model/words/all_words.dart';
import '../model/words/nf_words.dart';
import '../viewmodels/settings/settings.dart';
import 'categories_view.dart';


class StartScreen extends StatefulWidget {
  final String category;
  const StartScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Map<String, List<int>> progressSafer = {};
  late AssetImage _imageToShow;
  final _name = TextEditingController();
  late String stored;
  var entryList = [];
  int lives = 3;
  int score = 0;
  // für DB-Progress
  int h1 = 0;
  int h2 = 0;
  int h3 = 0;
  int h4 = 0;
  // ENDE
  int verbleibendeWorter = 0;
  List saveWordForProgress = [];
  var index = 0;
  List help = [];
  bool _isButtonAufgeklappt1 = false;
  bool _isButtonAufgeklappt2 = false;
  bool _isButtonAufgeklappt3 = false;
  bool _isButtonAufgeklappt4 = false;
  List sword = [];
  late int randomIndex;
  late String randomWord;
  late List wordList = List.filled(0, int,growable: true);
  late int wordListCounter = 0;
  int iconCode = 0xf144;


void getVerbleibendeWorter(){
  if(context.read<SettingsController>().frequency.value == "Alle Wörter"){
    verbleibendeWorter = 31;
  }
  else {
    verbleibendeWorter = 16;
  }

}
  //Nächstes Wort
  void newGame() {
    setState(() {
      alphabets.updateAll((key, value) => value = 0);
      index = 0;
      getCategory();
      sword = List.generate(randomWord.length, (index) => "_");
      //checkForHelp();
      stored = randomWord;
      progressSafer[randomWord] = [0,0];          //erster eintrag richtig/falsch, zweiter wie viele Hilfen benötigt
      h1 = 0;
      h2 = 0;
      h3 = 0;
      h4 = 0;
      _isButtonAufgeklappt1 = false;
      _isButtonAufgeklappt2 = false;
      _isButtonAufgeklappt3 = false;
      _isButtonAufgeklappt4 = false;
      _imageToShow = AssetImage('assets/images/Wörter/$stored.jpg');
      print(randomWord);
      print(progressSafer);
    });
  }

  @override //Erstes Wort
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    alphabets.updateAll((key, value) => value = 0);
    getCategory();
    getSchwierigkeit();
    sword = List.generate(randomWord.length, (index) => "_");
    stored = randomWord;
    progressSafer[randomWord] = [0,0];
    _imageToShow = AssetImage('assets/images/Wörter/$stored.jpg');
    print(randomWord);
    print(progressSafer);
  }

  void changeHelpNumberforProgress(){
    if (_isButtonAufgeklappt4 == true){
      h1 = 1;
      h2 = 1;
      h3 = 1;
      h4 = 1;
    }
    if (_isButtonAufgeklappt3 == true){
      h1 = 1;
      h2 = 1;
      h3 = 1;
    }
    if (_isButtonAufgeklappt2 == true){
      h1 = 1;
      h2 = 1;
    }
    if (_isButtonAufgeklappt1 == true){
      h1 = 1;
    }
  }

  bool addWord(String diff, String freq, String category, String word, String rOderF, int h1,int h2,int h3, int h4){
    final WordForProgress = Word()
      ..diff = diff
      ..freq = freq
      ..category = category
      ..word = word
      ..rOderF = rOderF
      ..H1 = h1
      ..H2 = h2
      ..H3 = h3
      ..H4 = h4;

    saveWordForProgress.add(WordForProgress);
    final box = Boxes.getWords();
    if(WordForProgress.rOderF.contains("G") || WordForProgress.rOderF.contains("V")){
      for(int i = 0; i < saveWordForProgress.length; i++){
        box.add(saveWordForProgress[i]);
      }
    }
    return true;
  }


  void getSchwierigkeit(){
    final schwierigkeit = context.read<SettingsController>().schwierigkeit;
    final settings = context.read<SettingsController>().frequency;
          if(settings.value == 'Alle Wörter'){
            if(schwierigkeit.value == 'Leicht'){
              lives = 16;
            }
            if(schwierigkeit.value == 'Normal'){
              lives = 10;
            }
            if(schwierigkeit.value == 'Schwer'){
              lives = 6;
            }
          }
          else {
            if(schwierigkeit.value == 'Leicht'){
              lives = 8;
            }
            if(schwierigkeit.value == 'Normal'){
              lives = 5;
            }
            if(schwierigkeit.value == 'Schwer'){
              lives = 3;
            }
          }
  }


  void checkForHelp(){
    if(_isButtonAufgeklappt4 == true){
      progressSafer.update(stored, (list) {
        list[1] = 4;
        return list;
      });
      print("vier Hilfen");
      return;
    }
    if (_isButtonAufgeklappt3 == true){
      progressSafer.update(stored, (list) {
        list[1] = 3;
        return list;
      });
      print("drei Hilfen");
      return;
    }
    if(_isButtonAufgeklappt2 == true){
      progressSafer.update(stored, (list) {
        list[1] = 2;
        return list;
      });
      print("zwei Hilfen");
      return;
    }
    if(_isButtonAufgeklappt1 == true) {
      progressSafer.update(stored, (list) {
        list[1] = 1;
        return list;
      });
      print("eine Hilfe");
      return;
    }else{
      return;
    }
  }
  void addCategoryInfoforInfopage(){
    switch(widget.category) {
      case Category.All:
        progressSafer["Kategorie"] = [0];
        break;
      case Category.Autoteile:
        progressSafer["Kategorie"] = [1];
        break;
      case Category.Badezimmer:
        progressSafer["Kategorie"] = [2];
        break;
      case Category.Bauernhof:
        progressSafer["Kategorie"] = [3];
        break;
      case Category.Berufe:
        progressSafer["Kategorie"] = [4];
        break;
      case Category.DeutscheStaedte:
        progressSafer["Kategorie"] = [5];
        break;
      case Category.Fahrzeuge:
        progressSafer["Kategorie"] = [6];
        break;
      case Category.Garten:
        progressSafer["Kategorie"] = [7];
        break;
      case Category.Gemuese:
        progressSafer["Kategorie"] = [8];
        break;
      case Category.Getraenke:
        progressSafer["Kategorie"] = [9];
        break;
      case Category.Hauptstaedte:
        progressSafer["Kategorie"] = [10];
        break;
      case Category.Hausbau:
        progressSafer["Kategorie"] = [11];
        break;
      case Category.Hobbys:
        progressSafer["Kategorie"] = [12];
        break;
      case Category.Kleidung:
        progressSafer["Kategorie"] = [13];
        break;
      case Category.Koerperteile:
        progressSafer["Kategorie"] = [14];
        break;
      case Category.Kueche:
        progressSafer["Kategorie"] = [15];
        break;
      case Category.Laender:
        progressSafer["Kategorie"] = [16];
        break;
      case Category.Moebel:
        progressSafer["Kategorie"] = [17];
        break;
      case Category.Musikinstrumente:
        progressSafer["Kategorie"] = [18];
        break;
      case Category.Obst:
        progressSafer["Kategorie"] = [19];
        break;
      case Category.Pflanzen:
        progressSafer["Kategorie"] = [20];
        break;
      case Category.Restaurant:
        progressSafer["Kategorie"] = [21];
        break;
      case Category.Sportarten:
        progressSafer["Kategorie"] = [22];
        break;
      case Category.Strassenverkehr:
        progressSafer["Kategorie"] = [23];
        break;
      case Category.Supermarkt:
        progressSafer["Kategorie"] = [24];
        break;
      case Category.Tiere:
        progressSafer["Kategorie"] = [25];
        break;
      case Category.Werkzeuge:
        progressSafer["Kategorie"] = [26];
        break;
    }
  }

  void getMissingWords(){
    while(wordListCounter != wordList.length){
      getCategory();
      progressSafer[randomWord] = [2,0];
    }
  }
  void getCategory(){
    final settings = context.read<SettingsController>().frequency;
    switch(widget.category){
      case Category.Autoteile:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == autoteileMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(autoteileMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = autoteileMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfAutoteileMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfAutoteileMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfAutoteileMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfAutoteileMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfAutoteileMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfAutoteileMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
     case Category.Badezimmer:
       if(settings.value == 'Alle Wörter'){
         if(!(wordList.length == badezimmerMAP.length)){
           getVerbleibendeWorter();
           wordList = List<int>.generate(badezimmerMAP.length, (int index) => index);
           wordList.shuffle();
         }
         verbleibendeWorter--;
         randomIndex = wordList[wordListCounter];
         entryList = badezimmerMAP.entries.toList();
         randomWord = entryList[randomIndex].key;
         wordListCounter++;
         break;
       }
       if(settings.value == 'Häufige Wörter'){
         if(!(wordList.length == hfBadezimmerMAP.length)){
           getVerbleibendeWorter();
           wordList = List<int>.generate(hfBadezimmerMAP.length, (int index) => index);
           wordList.shuffle();
         }
         verbleibendeWorter--;
         randomIndex = wordList[wordListCounter];
         entryList = hfBadezimmerMAP.entries.toList();
         randomWord = entryList[randomIndex].key;
         wordListCounter++;
         break;
       }
       if(settings.value == 'Seltene Wörter'){
         if(!(wordList.length == nfBadezimmerMAP.length)){
           getVerbleibendeWorter();
           wordList = List<int>.generate(nfBadezimmerMAP.length, (int index) => index);
           wordList.shuffle();
         }
         verbleibendeWorter--;
         randomIndex = wordList[wordListCounter];
         entryList = nfBadezimmerMAP.entries.toList();
         randomWord = entryList[randomIndex].key;
         wordListCounter++;
         break;
       }
       break;
      case Category.Bauernhof:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == bauernhofMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(bauernhofMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = bauernhofMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfBauernhofMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfBauernhofMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfBauernhofMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfBauernhofMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfBauernhofMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfBauernhofMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Berufe:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == berufeMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(berufeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = berufeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfBerufeMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfBerufeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfBerufeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfBerufeMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfBerufeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfBerufeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.DeutscheStaedte:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == deutscheStaedteMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(deutscheStaedteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = deutscheStaedteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfDeutscheStaedteMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfDeutscheStaedteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfDeutscheStaedteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfDeutscheStaedteMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfDeutscheStaedteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfDeutscheStaedteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Fahrzeuge:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == fahrzeugeMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(fahrzeugeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = fahrzeugeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfFahrzeugeMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfFahrzeugeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfFahrzeugeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfFahrzeugeMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfFahrzeugeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfFahrzeugeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Garten:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == gartenMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(gartenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = gartenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfGartenMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfGartenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfGartenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfGartenMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfGartenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfGartenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Gemuese:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == gemueseMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(gemueseMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = gemueseMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfGemueseMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfGemueseMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfGemueseMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfGemueseMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfGemueseMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfGemueseMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Getraenke:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == getraenkeMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(getraenkeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = getraenkeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfGetraenkeMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfGetraenkeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfGetraenkeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfGetraenkeMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfGetraenkeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfGetraenkeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Hauptstaedte:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == hauptstaedteMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hauptstaedteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hauptstaedteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfHauptstaedteMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfHauptstaedteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfHauptstaedteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfHauptstaedteMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfHauptstaedteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfHauptstaedteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Hausbau:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == hausbauMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hausbauMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hausbauMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfHausbauMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfHausbauMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfHausbauMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfHausbauMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfHausbauMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfHausbauMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Hobbys:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == hobbysMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hobbysMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hobbysMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfHobbysMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfHobbysMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfHobbysMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfHobbysMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfHobbysMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfHobbysMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Kleidung:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == kleidungMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(kleidungMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = kleidungMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfKleidungMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfKleidungMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfKleidungMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfKleidungMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfKleidungMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfKleidungMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Koerperteile:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == koerperteileMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(koerperteileMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = koerperteileMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfKoerperteileMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfKoerperteileMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfKoerperteileMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfKoerperteileMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfKoerperteileMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfKoerperteileMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Kueche:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == kuecheMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(kuecheMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = kuecheMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfKuecheMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfKuecheMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfKuecheMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfKuecheMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfKuecheMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfKuecheMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Laender:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == laenderMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(laenderMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = laenderMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfLaenderMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfLaenderMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfLaenderMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfLaenderMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfLaenderMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfLaenderMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Moebel:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == moebelMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(moebelMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = moebelMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfMoebelMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfMoebelMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfMoebelMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfMoebelMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfMoebelMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfMoebelMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Musikinstrumente:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == musikinstrumenteMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(musikinstrumenteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = musikinstrumenteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfMusikinstrumenteMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfMusikinstrumenteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfMusikinstrumenteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfMusikinstrumenteMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfMusikinstrumenteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfMusikinstrumenteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Obst:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == obstMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(obstMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = obstMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfObstMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfObstMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfObstMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfObstMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfObstMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfObstMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Pflanzen:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == pflanzenMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(pflanzenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = pflanzenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfPflanzenMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfPflanzenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfPflanzenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfPflanzenMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfPflanzenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfPflanzenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Restaurant:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == restaurantMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(restaurantMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = restaurantMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfRestaurantMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfRestaurantMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfRestaurantMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfRestaurantMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfRestaurantMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfRestaurantMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Sportarten:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == sportartenMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(sportartenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = sportartenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfSportartenMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfSportartenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfSportartenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfSportartenMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfSportartenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfSportartenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Strassenverkehr:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == strassenverkehrMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(strassenverkehrMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = strassenverkehrMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfStrassenverkehrMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfStrassenverkehrMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfStrassenverkehrMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfStrassenverkehrMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfStrassenverkehrMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfStrassenverkehrMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Supermarkt:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == supermarktMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(supermarktMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = supermarktMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfSupermarktMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfSupermarktMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfSupermarktMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfSupermarktMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfSupermarktMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfSupermarktMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Tiere:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == tiereMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(tiereMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = tiereMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfTiereMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfTiereMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfTiereMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfTiereMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfTiereMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfTiereMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Werkzeuge:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == werkzeugeMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(werkzeugeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = werkzeugeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Häufige Wörter'){
          if(!(wordList.length == hfWerkzeugeMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(hfWerkzeugeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = hfWerkzeugeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Seltene Wörter'){
          if(!(wordList.length == nfWerkzeugeMAP.length)){
            getVerbleibendeWorter();
            wordList = List<int>.generate(nfWerkzeugeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          verbleibendeWorter--;
          randomIndex = wordList[wordListCounter];
          entryList = nfWerkzeugeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
    }
  }

  int getIcon() {
      switch(widget.category)
      {
        case Category.All:
          iconCode = 0xf144;
         return iconCode;
        case Category.Autoteile:
          iconCode = 0xf1b9;
          return iconCode;
        case Category.Badezimmer:
          iconCode = 0xf2cd;
          return iconCode;
        case Category.Bauernhof:
          iconCode = 0xe2cd;
          return iconCode;
        case Category.Berufe:
          iconCode = 0xf85e;
          return iconCode;
        case Category.DeutscheStaedte:
          iconCode = 0xf64f;
          return iconCode;
        case Category.Fahrzeuge:
          iconCode = 0xf21c;
          return iconCode;
        case Category.Garten:
          iconCode = 0xf1bb;
          return iconCode;
        case Category.Gemuese:
          iconCode = 0xf787;
          return iconCode;
        case Category.Getraenke:
          iconCode = 0xf000;
          return iconCode;
        case Category.Hauptstaedte:
          iconCode = 0xf64f;
          return iconCode;
        case Category.Hausbau:
          iconCode = 0xf015;
          return iconCode;
        case Category.Hobbys:
          iconCode = 0xf554;
          return iconCode;
        case Category.Kleidung:
          iconCode = 0xf553;
          return iconCode;
        case Category.Koerperteile:
          iconCode = 0xf06e;
          return iconCode;
        case Category.Kueche:
          iconCode = 0xe51a;
          return iconCode;
        case Category.Laender:
          iconCode = 0xf024;
          return iconCode;
        case Category.Moebel:
          iconCode = 0xf4b8;
          return iconCode;
        case Category.Musikinstrumente:
          iconCode = 0xf001;
          return iconCode;
        case Category.Obst:
          iconCode = 0xf5d1;
          return iconCode;
        case Category.Pflanzen:
          iconCode = 0xe5aa;
          return iconCode;
        case Category.Restaurant:
          iconCode = 0xf2e7;
          return iconCode;
        case Category.Sportarten:
          iconCode = 0xf1e3;
          return iconCode;
        case Category.Strassenverkehr:
          iconCode = 0xf018;
          return iconCode;
        case Category.Supermarkt:
          iconCode = 0xf54f;
          return iconCode;
        case Category.Tiere:
          iconCode = 0xf6f0;
          return iconCode;
        case Category.Werkzeuge:
          iconCode = 0xf7d9;
          return iconCode;
      }
      return iconCode;
  }

  //refresh die Seite
  void refresh() {
    Navigator.of(context).pop();
    return;
  }

  //Unterstrich
  Widget underscore(String chr, Orientation orientation) {
    var mySizeGRP_V_US = AutoSizeGroup();
    if (orientation == Orientation.portrait) {
      return Flexible(child:
       AutoSizeText("$chr", group: mySizeGRP_V_US, style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.05, shadows: const <Shadow>[
        Shadow(
          offset: Offset(0.0, 0.0),
          blurRadius: 1.0,
          color: Colors.black,
        ),
      ],fontFamily: "PlatNomo",color: Colors.black),stepGranularity: 1,minFontSize: 3, maxLines: 1, overflow: TextOverflow.ellipsis));
      }
    else {
      return Flexible(child:
      AutoSizeText("$chr", group: mySizeGRP_V_US, style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, shadows: const <Shadow>[
        Shadow(
          offset: Offset(0.0, 0.0),
          blurRadius: 1.0,
          color: Colors.black,
        ),
      ],fontFamily: "PlatNomo",color: Colors.black),stepGranularity: 1,minFontSize: 3, maxLines: 1, overflow: TextOverflow.ellipsis));
    }
  }

  //Buchstaben-Buttons
  Widget alphaContainer(var name, Color color, Orientation orientation) {
  var mySizeGRP_Buchstaben = AutoSizeGroup();
  bool isNeedSafeArea = MediaQuery.of(context).viewPadding.bottom > 0;
  if (orientation == Orientation.portrait) {
    return Container(
        decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(15),  boxShadow:  const <BoxShadow>[
          BoxShadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 2.0,
            color: Colors.black,
          ),
        ],),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width*0.150,
        child:
        AutoSizeText(name, group: mySizeGRP_Buchstaben, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
          Shadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 1.0,
            color: Colors.black,
          ),
        ],fontFamily: "Qaz",color: Colors.black),stepGranularity: 10,minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
    );
  }
  else {
    return Container(
        decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(15),  boxShadow:  const <BoxShadow>[
          BoxShadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 2.0,
            color: Colors.black,
          ),
        ],),
        alignment: Alignment.center,
        width: isNeedSafeArea ? MediaQuery.of(context).size.width*0.08: MediaQuery.of(context).size.width*0.09,
        child:
        AutoSizeText(name, group: mySizeGRP_Buchstaben, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
          Shadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 1.0,
            color: Colors.black,
          ),
        ],fontFamily: "Qaz",color: Colors.black),stepGranularity: 10,minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
    );
  }

  }

  //erstelle Buttons
  Widget createButton(var name, Orientation orientation) {
    bool isNeedSafeArea = MediaQuery.of(context).viewPadding.bottom > 0;
    if (orientation == Orientation.portrait) {
      return alphabets[name] == 0
          ? InkWell(
          onTap: () {
            setState(() {
              if (alphabets[name] == 0) {
                var chr = name.toString().toLowerCase();
                var chrUP = name.toString();
                print(chr);
                print(chrUP);
                if (randomWord.contains(chr) || randomWord.contains(chrUP)) {                 //Wenn Buchstabe im Wort vorhanden..
                  while (randomWord.contains(chr)) {
                    int getIndex = randomWord.indexOf((chr));
                    randomWord = randomWord.replaceFirst(chr, '_');
                    sword[getIndex] = chr;
                  }
                  while (randomWord.contains(chrUP)) {
                    int getIndex = randomWord.indexOf((chrUP));
                    randomWord = randomWord.replaceFirst(chrUP, '_');
                    sword[getIndex] = chrUP;
                  }
                  if (!randomWord.contains(RegExp(r'[a-z]')) && !randomWord.contains(RegExp(r'[A-Z]'))) {                             //und dieser Buchstabe der letzte Buchstabe der Wortes ist..
                    if(wordListCounter == wordList.length){                                 //und dieses Wort das letzte Wort aus der Liste ist..
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return WillPopScope(
                              onWillPop: () async => false,
                              child:
                              AlertDialog(
                                backgroundColor: Colors.lightBlueAccent,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 3,
                                        color: Colors.black)),
                                content: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: isNeedSafeArea ? MediaQuery.of(context).size.height * 0.25: MediaQuery.of(context).size.height * 0.3,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.scaleDown, image: _imageToShow),
                                          borderRadius: const BorderRadius.all(Radius.circular(0)),
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Ink(
                                            padding: EdgeInsets.all(8),
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            height: MediaQuery.of(context).size.height * 0.2,
                                            decoration: const ShapeDecoration(
                                                color: Colors.lightGreenAccent,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 3,
                                                        color: Colors.black)
                                                )
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.check_circle_outlined,
                                                  color: Colors.black,
                                                  size: MediaQuery.of(context).size.height * 0.05,
                                                ),
                                                SizedBox(
                                                    height: MediaQuery.of(context).size.height * 0.01
                                                ),
                                                Expanded(child:
                                                AutoSizeText(stored.toString(),style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(0.0, 0.0),
                                                    blurRadius: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                              ],
                                            )
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Ink(
                                            padding: EdgeInsets.all(8),
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            height: MediaQuery.of(context).size.height * 0.2,
                                            decoration: const ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 3,
                                                        color: Colors.black)
                                                )
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Expanded(child:
                                                AutoSizeText("Glückwunsch!",style: TextStyle(fontSize: 100, shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(0.0, 0.0),
                                                    blurRadius: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                const Expanded(child:
                                                AutoSizeText("Alle Wörter durchgespielt.",style: TextStyle(fontSize: 100, shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(0.0, 0.0),
                                                    blurRadius: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                              ],
                                            )
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Material(
                                            color: Colors.transparent,
                                            child: Ink(
                                                width: MediaQuery.of(context).size.width * 0.15,
                                                height: MediaQuery.of(context).size.height * 0.10,
                                                decoration: const ShapeDecoration(
                                                    color: Colors.white,
                                                    shape: CircleBorder(
                                                        side: BorderSide(
                                                            width: 3,
                                                            color: Colors.black)
                                                    )
                                                ),
                                                child: IconButton(
                                                    icon: Icon(
                                                      const IconData(0xe4cb, fontFamily: 'MaterialIcons'),
                                                      size: MediaQuery.of(context).size.width * 0.07,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      DBHelper.insert('SCORE2', {
                                                        'date': context.read<SettingsController>().playerName.value,
                                                        'score': score,
                                                        'diff': context.read<SettingsController>().schwierigkeit.value
                                                      });
                                                      changeHelpNumberforProgress();
                                                      addWord(
                                                          context.read<SettingsController>().schwierigkeit.value,
                                                          context.read<SettingsController>().frequency.value,
                                                          widget.category,
                                                          randomWord,
                                                          "richtigG",
                                                          h1,
                                                          h2,
                                                          h3,
                                                          h4);
                                                      Navigator.pushNamed(context, Routes.categories);
                                                    })
                                            ),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            child: Ink(
                                                width: MediaQuery.of(context).size.width * 0.15,
                                                height: MediaQuery.of(context).size.height * 0.10,
                                                decoration: const ShapeDecoration(
                                                    color: Colors.white,
                                                    shape: CircleBorder(
                                                        side: BorderSide(
                                                            width: 3,
                                                            color: Colors.black)
                                                    )
                                                ),
                                                child: IconButton(
                                                    icon: Icon(
                                                      const IconData(0xe7ca, fontFamily: 'MaterialIcons'),
                                                      size: MediaQuery.of(context).size.width * 0.07,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      DBHelper.insert('SCORE2', {
                                                        'date': context.read<SettingsController>().playerName.value,
                                                        'score': score,
                                                        'diff': context.read<SettingsController>().schwierigkeit.value
                                                      });
                                                      progressSafer.update(stored, (value) => [1,0]);    //für korrektes Wort
                                                      checkForHelp();                                    //check wie viele Hilfen benötigt
                                                      addCategoryInfoforInfopage();
                                                      print(progressSafer);
                                                      changeHelpNumberforProgress();
                                                      addWord(
                                                          context.read<SettingsController>().schwierigkeit.value,
                                                          context.read<SettingsController>().frequency.value,
                                                          widget.category,
                                                          randomWord,
                                                          "richtigG",
                                                          h1,
                                                          h2,
                                                          h3,
                                                          h4);
                                                      Navigator.pushNamed(context, Routes.infopage, arguments: progressSafer);
                                                    })
                                            ),
                                          )
                                        ],
                                      ),
                                    ]),
                              ),
                            );
                          });
                    }
                    else{                                                                   //und diseses Wort NICHT das letzte Wort aus der Liste ist..
                      score = score + 1;
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return WillPopScope(
                              onWillPop: () async => false,
                              child:
                              AlertDialog(
                                backgroundColor: Colors.lightBlueAccent,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 3,
                                        color: Colors.black)),
                                content: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: isNeedSafeArea ? MediaQuery.of(context).size.height * 0.45 : MediaQuery.of(context).size.height * 0.5,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.scaleDown, image: _imageToShow),
                                          borderRadius: const BorderRadius.all(Radius.circular(0)),
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Ink(
                                            padding: EdgeInsets.all(8),
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            height: MediaQuery.of(context).size.height * 0.2,
                                            decoration: const ShapeDecoration(
                                                color: Colors.lightGreenAccent,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 3,
                                                        color: Colors.black)
                                                )
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.check_circle_outlined,
                                                  color: Colors.black,
                                                  size: MediaQuery.of(context).size.height * 0.05,
                                                ),
                                                SizedBox(
                                                    height: MediaQuery.of(context).size.height * 0.01
                                                ),
                                                Expanded(child:
                                                AutoSizeText(stored.toString(),style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(0.0, 0.0),
                                                    blurRadius: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                              ],
                                            )
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Ink(
                                            width: MediaQuery.of(context).size.width * 0.15,
                                            height: MediaQuery.of(context).size.height * 0.10,
                                            decoration: const ShapeDecoration(
                                                color: Colors.white,
                                                shape: CircleBorder(
                                                    side: BorderSide(
                                                        width: 3,
                                                        color: Colors.black)
                                                )
                                            ),
                                            child: IconButton(
                                                icon: Icon(
                                                  Icons.arrow_forward_sharp,
                                                  size: MediaQuery.of(context).size.width * 0.07,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
                                                  progressSafer.update(stored, (value) => [1,0]);
                                                  checkForHelp();
                                                  changeHelpNumberforProgress();
                                                  addWord(
                                                      context.read<SettingsController>().schwierigkeit.value,
                                                      context.read<SettingsController>().frequency.value,
                                                      widget.category,
                                                      randomWord,
                                                      "richtig",
                                                      h1,
                                                      h2,
                                                      h3,
                                                      h4);
                                                  newGame();
                                                  Navigator.of(context).pop();
                                                })
                                        ),
                                      ),
                                    ]),
                              ),
                            );
                          });
                    }
                  }
                } else {                        //Wenn Buchstabe im Wort NICHT vorhanden
                  if (index == 11) {                                                                              //und keine Münzen mehr verfügbar..
                    index = index + 1;
                    lives -= 1;
                    if(lives == 0){                                                                               //und dadurch Leben auf 0 geht
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {

                            return WillPopScope(
                              onWillPop: () async => false,
                              child:
                              AlertDialog(
                                backgroundColor: Colors.lightBlueAccent,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 3,
                                        color: Colors.black)),
                                content: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: isNeedSafeArea ? MediaQuery.of(context).size.height * 0.25 : MediaQuery.of(context).size.height * 0.3,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.scaleDown, image: _imageToShow),
                                          borderRadius: const BorderRadius.all(Radius.circular(0)),
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Ink(
                                            padding: EdgeInsets.all(8),
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            height: MediaQuery.of(context).size.height * 0.2,
                                            decoration: const ShapeDecoration(
                                                color: Colors.redAccent,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 3,
                                                        color: Colors.black)
                                                )
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.remove_circle_outline_rounded,
                                                  color: Colors.black,
                                                  size: MediaQuery.of(context).size.height * 0.05,
                                                ),
                                                SizedBox(
                                                    height: MediaQuery.of(context).size.height * 0.01
                                                ),
                                                Expanded(child:
                                                AutoSizeText(stored.toString(),style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(0.0, 0.0),
                                                    blurRadius: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                              ],
                                            )
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Ink(
                                            padding: EdgeInsets.all(8),
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            height: MediaQuery.of(context).size.height * 0.2,
                                            decoration: const ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 3,
                                                        color: Colors.black)
                                                )
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Expanded(child:
                                                AutoSizeText("ENDE",style: TextStyle(fontSize: 100, shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(0.0, 0.0),
                                                    blurRadius: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                const Expanded(child:
                                                AutoSizeText("Alle Herzen aufgebraucht!",style: TextStyle(fontSize: 100, shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(0.0, 0.0),
                                                    blurRadius: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                              ],
                                            )
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Material(
                                            color: Colors.transparent,
                                            child: Ink(
                                                width: MediaQuery.of(context).size.width * 0.15,
                                                height: MediaQuery.of(context).size.height * 0.10,
                                                decoration: const ShapeDecoration(
                                                    color: Colors.white,
                                                    shape: CircleBorder(
                                                        side: BorderSide(
                                                            width: 3,
                                                            color: Colors.black)
                                                    )
                                                ),
                                                child: IconButton(
                                                    icon: Icon(
                                                      const IconData(0xe4cb, fontFamily: 'MaterialIcons'),
                                                      size: MediaQuery.of(context).size.width * 0.07,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      DBHelper.insert('SCORE2', {
                                                        'date': context.read<SettingsController>().playerName.value,
                                                        'score': score,
                                                        'diff': context.read<SettingsController>().schwierigkeit.value
                                                      });
                                                      changeHelpNumberforProgress();
                                                      addWord(
                                                          context.read<SettingsController>().schwierigkeit.value,
                                                          context.read<SettingsController>().frequency.value,
                                                          widget.category,
                                                          randomWord,
                                                          "falschV",
                                                          h1,
                                                          h2,
                                                          h3,
                                                          h4);
                                                      Navigator.pushNamed(context, Routes.categories);
                                                    })
                                            ),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            child: Ink(
                                                width: MediaQuery.of(context).size.width * 0.15,
                                                height: MediaQuery.of(context).size.height * 0.10,
                                                decoration: const ShapeDecoration(
                                                    color: Colors.white,
                                                    shape: CircleBorder(
                                                        side: BorderSide(
                                                            width: 3,
                                                            color: Colors.black)
                                                    )
                                                ),
                                                child: IconButton(
                                                    icon: Icon(
                                                      const IconData(0xe7ca, fontFamily: 'MaterialIcons'),
                                                      size: MediaQuery.of(context).size.width * 0.07,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      DBHelper.insert('SCORE2', {
                                                        'date': context.read<SettingsController>().playerName.value,
                                                        'score': score,
                                                        'diff': context.read<SettingsController>().schwierigkeit.value
                                                      });
                                                      checkForHelp();
                                                      getMissingWords();
                                                      addCategoryInfoforInfopage();
                                                      changeHelpNumberforProgress();
                                                      addWord(
                                                          context.read<SettingsController>().schwierigkeit.value,
                                                          context.read<SettingsController>().frequency.value,
                                                          widget.category,
                                                          randomWord,
                                                          "falschV",
                                                          h1,
                                                          h2,
                                                          h3,
                                                          h4);
                                                      print(progressSafer);
                                                      Navigator.pushNamed(context, Routes.infopage, arguments: progressSafer);
                                                    })
                                            ),
                                          )
                                        ],
                                      ),
                                    ]),
                              ),
                            );
                          });
                    }
                    else {
                      if(wordListCounter == wordList.length){                                                   //oder es das letzte Wort ist auch wenn man noch Leben hat
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return WillPopScope(
                                onWillPop: () async => false,
                                child:
                                AlertDialog(
                                  backgroundColor: Colors.lightBlueAccent,
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 3,
                                          color: Colors.black)),
                                  content: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: isNeedSafeArea ? MediaQuery.of(context).size.height * 0.25:MediaQuery.of(context).size.height * 0.3,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.scaleDown, image: _imageToShow),
                                            borderRadius: const BorderRadius.all(Radius.circular(0)),
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: Ink(
                                              padding: EdgeInsets.all(8),
                                              width: MediaQuery.of(context).size.width * 0.6,
                                              height: MediaQuery.of(context).size.height * 0.2,
                                              decoration: const ShapeDecoration(
                                                  color: Colors.redAccent,
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          width: 3,
                                                          color: Colors.black)
                                                  )
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.remove_circle_outline_rounded,
                                                    color: Colors.black,
                                                    size: MediaQuery.of(context).size.height * 0.05,
                                                  ),
                                                  SizedBox(
                                                      height: MediaQuery.of(context).size.height * 0.01
                                                  ),
                                                  Expanded(child:
                                                  AutoSizeText(stored.toString(),style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 0.0),
                                                      blurRadius: 0.0,
                                                      color: Colors.black,
                                                    ),
                                                  ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                                ],
                                              )
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: Ink(
                                              padding: EdgeInsets.all(8),
                                              width: MediaQuery.of(context).size.width * 0.6,
                                              height: MediaQuery.of(context).size.height * 0.2,
                                              decoration: const ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          width: 3,
                                                          color: Colors.black)
                                                  )
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Expanded(child:
                                                  AutoSizeText("Glückwunsch!",style: TextStyle(fontSize: 100, shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 0.0),
                                                      blurRadius: 0.0,
                                                      color: Colors.black,
                                                    ),
                                                  ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                  const Expanded(child:
                                                  AutoSizeText("Alle Wörter durchgespielt.",style: TextStyle(fontSize: 100, shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 0.0),
                                                      blurRadius: 0.0,
                                                      color: Colors.black,
                                                    ),
                                                  ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                                ],
                                              )
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Material(
                                              color: Colors.transparent,
                                              child: Ink(
                                                  width: MediaQuery.of(context).size.width * 0.15,
                                                  height: MediaQuery.of(context).size.height * 0.10,
                                                  decoration: const ShapeDecoration(
                                                      color: Colors.white,
                                                      shape: CircleBorder(
                                                          side: BorderSide(
                                                              width: 3,
                                                              color: Colors.black)
                                                      )
                                                  ),
                                                  child: IconButton(
                                                      icon: Icon(
                                                        const IconData(0xe4cb, fontFamily: 'MaterialIcons'),
                                                        size: MediaQuery.of(context).size.width * 0.07,
                                                        color: Colors.black,
                                                      ),
                                                      onPressed: () {
                                                        DBHelper.insert('SCORE2', {
                                                          'date': context.read<SettingsController>().playerName.value,
                                                          'score': score,
                                                          'diff': context.read<SettingsController>().schwierigkeit.value
                                                        });
                                                        changeHelpNumberforProgress();
                                                        addWord(
                                                            context.read<SettingsController>().schwierigkeit.value,
                                                            context.read<SettingsController>().frequency.value,
                                                            widget.category,
                                                            randomWord,
                                                            "falschG",
                                                            h1,
                                                            h2,
                                                            h3,
                                                            h4);
                                                        Navigator.pushNamed(context, Routes.categories);
                                                      })
                                              ),
                                            ),
                                            Material(
                                              color: Colors.transparent,
                                              child: Ink(
                                                  width: MediaQuery.of(context).size.width * 0.15,
                                                  height: MediaQuery.of(context).size.height * 0.10,
                                                  decoration: const ShapeDecoration(
                                                      color: Colors.white,
                                                      shape: CircleBorder(
                                                          side: BorderSide(
                                                              width: 3,
                                                              color: Colors.black)
                                                      )
                                                  ),
                                                  child: IconButton(
                                                      icon: Icon(
                                                        const IconData(0xe7ca, fontFamily: 'MaterialIcons'),
                                                        size: MediaQuery.of(context).size.width * 0.07,
                                                        color: Colors.black,
                                                      ),
                                                      onPressed: () {
                                                        DBHelper.insert('SCORE2', {
                                                          'date': context.read<SettingsController>().playerName.value,
                                                          'score': score,
                                                          'diff': context.read<SettingsController>().schwierigkeit.value
                                                        });
                                                        checkForHelp();
                                                        addCategoryInfoforInfopage();
                                                        print(progressSafer);
                                                        changeHelpNumberforProgress();
                                                        addWord(
                                                            context.read<SettingsController>().schwierigkeit.value,
                                                            context.read<SettingsController>().frequency.value,
                                                            widget.category,
                                                            randomWord,
                                                            "falschG",
                                                            h1,
                                                            h2,
                                                            h3,
                                                            h4);
                                                        Navigator.pushNamed(context, Routes.infopage, arguments: progressSafer);
                                                      })
                                              ),
                                            )
                                          ],
                                        ),
                                      ]),
                                ),
                              );
                            });
                      }
                      else{
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {

                              return WillPopScope(
                                onWillPop: () async => false,
                                child:
                                AlertDialog(
                                  backgroundColor: Colors.lightBlueAccent,
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 3,
                                          color: Colors.black)),
                                  content: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: isNeedSafeArea ? MediaQuery.of(context).size.height * 0.45 : MediaQuery.of(context).size.height * 0.5,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.scaleDown, image: _imageToShow),
                                            borderRadius: const BorderRadius.all(Radius.circular(0)),
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: Ink(
                                              padding: EdgeInsets.all(8),
                                              width: MediaQuery.of(context).size.width * 0.6,
                                              height: MediaQuery.of(context).size.height * 0.2,
                                              decoration: const ShapeDecoration(
                                                  color: Colors.redAccent,
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          width: 3,
                                                          color: Colors.black)
                                                  )
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.remove_circle_outline_rounded,
                                                    color: Colors.black,
                                                    size: MediaQuery.of(context).size.height * 0.05,
                                                  ),
                                                  SizedBox(
                                                      height: MediaQuery.of(context).size.height * 0.01
                                                  ),
                                                  Expanded(child:
                                                  AutoSizeText(stored.toString(),style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 0.0),
                                                      blurRadius: 0.0,
                                                      color: Colors.black,
                                                    ),
                                                  ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                                ],
                                              )
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: Ink(
                                              width: MediaQuery.of(context).size.width * 0.15,
                                              height: MediaQuery.of(context).size.height * 0.10,
                                              decoration: const ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: CircleBorder(
                                                      side: BorderSide(
                                                          width: 3,
                                                          color: Colors.black)
                                                  )
                                              ),
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.arrow_forward_sharp,
                                                    size: MediaQuery.of(context).size.width * 0.07,
                                                    color: Colors.black,
                                                  ),
                                                  onPressed: () {
                                                    checkForHelp();
                                                    changeHelpNumberforProgress();
                                                    addWord(
                                                        context.read<SettingsController>().schwierigkeit.value,
                                                        context.read<SettingsController>().frequency.value,
                                                        widget.category,
                                                        randomWord,
                                                        "falsch",
                                                        h1,
                                                        h2,
                                                        h3,
                                                        h4);
                                                    newGame();
                                                    Navigator.of(context).pop();
                                                  })
                                          ),
                                        ),
                                      ]),
                                ),
                              );
                            });
                      }
                    }
                  } else {
                    index += 1;
                  }
                }
                alphabets[name] = 1;
              }
            });
          },
          child: alphaContainer(
            name,
            Colors.lightBlueAccent,
            orientation
          ))
          : alphaContainer(name, Colors.blueGrey, orientation);
    }
    else {
      return alphabets[name] == 0
          ? InkWell(
          onTap: () {
            setState(() {
              if (alphabets[name] == 0) {
                var chr = name.toString().toLowerCase();
                var chrUP = name.toString();
                print(chr);
                print(chrUP);
                if (randomWord.contains(chr) || randomWord.contains(chrUP)) {                 //Wenn Buchstabe im Wort vorhanden..
                  while (randomWord.contains(chr)) {
                    int getIndex = randomWord.indexOf((chr));
                    randomWord = randomWord.replaceFirst(chr, '_');
                    sword[getIndex] = chr;
                  }
                  while (randomWord.contains(chrUP)) {
                    int getIndex = randomWord.indexOf((chrUP));
                    randomWord = randomWord.replaceFirst(chrUP, '_');
                    sword[getIndex] = chrUP;
                  }
                  if (!randomWord.contains(RegExp(r'[a-z]')) && !randomWord.contains(RegExp(r'[A-Z]'))) {                             //und dieser Buchstabe der letzte Buchstabe der Wortes ist..
                    if(wordListCounter == wordList.length){                                 //und dieses Wort das letzte Wort aus der Liste ist..
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return WillPopScope(
                              onWillPop: () async => false,
                              child:
                              AlertDialog(
                                backgroundColor: Colors.lightBlueAccent,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 3,
                                        color: Colors.black)),
                                content: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Flexible(child:
                                            Column(children: [
                                              Container(
                                                height: MediaQuery.of(context).size.height * 0.5,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.scaleDown, image: _imageToShow),
                                                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ])
                                            ),
                                            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                            Flexible(child:
                                            Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children:
                                                [
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: Ink(
                                                        padding: EdgeInsets.all(8),
                                                        width: MediaQuery.of(context).size.width * 0.4,
                                                        height: MediaQuery.of(context).size.height * 0.25,
                                                        decoration: const ShapeDecoration(
                                                            color: Colors.lightGreenAccent,
                                                            shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                    width: 3,
                                                                    color: Colors.black)
                                                            )
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.check_circle_outlined,
                                                              color: Colors.black,
                                                              size: MediaQuery.of(context).size.height * 0.075,
                                                            ),
                                                            SizedBox(
                                                                height: MediaQuery.of(context).size.height * 0.005
                                                            ),
                                                            Flexible(child:
                                                            AutoSizeText(stored.toString(),style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(0.0, 0.0),
                                                                blurRadius: 0.0,
                                                                color: Colors.black,
                                                              ),
                                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                                          ],
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: Ink(
                                                        padding: EdgeInsets.all(8),
                                                        width: MediaQuery.of(context).size.width * 0.4,
                                                        height: MediaQuery.of(context).size.height * 0.25,
                                                        decoration: const ShapeDecoration(
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                    width: 3,
                                                                    color: Colors.black)
                                                            )
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            const Expanded(child:
                                                            AutoSizeText("Glückwunsch!",style: TextStyle(fontSize: 100, shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(0.0, 0.0),
                                                                blurRadius: 0.0,
                                                                color: Colors.black,
                                                              ),
                                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                            const Expanded(child:
                                                            AutoSizeText("Alle Wörter durchgespielt",style: TextStyle(fontSize: 100, shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(0.0, 0.0),
                                                                blurRadius: 0.0,
                                                                color: Colors.black,
                                                              ),
                                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                                          ],
                                                        )
                                                    ),
                                                  ),
                                                ])
                                            )
                                          ]),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Material(
                                            color: Colors.transparent,
                                            child: Ink(
                                                width: MediaQuery.of(context).size.width * 0.15,
                                                height: MediaQuery.of(context).size.height * 0.15,
                                                decoration: const ShapeDecoration(
                                                    color: Colors.white,
                                                    shape: CircleBorder(
                                                        side: BorderSide(
                                                            width: 3,
                                                            color: Colors.black)
                                                    )
                                                ),
                                                child: IconButton(
                                                    icon: Icon(
                                                      const IconData(0xe4cb, fontFamily: 'MaterialIcons'),
                                                      size: MediaQuery.of(context).size.width * 0.035,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      DBHelper.insert('SCORE2', {
                                                        'date': context.read<SettingsController>().playerName.value,
                                                        'score': score,
                                                        'diff': context.read<SettingsController>().schwierigkeit.value
                                                      });
                                                      changeHelpNumberforProgress();
                                                      addWord(
                                                          context.read<SettingsController>().schwierigkeit.value,
                                                          context.read<SettingsController>().frequency.value,
                                                          widget.category,
                                                          randomWord,
                                                          "richtigG",
                                                          h1,
                                                          h2,
                                                          h3,
                                                          h4);
                                                      Navigator.pushNamed(context, Routes.categories);
                                                    })
                                            ),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            child: Ink(
                                                width: MediaQuery.of(context).size.width * 0.15,
                                                height: MediaQuery.of(context).size.height * 0.15,
                                                decoration: const ShapeDecoration(
                                                    color: Colors.white,
                                                    shape: CircleBorder(
                                                        side: BorderSide(
                                                            width: 3,
                                                            color: Colors.black)
                                                    )
                                                ),
                                                child: IconButton(
                                                    icon: Icon(
                                                      const IconData(0xe7ca, fontFamily: 'MaterialIcons'),
                                                      size: MediaQuery.of(context).size.width * 0.035,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      DBHelper.insert('SCORE2', {
                                                        'date': context.read<SettingsController>().playerName.value,
                                                        'score': score,
                                                        'diff': context.read<SettingsController>().schwierigkeit.value
                                                      });
                                                      progressSafer.update(stored, (value) => [1,0]);    //für korrektes Wort
                                                      checkForHelp();                                    //check wie viele Hilfen benötigt
                                                      addCategoryInfoforInfopage();
                                                      print(progressSafer);
                                                      changeHelpNumberforProgress();
                                                      addWord(
                                                          context.read<SettingsController>().schwierigkeit.value,
                                                          context.read<SettingsController>().frequency.value,
                                                          widget.category,
                                                          randomWord,
                                                          "richtigG",
                                                          h1,
                                                          h2,
                                                          h3,
                                                          h4);
                                                      Navigator.pushNamed(context, Routes.infopage, arguments: progressSafer);
                                                    })
                                            ),
                                          )
                                        ],
                                      )
                                    ]),
                              ),
                            );
                          });
                    }
                    else{                                                                   //und diseses Wort NICHT das letzte Wort aus der Liste ist..
                      score = score + 1;
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return WillPopScope(
                              onWillPop: () async => false,
                              child:
                              AlertDialog(
                                backgroundColor: Colors.lightBlueAccent,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 3,
                                        color: Colors.black)),
                                content: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Flexible(child:
                                            Column(children: [
                                              Container(
                                                height: MediaQuery.of(context).size.height * 0.5,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.scaleDown, image: _imageToShow),
                                                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ])
                                            ),
                                            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                            Flexible(child:
                                            Material(
                                              color: Colors.transparent,
                                              child: Ink(
                                                  padding: EdgeInsets.all(8),
                                                  width: MediaQuery.of(context).size.width * 0.4,
                                                  height: MediaQuery.of(context).size.height * 0.5,
                                                  decoration: const ShapeDecoration(
                                                      color: Colors.lightGreenAccent,
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              width: 3,
                                                              color: Colors.black)
                                                      )
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.check_circle_outlined,
                                                        color: Colors.black,
                                                        size: MediaQuery.of(context).size.height * 0.15,
                                                      ),
                                                      SizedBox(
                                                          height: MediaQuery.of(context).size.height * 0.01
                                                      ),
                                                      Flexible(child:
                                                      AutoSizeText(stored.toString(),style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                                        Shadow(
                                                          offset: Offset(0.0, 0.0),
                                                          blurRadius: 0.0,
                                                          color: Colors.black,
                                                        ),
                                                      ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                                    ],
                                                  )
                                              ),
                                            ),
                                            )
                                          ]),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Material(
                                              color: Colors.transparent,
                                              child: Ink(
                                                  width: MediaQuery.of(context).size.width * 0.15,
                                                  height: MediaQuery.of(context).size.height * 0.15,
                                                  decoration: const ShapeDecoration(
                                                      color: Colors.white,
                                                      shape: CircleBorder(
                                                          side: BorderSide(
                                                              width: 3,
                                                              color: Colors.black)
                                                      )
                                                  ),
                                                  child: IconButton(
                                                      icon: Icon(
                                                        Icons.arrow_forward_sharp,
                                                        size: MediaQuery.of(context).size.width * 0.035,
                                                        color: Colors.black,
                                                      ),
                                                      onPressed: () {
                                                        progressSafer.update(stored, (value) => [1,0]);
                                                        checkForHelp();
                                                        changeHelpNumberforProgress();
                                                        addWord(
                                                            context.read<SettingsController>().schwierigkeit.value,
                                                            context.read<SettingsController>().frequency.value,
                                                            widget.category,
                                                            randomWord,
                                                            "richtig",
                                                            h1,
                                                            h2,
                                                            h3,
                                                            h4);
                                                        newGame();
                                                        Navigator.of(context).pop();
                                                      })
                                              ),
                                            ),
                                          ]
                                      )
                                    ]),
                              ),
                            );
                          });
                    }
                  }
                } else {                        //Wenn Buchstabe im Wort NICHT vorhanden
                  if (index == 11) {                                                                              //und keine Münzen mehr verfügbar..
                    index = index + 1;
                    lives -= 1;
                    if(lives == 0){                                                                               //und dadurch Leben auf 0 geht
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return WillPopScope(
                              onWillPop: () async => false,
                              child:
                              AlertDialog(
                                backgroundColor: Colors.lightBlueAccent,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 3,
                                        color: Colors.black)),
                                content: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Flexible(child:
                                            Column(children: [
                                              Container(
                                                height: MediaQuery.of(context).size.height * 0.5,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.scaleDown, image: _imageToShow),
                                                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ])
                                            ),
                                            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                            Flexible(child:
                                            Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children:
                                                [
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: Ink(
                                                        padding: EdgeInsets.all(8),
                                                        width: MediaQuery.of(context).size.width * 0.4,
                                                        height: MediaQuery.of(context).size.height * 0.25,
                                                        decoration: const ShapeDecoration(
                                                            color: Colors.redAccent,
                                                            shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                    width: 3,
                                                                    color: Colors.black)
                                                            )
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.remove_circle_outline_rounded,
                                                              color: Colors.black,
                                                              size: MediaQuery.of(context).size.height * 0.075,
                                                            ),
                                                            SizedBox(
                                                                height: MediaQuery.of(context).size.height * 0.005
                                                            ),
                                                            Flexible(child:
                                                            AutoSizeText(stored.toString(),style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(0.0, 0.0),
                                                                blurRadius: 0.0,
                                                                color: Colors.black,
                                                              ),
                                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                                          ],
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: Ink(
                                                        padding: EdgeInsets.all(8),
                                                        width: MediaQuery.of(context).size.width * 0.4,
                                                        height: MediaQuery.of(context).size.height * 0.25,
                                                        decoration: const ShapeDecoration(
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                    width: 3,
                                                                    color: Colors.black)
                                                            )
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            const Expanded(child:
                                                            AutoSizeText("ENDE",style: TextStyle(fontSize: 100, shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(0.0, 0.0),
                                                                blurRadius: 0.0,
                                                                color: Colors.black,
                                                              ),
                                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                            const Expanded(child:
                                                            AutoSizeText("Alle Herzen aufgebraucht!",style: TextStyle(fontSize: 100, shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(0.0, 0.0),
                                                                blurRadius: 0.0,
                                                                color: Colors.black,
                                                              ),
                                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                                          ],
                                                        )
                                                    ),
                                                  ),
                                                ])
                                            )
                                          ]),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Material(
                                            color: Colors.transparent,
                                            child: Ink(
                                                width: MediaQuery.of(context).size.width * 0.15,
                                                height: MediaQuery.of(context).size.height * 0.15,
                                                decoration: const ShapeDecoration(
                                                    color: Colors.white,
                                                    shape: CircleBorder(
                                                        side: BorderSide(
                                                            width: 3,
                                                            color: Colors.black)
                                                    )
                                                ),
                                                child: IconButton(
                                                    icon: Icon(
                                                      const IconData(0xe4cb, fontFamily: 'MaterialIcons'),
                                                      size: MediaQuery.of(context).size.width * 0.035,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      DBHelper.insert('SCORE2', {
                                                        'date': context.read<SettingsController>().playerName.value,
                                                        'score': score,
                                                        'diff': context.read<SettingsController>().schwierigkeit.value
                                                      });
                                                      changeHelpNumberforProgress();
                                                      addWord(
                                                          context.read<SettingsController>().schwierigkeit.value,
                                                          context.read<SettingsController>().frequency.value,
                                                          widget.category,
                                                          randomWord,
                                                          "falschV",
                                                          h1,
                                                          h2,
                                                          h3,
                                                          h4);
                                                      Navigator.pushNamed(context, Routes.categories);
                                                    })
                                            ),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            child: Ink(
                                                width: MediaQuery.of(context).size.width * 0.15,
                                                height: MediaQuery.of(context).size.height * 0.15,
                                                decoration: const ShapeDecoration(
                                                    color: Colors.white,
                                                    shape: CircleBorder(
                                                        side: BorderSide(
                                                            width: 3,
                                                            color: Colors.black)
                                                    )
                                                ),
                                                child: IconButton(
                                                    icon: Icon(
                                                      const IconData(0xe7ca, fontFamily: 'MaterialIcons'),
                                                      size: MediaQuery.of(context).size.width * 0.035,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      DBHelper.insert('SCORE2', {
                                                        'date': context.read<SettingsController>().playerName.value,
                                                        'score': score,
                                                        'diff': context.read<SettingsController>().schwierigkeit.value
                                                      });
                                                      checkForHelp();
                                                      getMissingWords();
                                                      addCategoryInfoforInfopage();
                                                      changeHelpNumberforProgress();
                                                      addWord(
                                                          context.read<SettingsController>().schwierigkeit.value,
                                                          context.read<SettingsController>().frequency.value,
                                                          widget.category,
                                                          randomWord,
                                                          "falschV",
                                                          h1,
                                                          h2,
                                                          h3,
                                                          h4);
                                                      print(progressSafer);
                                                      Navigator.pushNamed(context, Routes.infopage, arguments: progressSafer);
                                                    })
                                            ),
                                          )
                                        ],
                                      ),
                                    ]),
                              ),
                            );
                          });
                    }
                    else {
                      if(wordListCounter == wordList.length){                                                   //oder es das letzte Wort ist auch wenn man noch Leben hat
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return WillPopScope(
                                onWillPop: () async => false,
                                child:
                                AlertDialog(
                                  backgroundColor: Colors.lightBlueAccent,
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 3,
                                          color: Colors.black)),
                                  content: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Flexible(child:
                                              Column(children: [
                                                Container(
                                                  height: MediaQuery.of(context).size.height * 0.5,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.scaleDown, image: _imageToShow),
                                                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                              ])
                                              ),
                                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                              Flexible(child:
                                                  Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children:
                                                    [
                                                      Material(
                                                      color: Colors.transparent,
                                                      child: Ink(
                                                          padding: EdgeInsets.all(8),
                                                          width: MediaQuery.of(context).size.width * 0.4,
                                                          height: MediaQuery.of(context).size.height * 0.25,
                                                          decoration: const ShapeDecoration(
                                                              color: Colors.redAccent,
                                                              shape: RoundedRectangleBorder(
                                                                  side: BorderSide(
                                                                      width: 3,
                                                                      color: Colors.black)
                                                              )
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Icon(
                                                                Icons.remove_circle_outline_rounded,
                                                                color: Colors.black,
                                                                size: MediaQuery.of(context).size.height * 0.075,
                                                              ),
                                                              SizedBox(
                                                                  height: MediaQuery.of(context).size.height * 0.005
                                                              ),
                                                              Flexible(child:
                                                              AutoSizeText(stored.toString(),style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                                                Shadow(
                                                                  offset: Offset(0.0, 0.0),
                                                                  blurRadius: 0.0,
                                                                  color: Colors.black,
                                                                ),
                                                              ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                                            ],
                                                          )
                                                      ),
                                                    ),
                                                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                                                      Material(
                                                  color: Colors.transparent,
                                                  child: Ink(
                                                      padding: EdgeInsets.all(8),
                                                      width: MediaQuery.of(context).size.width * 0.4,
                                                      height: MediaQuery.of(context).size.height * 0.25,
                                                      decoration: const ShapeDecoration(
                                                          color: Colors.white,
                                                          shape: RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                  width: 3,
                                                                  color: Colors.black)
                                                          )
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Expanded(child:
                                                          AutoSizeText("Glückwunsch!",style: TextStyle(fontSize: 100, shadows: <Shadow>[
                                                            Shadow(
                                                              offset: Offset(0.0, 0.0),
                                                              blurRadius: 0.0,
                                                              color: Colors.black,
                                                            ),
                                                          ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                          const Expanded(child:
                                                          AutoSizeText("Alle Wörter durchgespielt",style: TextStyle(fontSize: 100, shadows: <Shadow>[
                                                            Shadow(
                                                              offset: Offset(0.0, 0.0),
                                                              blurRadius: 0.0,
                                                              color: Colors.black,
                                                            ),
                                                          ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                                        ],
                                                      )
                                                  ),
                                                ),
                                                ])
                                              )
                                            ]),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Material(
                                              color: Colors.transparent,
                                              child: Ink(
                                                  width: MediaQuery.of(context).size.width * 0.15,
                                                  height: MediaQuery.of(context).size.height * 0.15,
                                                  decoration: const ShapeDecoration(
                                                      color: Colors.white,
                                                      shape: CircleBorder(
                                                          side: BorderSide(
                                                              width: 3,
                                                              color: Colors.black)
                                                      )
                                                  ),
                                                  child: IconButton(
                                                      icon: Icon(
                                                        const IconData(0xe4cb, fontFamily: 'MaterialIcons'),
                                                        size: MediaQuery.of(context).size.width * 0.035,
                                                        color: Colors.black,
                                                      ),
                                                      onPressed: () {
                                                        DBHelper.insert('SCORE2', {
                                                          'date': context.read<SettingsController>().playerName.value,
                                                          'score': score,
                                                          'diff': context.read<SettingsController>().schwierigkeit.value
                                                        });
                                                        changeHelpNumberforProgress();
                                                        addWord(
                                                            context.read<SettingsController>().schwierigkeit.value,
                                                            context.read<SettingsController>().frequency.value,
                                                            widget.category,
                                                            randomWord,
                                                            "falschG",
                                                            h1,
                                                            h2,
                                                            h3,
                                                            h4);
                                                        Navigator.pushNamed(context, Routes.categories);
                                                      })
                                              ),
                                            ),
                                            Material(
                                              color: Colors.transparent,
                                              child: Ink(
                                                  width: MediaQuery.of(context).size.width * 0.15,
                                                  height: MediaQuery.of(context).size.height * 0.15,
                                                  decoration: const ShapeDecoration(
                                                      color: Colors.white,
                                                      shape: CircleBorder(
                                                          side: BorderSide(
                                                              width: 3,
                                                              color: Colors.black)
                                                      )
                                                  ),
                                                  child: IconButton(
                                                      icon: Icon(
                                                        const IconData(0xe7ca, fontFamily: 'MaterialIcons'),
                                                        size: MediaQuery.of(context).size.width * 0.035,
                                                        color: Colors.black,
                                                      ),
                                                      onPressed: () {
                                                        DBHelper.insert('SCORE2', {
                                                          'date': context.read<SettingsController>().playerName.value,
                                                          'score': score,
                                                          'diff': context.read<SettingsController>().schwierigkeit.value
                                                        });
                                                        checkForHelp();
                                                        addCategoryInfoforInfopage();
                                                        print(progressSafer);
                                                        changeHelpNumberforProgress();
                                                        addWord(
                                                            context.read<SettingsController>().schwierigkeit.value,
                                                            context.read<SettingsController>().frequency.value,
                                                            widget.category,
                                                            randomWord,
                                                            "falschG",
                                                            h1,
                                                            h2,
                                                            h3,
                                                            h4);
                                                        Navigator.pushNamed(context, Routes.infopage, arguments: progressSafer);
                                                      })
                                              ),
                                            )
                                          ],
                                        ),

                                      ]),
                                ),
                              );
                            });
                      }
                      else{
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return WillPopScope(
                                onWillPop: () async => false,
                                child:
                                AlertDialog(
                                  backgroundColor: Colors.lightBlueAccent,
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 3,
                                          color: Colors.black)),
                                  content: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                          Flexible(child:
                                          Column(children: [
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.5,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.scaleDown, image: _imageToShow),
                                                borderRadius: const BorderRadius.all(Radius.circular(0)),
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ])
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                          Flexible(child:
                                                Material(
                                                  color: Colors.transparent,
                                                  child: Ink(
                                                      padding: EdgeInsets.all(8),
                                                      width: MediaQuery.of(context).size.width * 0.4,
                                                      height: MediaQuery.of(context).size.height * 0.5,
                                                      decoration: const ShapeDecoration(
                                                          color: Colors.redAccent,
                                                          shape: RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                  width: 3,
                                                                  color: Colors.black)
                                                          )
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Icon(
                                                            Icons.remove_circle_outline_rounded,
                                                            color: Colors.black,
                                                            size: MediaQuery.of(context).size.height * 0.15,
                                                          ),
                                                          SizedBox(
                                                              height: MediaQuery.of(context).size.height * 0.01
                                                          ),
                                                          Flexible(child:
                                                          AutoSizeText(stored.toString(),style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                                            Shadow(
                                                              offset: Offset(0.0, 0.0),
                                                              blurRadius: 0.0,
                                                              color: Colors.black,
                                                            ),
                                                          ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                                        ],
                                                      )
                                                  ),
                                                ),
                                          )
                                        ]),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Material(
                                                color: Colors.transparent,
                                                child: Ink(
                                                    width: MediaQuery.of(context).size.width * 0.15,
                                                    height: MediaQuery.of(context).size.height * 0.15,
                                                    decoration: const ShapeDecoration(
                                                        color: Colors.white,
                                                        shape: CircleBorder(
                                                            side: BorderSide(
                                                                width: 3,
                                                                color: Colors.black)
                                                        )
                                                    ),
                                                    child: IconButton(
                                                        icon: Icon(
                                                          Icons.arrow_forward_sharp,
                                                          size: MediaQuery.of(context).size.width * 0.035,
                                                          color: Colors.black,
                                                        ),
                                                        onPressed: () {
                                                          checkForHelp();
                                                          changeHelpNumberforProgress();
                                                          addWord(
                                                              context.read<SettingsController>().schwierigkeit.value,
                                                              context.read<SettingsController>().frequency.value,
                                                              widget.category,
                                                              randomWord,
                                                              "falsch",
                                                              h1,
                                                              h2,
                                                              h3,
                                                              h4);
                                                          newGame();
                                                          Navigator.of(context).pop();
                                                        })
                                                ),
                                              ),
                                            ]
                                        )
                                      ]),
                                ),
                              );
                            });
                      }
                    }
                  } else {
                    index += 1;
                  }
                }
                alphabets[name] = 1;
              }
            });
          },
          child: alphaContainer(
            name,
            Colors.lightBlueAccent,
            orientation
          ))
          : alphaContainer(name, Colors.blueGrey, orientation);
    }
  }

  //Haupt build Widget
  @override
  Widget build(BuildContext context) {
    var mySizeGRP_V1 = AutoSizeGroup();
    var mySizeGRP_V2 = AutoSizeGroup();
    var mySizeGRP_V3 = AutoSizeGroup();
    bool isNeedSafeArea = MediaQuery.of(context).viewPadding.bottom > 0;
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Hintergrund.jpg"),
                  fit: BoxFit.cover
              ),
            ),
            child: OrientationBuilder(builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return Padding(
                  padding: EdgeInsets.zero,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Tooltip(message: "zurück zu den Kategorien",
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient:
                                  const LinearGradient(colors: <Color>[Colors.white, Colors.white]),
                                ),
                                height: MediaQuery.of(context).size.height*0.1,
                                padding: EdgeInsets.all(8),
                                textStyle:  TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.width*0.07,
                                ),
                                child: IconButton(
                                  iconSize: MediaQuery.of(context).size.width*0.1,
                                  onPressed: (() {
                                    Navigator.pushNamed(context, Routes.categories);
                                  }),
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.black,
                                  ),
                                )),
                            Tooltip(message: "verbleibende Wörter",
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient:
                                  const LinearGradient(colors: <Color>[Colors.white, Colors.white]),
                                ),
                                height: MediaQuery.of(context).size.height*0.1,
                                padding: EdgeInsets.all(8),
                                textStyle:  TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.width*0.07,
                                ),
                                child: Text(verbleibendeWorter.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1, shadows: const <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ], color: Colors.lightBlueAccent),maxLines: 1, overflow: TextOverflow.ellipsis)),
                            Tooltip(message: "Punktestand",
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient:
                                  const LinearGradient(colors: <Color>[Colors.white, Colors.white]),
                                ),
                                height: MediaQuery.of(context).size.height*0.1,
                                padding: EdgeInsets.all(8),
                                textStyle:  TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width*0.07,
                                ),
                                child: Text(score.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1, shadows: const <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 1.0,
                                color: Colors.green,
                              ),
                            ], color: Colors.green),maxLines: 1, overflow: TextOverflow.ellipsis)),
                            Tooltip(message: "Tipps",
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient:
                                  const LinearGradient(colors: <Color>[Colors.white, Colors.white]),
                                ),
                                height: MediaQuery.of(context).size.height*0.1,
                                padding: EdgeInsets.all(8),
                                textStyle:  TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.width*0.07,
                                ),
                                child: IconButton(
                                  onPressed: (() {
                                    showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return WillPopScope(
                                            onWillPop: () async => false,
                                            child: AlertDialog(
                                              contentPadding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                                              backgroundColor: Colors.lightBlueAccent,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: MediaQuery.of(context).size.width*0.01,
                                                      color: Colors.black)),
                                              title: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                      Icon(
                                                      Icons.lightbulb,
                                                        size: MediaQuery.of(context).size.width*0.1,
                                                        shadows: const <Shadow>[
                                                          Shadow(
                                                            offset: Offset(0.0, 0.0),
                                                            blurRadius: 10.0,
                                                            color: Colors.black,
                                                          )],
                                                        color: Colors.yellow,
                                                      ),Text(
                                                      "Tipps",
                                                      style: TextStyle(
                                                          shadows: const <Shadow>[
                                                            Shadow(
                                                              offset: Offset(0.0, 0.0),
                                                              blurRadius: 2.0,
                                                              color: Colors.black,
                                                            ),
                                                          ],
                                                          color: Colors.black,
                                                          fontSize: MediaQuery.of(context).size.width*0.1,
                                                          fontFamily: "Qaz"),
                                                    ),Icon(
                                                              Icons.lightbulb,
                                                              size: MediaQuery.of(context).size.width*0.1,
                                                              shadows: const <Shadow>[
                                                                Shadow(
                                                                  offset: Offset(0.0, 0.0),
                                                                  blurRadius: 10.0,
                                                                  color: Colors.black,
                                                                )],
                                                              color: Colors.yellow,
                                                            )
                                                          ],
                                                        ),
                                              content: StatefulBuilder(
                                                builder: (BuildContext context, StateSetter setState){
                                                  return  SizedBox(
                                                    height: MediaQuery.of(context).size.height*0.9,
                                                    width: MediaQuery.of(context).size.width*0.9,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceAround,
                                                        children: <Widget>[
                                                          Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                            Column(
                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                children: [
                                                              _isButtonAufgeklappt1 ?
                                                              Material(
                                                                color: Colors.transparent,
                                                                child: Ink(
                                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                                    height: MediaQuery.of(context).size.height * 0.12,
                                                                    decoration: const ShapeDecoration(
                                                                        color: Colors.yellow,
                                                                        shape: RoundedRectangleBorder(
                                                                            side: BorderSide(
                                                                                width: 3,
                                                                                color: Colors.black)
                                                                        )
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [Flexible(child:
                                                                        AutoSizeText(entryList[randomIndex].value[0],group: mySizeGRP_V3,style: const TextStyle(fontSize: 300, shadows: <Shadow>[
                                                                          Shadow(
                                                                            offset: Offset(0.0, 0.0),
                                                                            blurRadius: 0.0,
                                                                            color: Colors.black,
                                                                          ),
                                                                        ],fontFamily: "Qaz",color: Colors.black),textAlign: TextAlign.center,minFontSize: 10, maxLines: 2, overflow: TextOverflow.ellipsis))])
                                                                ),
                                                              ): const SizedBox.shrink(),
                                                              SizedBox(height: MediaQuery.of(context).size.height*0.03),
                                                              _isButtonAufgeklappt2 ?
                                                              Material(
                                                                color: Colors.transparent,
                                                                child: Ink(
                                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                                    height: MediaQuery.of(context).size.height * 0.12,
                                                                    decoration: const ShapeDecoration(
                                                                        color: Colors.yellow,
                                                                        shape: RoundedRectangleBorder(
                                                                            side: BorderSide(
                                                                                width: 3,
                                                                                color: Colors.black)
                                                                        )
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Flexible(child:
                                                                            AutoSizeText(entryList[randomIndex].value[1],group: mySizeGRP_V3,style: const TextStyle(fontSize: 300, shadows: <Shadow>[
                                                                              Shadow(
                                                                                offset: Offset(0.0, 0.0),
                                                                                blurRadius: 0.0,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ],fontFamily: "Qaz",color: Colors.black),textAlign: TextAlign.center, minFontSize: 10, maxLines: 2, overflow: TextOverflow.ellipsis))
                                                                          ]
                                                                        )
                                                                ),
                                                              ) : const SizedBox.shrink(),
                                                                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                                                              _isButtonAufgeklappt3 ?
                                                              Material(
                                                                color: Colors.transparent,
                                                                child: Ink(
                                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                                    height: MediaQuery.of(context).size.height * 0.12,
                                                                    decoration: const ShapeDecoration(
                                                                        color: Colors.yellow,
                                                                        shape: RoundedRectangleBorder(
                                                                            side: BorderSide(
                                                                                width: 3,
                                                                                color: Colors.black)
                                                                        )
                                                                    ),
                                                                    child:
                                                                    Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Flexible(child:
                                                                          AutoSizeText(entryList[randomIndex].value[2],group: mySizeGRP_V3,style: const TextStyle(fontSize: 300, shadows: <Shadow>[
                                                                            Shadow(
                                                                              offset: Offset(0.0, 0.0),
                                                                              blurRadius: 0.0,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ],fontFamily: "Qaz",color: Colors.black),textAlign: TextAlign.center,minFontSize: 10, maxLines: 2, overflow: TextOverflow.ellipsis))
                                                                        ])
                                                                ),
                                                              ) : const SizedBox.shrink(),
                                                                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                                                              _isButtonAufgeklappt4 ?
                                                              Material(
                                                                color: Colors.transparent,
                                                                child: Ink(
                                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                                    height: MediaQuery.of(context).size.height * 0.12,
                                                                    decoration: const ShapeDecoration(
                                                                        color: Colors.yellow,
                                                                        shape: RoundedRectangleBorder(
                                                                            side: BorderSide(
                                                                                width: 3,
                                                                                color: Colors.black)
                                                                        )
                                                                    ),
                                                                    child:
                                                                    Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [Flexible(child:
                                                                        AutoSizeText(entryList[randomIndex].value[3],group: mySizeGRP_V3,style: const TextStyle(fontSize: 300, shadows: <Shadow>[
                                                                          Shadow(
                                                                            offset: Offset(0.0, 0.0),
                                                                            blurRadius: 0.0,
                                                                            color: Colors.black,
                                                                          ),
                                                                        ],fontFamily: "Qaz",color: Colors.black),textAlign: TextAlign.center,minFontSize: 10, maxLines:2, overflow: TextOverflow.ellipsis))])
                                                                ),
                                                              ) : const SizedBox.shrink(),
                                                                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                                                              _isButtonAufgeklappt4 == false && _isButtonAufgeklappt1 == false ?
                                                              Material(
                                                                color: Colors.transparent,
                                                                child: Ink(
                                                                    width: MediaQuery.of(context).size.width * 0.6,
                                                                    height: MediaQuery.of(context).size.height * 0.12,
                                                                    decoration: ShapeDecoration(color: Colors.white,
                                                                        shape: RoundedRectangleBorder(
                                                                            side: BorderSide(width: MediaQuery.of(context).size.width*0.01, color: Colors.black))),
                                                                    child: ElevatedButton(
                                                                      onPressed: () {
                                                                        setState(() {
                                                                          if (_isButtonAufgeklappt1 == true &&
                                                                              _isButtonAufgeklappt2 ==
                                                                                  true &&
                                                                              _isButtonAufgeklappt3 ==
                                                                                  true &&
                                                                              _isButtonAufgeklappt4 ==
                                                                                  false) {
                                                                            _isButtonAufgeklappt4 =
                                                                            true;
                                                                          }
                                                                          if (_isButtonAufgeklappt1 == true &&
                                                                              _isButtonAufgeklappt2 ==
                                                                                  true &&
                                                                              _isButtonAufgeklappt3 ==
                                                                                  false) {
                                                                            _isButtonAufgeklappt3 =
                                                                            true;
                                                                          }
                                                                          if (_isButtonAufgeklappt1 ==
                                                                              true &&
                                                                              _isButtonAufgeklappt2 ==
                                                                                  false) {
                                                                            _isButtonAufgeklappt2 =
                                                                            true;
                                                                          }
                                                                          if (_isButtonAufgeklappt1 ==
                                                                              false) {
                                                                            _isButtonAufgeklappt1 =
                                                                            true;
                                                                          }
                                                                        });
                                                                      },
                                                                      style: ButtonStyle(
                                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  10.0),
                                                                              side: const BorderSide(color: Colors.black))),
                                                                          alignment: Alignment.center,
                                                                          backgroundColor: MaterialStateProperty.resolveWith(
                                                                                  (state) {
                                                                                if (state
                                                                                    .contains(MaterialState.pressed)) {
                                                                                  return Colors.grey;
                                                                                }
                                                                                return Colors
                                                                                    .white;
                                                                              }),
                                                                          shadowColor:
                                                                          MaterialStateProperty.all(Colors
                                                                              .transparent),
                                                                          side: MaterialStateProperty.all(
                                                                              const BorderSide(width: 1))),
                                                                      child:
                                                                      AutoSizeText('Tipp anzeigen', style: TextStyle(fontSize: 70,fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                                                    )),
                                                              ) : const SizedBox.shrink(),
                                                                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                                                              _isButtonAufgeklappt1 == true && _isButtonAufgeklappt4 == false ?
                                                              Material(
                                                                color: Colors.transparent,
                                                                child: Ink(
                                                                    width: MediaQuery.of(context).size.width * 0.6,
                                                                    height: MediaQuery.of(context).size.height * 0.12,
                                                                    decoration: ShapeDecoration(color: Colors.white,
                                                                        shape: RoundedRectangleBorder(
                                                                            side: BorderSide(width: MediaQuery.of(context).size.width*0.01, color: Colors.black))),
                                                                    child: ElevatedButton(
                                                                        onPressed: () {
                                                                          setState((){
                                                                            if (_isButtonAufgeklappt1 == true && _isButtonAufgeklappt2 == true && _isButtonAufgeklappt3 == true && _isButtonAufgeklappt4 == false){
                                                                              _isButtonAufgeklappt4 = true;
                                                                            }
                                                                            if (_isButtonAufgeklappt1 == true && _isButtonAufgeklappt2 == true && _isButtonAufgeklappt3 == false){
                                                                              _isButtonAufgeklappt3 = true;
                                                                            }
                                                                            if (_isButtonAufgeklappt1 == true && _isButtonAufgeklappt2 == false){
                                                                              _isButtonAufgeklappt2 = true;
                                                                            }
                                                                            if (_isButtonAufgeklappt1 == false){
                                                                              _isButtonAufgeklappt1 = true;
                                                                            }
                                                                          });
                                                                        },
                                                                        style: ButtonStyle(
                                                                            alignment: Alignment.center,
                                                                            backgroundColor: MaterialStateProperty.resolveWith((state) {
                                                                              if (state.contains(MaterialState.pressed)) return Colors.grey;
                                                                              return Colors.white;
                                                                            }),
                                                                            shadowColor: MaterialStateProperty.all(Colors.transparent),
                                                                            side: MaterialStateProperty.all(const BorderSide(width: 1))),
                                                                        child: const AutoSizeText('nächster Tipp', style: TextStyle(fontSize: 70,fontFamily: "Qaz",color: Colors.black),textAlign: TextAlign.center,minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                                                    )),
                                                              ) : const SizedBox.shrink()]),
                                                                SizedBox(height: MediaQuery.of(context).size.height*0.03),
                                                            ]),
                                                          Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [Material(
                                                            color: Colors.transparent,
                                                            child: Ink(
                                                                width: MediaQuery.of(context).size.width * 0.2,
                                                                height: MediaQuery.of(context).size.height * 0.1,
                                                                decoration: const ShapeDecoration(
                                                                    color: Colors.white,
                                                                    shape: CircleBorder(
                                                                        side: BorderSide(
                                                                            width: 3,
                                                                            color: Colors.black)
                                                                    )
                                                                ),
                                                                child: IconButton(
                                                                    style: ButtonStyle(
                                                                        alignment: Alignment.center,
                                                                        backgroundColor: MaterialStateProperty.resolveWith((state) {
                                                                          if (state.contains(MaterialState.pressed)) return Colors.grey;
                                                                          return Colors.black;
                                                                        }),
                                                                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                                                                        side: MaterialStateProperty.all(const BorderSide(width: 2))),
                                                                    icon: Icon(
                                                                      Icons.cancel_outlined,
                                                                      size: MediaQuery.of(context).size.height*0.05,
                                                                      color: Colors.black,
                                                                    ),
                                                                    onPressed: () {
                                                                      Navigator.of(context).pop();
                                                                    })
                                                            ),
                                                          )]),
                                                        ])
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        });
                                  }),
                                  iconSize: MediaQuery.of(context).size.width*0.1,
                                  icon: const Icon(
                                    Icons.lightbulb,
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 10.0,
                                        color: Colors.black,
                                      )],
                                    color: Colors.yellow,
                                  ),
                                )),
                            Tooltip(message: "verbleibende Versuche",
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient:
                                  const LinearGradient(colors: <Color>[Colors.white, Colors.white]),
                                ),
                                height: MediaQuery.of(context).size.height*0.1,
                                padding: EdgeInsets.all(8),
                                textStyle:  TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.width*0.07,
                                ),
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                      shadows: const <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 10.0,
                                        color: Colors.black,
                                      )],
                                        size: MediaQuery.of(context).size.width*0.10,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        lives.toString(),
                                        style: TextStyle(
                                            shadows: const <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 0.0,
                                                color: Colors.black,
                                              ),
                                            ],
                                            color: Colors.black,
                                            fontFamily: "Qaz",
                                            fontSize: MediaQuery.of(context).size.width*0.06,
                                            fontWeight: FontWeight.bold),
                                      ),

                                    ]))
                          ],
                        ),
                        Flexible(child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Flexible(child:
                                AutoSizeText("Kategorie:",style: TextStyle(fontSize: 300, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.lightBlueAccent),textAlign: TextAlign.center, minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                ,SizedBox(width: MediaQuery.of(context).size.width*0.02),
                                Flexible(child:
                                AutoSizeText((widget.category),style: const TextStyle(fontSize: 300, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),textAlign: TextAlign.center, minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                ,SizedBox(width: MediaQuery.of(context).size.width*0.02),
                                Icon(
                                    shadows: const <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                    size: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.04,
                                    color: Colors.black,
                                    IconData(getIcon(), fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter')
                                ),
                              ]
                          ),),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitHeight, image: AssetImage(images_coins[index])),
                            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            color: Colors.transparent,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, MediaQuery.of(context).size.height*0.02, 8, MediaQuery.of(context).size.height*0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [...sword.map((e) => underscore(e,orientation))],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount: 30,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: isNeedSafeArea ? MediaQuery.of(context).size.height*0.065: MediaQuery.of(context).size.height*0.073,
                              mainAxisSpacing: MediaQuery.of(context).size.height*0.01, crossAxisCount: 6),
                          itemBuilder: (context, index) {
                            return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              createButton(alphabets.keys.toList()[index],orientation)
                            ]);
                          },
                        )
                      ],
                    ),
                );
              }
              else {
                return Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Tooltip(message: "zurück zu den Kategorien",
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient:
                                const LinearGradient(colors: <Color>[Colors.white, Colors.white]),
                              ),
                              height: MediaQuery.of(context).size.height*0.05,
                              padding: EdgeInsets.all(8),
                              textStyle:  TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width*0.07,
                              ),
                              child: IconButton(
                                iconSize: MediaQuery.of(context).size.width*0.05,
                                onPressed: (() {
                                  Navigator.pushNamed(context, Routes.categories);
                                }),
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.black,
                                ),
                              )),
                          Tooltip(message: "verbleibende Wörter",
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient:
                                const LinearGradient(colors: <Color>[Colors.white, Colors.white]),
                              ),
                              height: MediaQuery.of(context).size.height*0.05,
                              padding: EdgeInsets.all(8),
                              textStyle:  TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width*0.07,
                              ),
                              child: Text(verbleibendeWorter.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, shadows: const <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 1.0,
                                  color: Colors.black,
                                ),
                              ], color: Colors.lightBlueAccent),maxLines: 1, overflow: TextOverflow.ellipsis)),
                          Tooltip(message: "Punktestand",
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient:
                                const LinearGradient(colors: <Color>[Colors.white, Colors.white]),
                              ),
                              height: MediaQuery.of(context).size.height*0.05,
                              padding: EdgeInsets.all(8),
                              textStyle:  TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width*0.07,
                              ),
                              child: Text(score.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, shadows: const <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 1.0,
                                  color: Colors.green,
                                ),
                              ], color: Colors.green),maxLines: 1, overflow: TextOverflow.ellipsis)),
                          Tooltip(message: "Tipps",
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient:
                                const LinearGradient(colors: <Color>[Colors.white, Colors.white]),
                              ),
                              height: MediaQuery.of(context).size.height*0.05,
                              padding: EdgeInsets.all(8),
                              textStyle:  TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width*0.07,
                              ),
                              child: IconButton(
                                onPressed: (() {
                                  showDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return WillPopScope(
                                          onWillPop: () async => false,
                                          child: AlertDialog(
                                            contentPadding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                                            backgroundColor: Colors.lightBlueAccent,
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: MediaQuery.of(context).size.width*0.01,
                                                    color: Colors.black)),
                                            title: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(
                                                  Icons.lightbulb,
                                                  size: MediaQuery.of(context).size.width*0.05,
                                                  shadows: const <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 0.0),
                                                      blurRadius: 10.0,
                                                      color: Colors.black,
                                                    )],
                                                  color: Colors.yellow,
                                                ),Text(
                                                  "Tipps",
                                                  style: TextStyle(
                                                      shadows: const <Shadow>[
                                                        Shadow(
                                                          offset: Offset(0.0, 0.0),
                                                          blurRadius: 2.0,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                      color: Colors.black,
                                                      fontSize: MediaQuery.of(context).size.width*0.05,
                                                      fontFamily: "Qaz"),
                                                ),Icon(
                                                  Icons.lightbulb,
                                                  size: MediaQuery.of(context).size.width*0.05,
                                                  shadows: const <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 0.0),
                                                      blurRadius: 10.0,
                                                      color: Colors.black,
                                                    )],
                                                  color: Colors.yellow,
                                                )
                                              ],
                                            ),
                                            content: StatefulBuilder(
                                              builder: (BuildContext context, StateSetter setState){
                                                return  SizedBox(
                                                    height: MediaQuery.of(context).size.height*0.9,
                                                    width: MediaQuery.of(context).size.width*0.9,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Column(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                    children: [
                                                                      _isButtonAufgeklappt1 ?
                                                                      Material(
                                                                        color: Colors.transparent,
                                                                        child: Ink(
                                                                            width: MediaQuery.of(context).size.width * 0.35,
                                                                            height: MediaQuery.of(context).size.height * 0.15,
                                                                            decoration: const ShapeDecoration(
                                                                                color: Colors.yellow,
                                                                                shape: RoundedRectangleBorder(
                                                                                    side: BorderSide(
                                                                                        width: 3,
                                                                                        color: Colors.black)
                                                                                )
                                                                            ),
                                                                            child:
                                                                            Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [Flexible(child:
                                                                                AutoSizeText(entryList[randomIndex].value[0],group: mySizeGRP_V3,style: const TextStyle(fontSize: 300, shadows: <Shadow>[
                                                                                  Shadow(
                                                                                    offset: Offset(0.0, 0.0),
                                                                                    blurRadius: 0.0,
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ],fontFamily: "Qaz",color: Colors.black),textAlign: TextAlign.center,minFontSize: 10, maxLines: 2, overflow: TextOverflow.ellipsis))])
                                                                        ),
                                                                      ): const SizedBox.shrink(),
                                                                      SizedBox(height: MediaQuery.of(context).size.height*0.03),
                                                                      _isButtonAufgeklappt2 ?
                                                                      Material(
                                                                        color: Colors.transparent,
                                                                        child: Ink(
                                                                            width: MediaQuery.of(context).size.width * 0.35,
                                                                            height: MediaQuery.of(context).size.height * 0.15,
                                                                            decoration: const ShapeDecoration(
                                                                                color: Colors.yellow,
                                                                                shape: RoundedRectangleBorder(
                                                                                    side: BorderSide(
                                                                                        width: 3,
                                                                                        color: Colors.black)
                                                                                )
                                                                            ),
                                                                            child:
                                                                            Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Flexible(child:
                                                                                  AutoSizeText(entryList[randomIndex].value[1],group: mySizeGRP_V3,style: const TextStyle(fontSize: 300, shadows: <Shadow>[
                                                                                    Shadow(
                                                                                      offset: Offset(0.0, 0.0),
                                                                                      blurRadius: 0.0,
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                  ],fontFamily: "Qaz",color: Colors.black),textAlign: TextAlign.center, minFontSize: 10, maxLines: 2, overflow: TextOverflow.ellipsis))
                                                                                ]
                                                                            )
                                                                        ),
                                                                      ) : const SizedBox.shrink(),
                                                                      SizedBox(height: MediaQuery.of(context).size.height*0.03),
                                                                      ]),
                                                                SizedBox(width: MediaQuery.of(context).size.width*0.03),
                                                                Column(children: [
                                                                  _isButtonAufgeklappt3 ?
                                                                  Material(
                                                                    color: Colors.transparent,
                                                                    child: Ink(
                                                                        width: MediaQuery.of(context).size.width * 0.35,
                                                                        height: MediaQuery.of(context).size.height * 0.15,
                                                                        decoration: const ShapeDecoration(
                                                                            color: Colors.yellow,
                                                                            shape: RoundedRectangleBorder(
                                                                                side: BorderSide(
                                                                                    width: 3,
                                                                                    color: Colors.black)
                                                                            )
                                                                        ),
                                                                        child:
                                                                        Column(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Flexible(child:
                                                                              AutoSizeText(entryList[randomIndex].value[2],group: mySizeGRP_V3,style: const TextStyle(fontSize: 300, shadows: <Shadow>[
                                                                                Shadow(
                                                                                  offset: Offset(0.0, 0.0),
                                                                                  blurRadius: 0.0,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ],fontFamily: "Qaz",color: Colors.black),textAlign: TextAlign.center,minFontSize: 10, maxLines: 2, overflow: TextOverflow.ellipsis))
                                                                            ])
                                                                    ),
                                                                  ) : const SizedBox.shrink(),
                                                                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                                                                  _isButtonAufgeklappt4 ?
                                                                  Material(
                                                                    color: Colors.transparent,
                                                                    child: Ink(
                                                                        width: MediaQuery.of(context).size.width * 0.35,
                                                                        height: MediaQuery.of(context).size.height * 0.15,
                                                                        decoration: const ShapeDecoration(
                                                                            color: Colors.yellow,
                                                                            shape: RoundedRectangleBorder(
                                                                                side: BorderSide(
                                                                                    width: 3,
                                                                                    color: Colors.black)
                                                                            )
                                                                        ),
                                                                        child:
                                                                        Column(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [Flexible(child:
                                                                            AutoSizeText(entryList[randomIndex].value[3],group: mySizeGRP_V3,style: const TextStyle(fontSize: 300, shadows: <Shadow>[
                                                                              Shadow(
                                                                                offset: Offset(0.0, 0.0),
                                                                                blurRadius: 0.0,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ],fontFamily: "Qaz",color: Colors.black),textAlign: TextAlign.center,minFontSize: 10, maxLines:2, overflow: TextOverflow.ellipsis))])
                                                                    ),
                                                                  ) : const SizedBox.shrink(),
                                                                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                                                                ])
                                                              ]
                                                          ),
                                                          _isButtonAufgeklappt4 == false && _isButtonAufgeklappt1 == false ?
                                                          Material(
                                                            color: Colors.transparent,
                                                            child: Ink(
                                                                width: MediaQuery.of(context).size.width * 0.3,
                                                                height: MediaQuery.of(context).size.height * 0.15,
                                                                decoration: ShapeDecoration(color: Colors.white,
                                                                    shape: RoundedRectangleBorder(
                                                                        side: BorderSide(width: MediaQuery.of(context).size.width*0.005, color: Colors.black))),
                                                                child: ElevatedButton(
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      if (_isButtonAufgeklappt1 == true &&
                                                                          _isButtonAufgeklappt2 ==
                                                                              true &&
                                                                          _isButtonAufgeklappt3 ==
                                                                              true &&
                                                                          _isButtonAufgeklappt4 ==
                                                                              false) {
                                                                        _isButtonAufgeklappt4 =
                                                                        true;
                                                                      }
                                                                      if (_isButtonAufgeklappt1 == true &&
                                                                          _isButtonAufgeklappt2 ==
                                                                              true &&
                                                                          _isButtonAufgeklappt3 ==
                                                                              false) {
                                                                        _isButtonAufgeklappt3 =
                                                                        true;
                                                                      }
                                                                      if (_isButtonAufgeklappt1 ==
                                                                          true &&
                                                                          _isButtonAufgeklappt2 ==
                                                                              false) {
                                                                        _isButtonAufgeklappt2 =
                                                                        true;
                                                                      }
                                                                      if (_isButtonAufgeklappt1 ==
                                                                          false) {
                                                                        _isButtonAufgeklappt1 =
                                                                        true;
                                                                      }
                                                                    });
                                                                  },
                                                                  style: ButtonStyle(
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10.0),
                                                                          side: const BorderSide(color: Colors.black))),
                                                                      alignment: Alignment.center,
                                                                      backgroundColor: MaterialStateProperty.resolveWith(
                                                                              (state) {
                                                                            if (state
                                                                                .contains(MaterialState.pressed)) {
                                                                              return Colors.grey;
                                                                            }
                                                                            return Colors
                                                                                .white;
                                                                          }),
                                                                      shadowColor:
                                                                      MaterialStateProperty.all(Colors
                                                                          .transparent),
                                                                      side: MaterialStateProperty.all(
                                                                          const BorderSide(width: 1))),
                                                                  child:
                                                                  AutoSizeText('Tipp anzeigen', style: TextStyle(fontSize: 70,fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                                                )),
                                                          ) : const SizedBox.shrink(),
                                                          _isButtonAufgeklappt1 == true && _isButtonAufgeklappt4 == false ?
                                                          Material(
                                                            color: Colors.transparent,
                                                            child: Ink(
                                                                width: MediaQuery.of(context).size.width * 0.3,
                                                                height: MediaQuery.of(context).size.height * 0.15,
                                                                decoration: ShapeDecoration(color: Colors.white,
                                                                    shape: RoundedRectangleBorder(
                                                                        side: BorderSide(width: MediaQuery.of(context).size.width*0.005, color: Colors.black))),
                                                                child: ElevatedButton(
                                                                  onPressed: () {
                                                                    setState((){
                                                                      if (_isButtonAufgeklappt1 == true && _isButtonAufgeklappt2 == true && _isButtonAufgeklappt3 == true && _isButtonAufgeklappt4 == false){
                                                                        _isButtonAufgeklappt4 = true;
                                                                      }
                                                                      if (_isButtonAufgeklappt1 == true && _isButtonAufgeklappt2 == true && _isButtonAufgeklappt3 == false){
                                                                        _isButtonAufgeklappt3 = true;
                                                                      }
                                                                      if (_isButtonAufgeklappt1 == true && _isButtonAufgeklappt2 == false){
                                                                        _isButtonAufgeklappt2 = true;
                                                                      }
                                                                      if (_isButtonAufgeklappt1 == false){
                                                                        _isButtonAufgeklappt1 = true;
                                                                      }
                                                                    });
                                                                  },
                                                                  style: ButtonStyle(
                                                                      alignment: Alignment.center,
                                                                      backgroundColor: MaterialStateProperty.resolveWith((state) {
                                                                        if (state.contains(MaterialState.pressed)) return Colors.grey;
                                                                        return Colors.white;
                                                                      }),
                                                                      shadowColor: MaterialStateProperty.all(Colors.transparent),
                                                                      side: MaterialStateProperty.all(const BorderSide(width: 1))),
                                                                  child: const AutoSizeText('nächster Tipp', style: TextStyle(fontSize: 70,fontFamily: "Qaz",color: Colors.black),textAlign: TextAlign.center,minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                                                )),
                                                          ) : const SizedBox.shrink(),
                                                          SizedBox(height: MediaQuery.of(context).size.height*0.01),
                                                          Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [Material(
                                                                color: Colors.transparent,
                                                                child: Ink(
                                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                                    height: MediaQuery.of(context).size.height * 0.12,
                                                                    decoration: const ShapeDecoration(
                                                                        color: Colors.white,
                                                                        shape: CircleBorder(
                                                                            side: BorderSide(
                                                                                width: 3,
                                                                                color: Colors.black)
                                                                        )
                                                                    ),
                                                                    child: IconButton(
                                                                        style: ButtonStyle(
                                                                            alignment: Alignment.center,
                                                                            backgroundColor: MaterialStateProperty.resolveWith((state) {
                                                                              if (state.contains(MaterialState.pressed)) return Colors.grey;
                                                                              return Colors.black;
                                                                            }),
                                                                            shadowColor: MaterialStateProperty.all(Colors.transparent),
                                                                            side: MaterialStateProperty.all(const BorderSide(width: 2))),
                                                                        icon: Icon(
                                                                          Icons.cancel_outlined,
                                                                          size: MediaQuery.of(context).size.height*0.04,
                                                                          color: Colors.black,
                                                                        ),
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
                                                                        })
                                                                ),
                                                              )]),
                                                        ])
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      });
                                }),
                                iconSize: MediaQuery.of(context).size.width*0.05,
                                icon: const Icon(
                                  Icons.lightbulb,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 10.0,
                                      color: Colors.black,
                                    )],
                                  color: Colors.yellow,
                                ),
                              )),
                          Tooltip(message: "verbleibende Versuche",
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient:
                                const LinearGradient(colors: <Color>[Colors.white, Colors.white]),
                              ),
                              height: MediaQuery.of(context).size.height*0.05,
                              padding: EdgeInsets.all(8),
                              textStyle:  TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width*0.07,
                              ),
                              child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      shadows: const <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 10.0,
                                          color: Colors.black,
                                        )],
                                      size: MediaQuery.of(context).size.width*0.05,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      lives.toString(),
                                      style: TextStyle(
                                          shadows: const <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 0.0,
                                              color: Colors.black,
                                            ),
                                          ],
                                          color: Colors.black,
                                          fontFamily: "Qaz",
                                          fontSize: MediaQuery.of(context).size.width*0.03,
                                          fontWeight: FontWeight.bold),
                                    ),

                                  ]))
                        ],
                      ),
                      Row(children: [
                        Flexible(
                            child:
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: MediaQuery.of(context).size.width*0.01),
                                   Flexible(child:
                                    AutoSizeText("Kategorie:",style: TextStyle(fontSize: 200, shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 1.0,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ],fontFamily: "Qaz",color: Colors.lightBlueAccent),textAlign: TextAlign.center, minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                    SizedBox(width: MediaQuery.of(context).size.width*0.01),
                                        widget.category.length < 5 ? Flexible(child:
                                    AutoSizeText((widget.category),style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        color: Colors.black,
                                      ),
                                    ],fontFamily: "Qaz",color: Colors.black),textAlign: TextAlign.center, minFontSize: 10,  maxLines: 1, overflow: TextOverflow.ellipsis))
                                            : Flexible(child:
                                        AutoSizeText((widget.category),style: const TextStyle(fontSize: 200, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),textAlign: TextAlign.center, minFontSize: 10,  maxLines: 1, overflow: TextOverflow.ellipsis))
                                        ,
                                        SizedBox(width: MediaQuery.of(context).size.width*0.01),
                                        Icon(
                                        shadows: const <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            color: Colors.black,
                                          ),
                                        ],
                                        size: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.05,
                                        color: Colors.black,
                                        IconData(getIcon(), fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter')
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width*0.01),
                                  ]),
                                  Container(
                                    height: isNeedSafeArea ? MediaQuery.of(context).size.height * 0.5:MediaQuery.of(context).size.height * 0.55,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fitHeight, image: AssetImage(images_coins[index])),
                                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [...sword.map((e) => underscore(e,orientation))],
                                    ),
                                  ),
                                ]),
                            ),
                        Flexible(child:
                            GridView.builder(
                              shrinkWrap: true,
                            itemCount: 30,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: isNeedSafeArea ? MediaQuery.of(context).size.height*0.10: MediaQuery.of(context).size.height*0.13,
                                mainAxisSpacing: MediaQuery.of(context).size.height*0.010, crossAxisCount: 5),
                            itemBuilder: (context, index) {
                              return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    createButton(alphabets.keys.toList()[index],orientation)
                                  ]);
                            },
                          )
                        )
                      ])
                    ],
                  ),
                );
              }
            }),
          )),
    );
  }
}


