import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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


  //Nächstes Wort
  void newGame() {
    setState(() {
      alphabets.updateAll((key, value) => value = 0);
      index = 0;
      getCategory();
      sword = List.generate(randomWord.length, (index) => "_");
      checkForHelp();
      stored = randomWord;
      progressSafer[randomWord] = [0,0];          //erster eintrag richtig/falsch, zweiter wie viele Hilfen benötigt
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
      case Category.Resteraunt:
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
      case Category.All:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == allMAP.length)){
            wordList = List<int>.generate(allMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = allMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfallMAP.length)){
            wordList = List<int>.generate(hfallMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfallMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfallMAP.length)){
            wordList = List<int>.generate(nfallMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = nfallMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Autoteile:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == autoteileMAP.length)){
            wordList = List<int>.generate(autoteileMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = autoteileMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfAutoteileMAP.length)){
            wordList = List<int>.generate(hfAutoteileMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfAutoteileMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfAutoteileMAP.length)){
            wordList = List<int>.generate(nfAutoteileMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
           wordList = List<int>.generate(badezimmerMAP.length, (int index) => index);
           wordList.shuffle();
         }
         randomIndex = wordList[wordListCounter];
         entryList = badezimmerMAP.entries.toList();
         randomWord = entryList[randomIndex].key;
         wordListCounter++;
         break;
       }
       if(settings.value == 'Hochfrequente Wörter'){
         if(!(wordList.length == hfBadezimmerMAP.length)){
           wordList = List<int>.generate(hfBadezimmerMAP.length, (int index) => index);
           wordList.shuffle();
         }
         randomIndex = wordList[wordListCounter];
         entryList = hfBadezimmerMAP.entries.toList();
         randomWord = entryList[randomIndex].key;
         wordListCounter++;
         break;
       }
       if(settings.value == 'Niedrigfrequente Wörter'){
         if(!(wordList.length == nfBadezimmerMAP.length)){
           wordList = List<int>.generate(nfBadezimmerMAP.length, (int index) => index);
           wordList.shuffle();
         }
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
            wordList = List<int>.generate(bauernhofMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = bauernhofMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfBauernhofMAP.length)){
            wordList = List<int>.generate(hfBauernhofMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfBauernhofMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfBauernhofMAP.length)){
            wordList = List<int>.generate(nfBauernhofMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(berufeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = berufeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfBerufeMAP.length)){
            wordList = List<int>.generate(hfBerufeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfBerufeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfBerufeMAP.length)){
            wordList = List<int>.generate(nfBerufeMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(deutscheStaedteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = deutscheStaedteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfDeutscheStaedteMAP.length)){
            wordList = List<int>.generate(hfDeutscheStaedteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfDeutscheStaedteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfDeutscheStaedteMAP.length)){
            wordList = List<int>.generate(nfDeutscheStaedteMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(fahrzeugeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = fahrzeugeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfFahrzeugeMAP.length)){
            wordList = List<int>.generate(hfFahrzeugeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfFahrzeugeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfFahrzeugeMAP.length)){
            wordList = List<int>.generate(nfFahrzeugeMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(gartenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = gartenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfGartenMAP.length)){
            wordList = List<int>.generate(hfGartenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfGartenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfGartenMAP.length)){
            wordList = List<int>.generate(nfGartenMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(gemueseMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = gemueseMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfGemueseMAP.length)){
            wordList = List<int>.generate(hfGemueseMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfGemueseMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfGemueseMAP.length)){
            wordList = List<int>.generate(nfGemueseMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(getraenkeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = getraenkeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfGetraenkeMAP.length)){
            wordList = List<int>.generate(hfGetraenkeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfGetraenkeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfGetraenkeMAP.length)){
            wordList = List<int>.generate(nfGetraenkeMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(hauptstaedteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hauptstaedteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfHauptstaedteMAP.length)){
            wordList = List<int>.generate(hfHauptstaedteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfHauptstaedteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfHauptstaedteMAP.length)){
            wordList = List<int>.generate(nfHauptstaedteMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(hausbauMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hausbauMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfHausbauMAP.length)){
            wordList = List<int>.generate(hfHausbauMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfHausbauMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfHausbauMAP.length)){
            wordList = List<int>.generate(nfHausbauMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(hobbysMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hobbysMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfHobbysMAP.length)){
            wordList = List<int>.generate(hfHobbysMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfHobbysMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfHobbysMAP.length)){
            wordList = List<int>.generate(nfHobbysMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(kleidungMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = kleidungMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfKleidungMAP.length)){
            wordList = List<int>.generate(hfKleidungMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfKleidungMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfKleidungMAP.length)){
            wordList = List<int>.generate(nfKleidungMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(koerperteileMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = koerperteileMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfKoerperteileMAP.length)){
            wordList = List<int>.generate(hfKoerperteileMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfKoerperteileMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfKoerperteileMAP.length)){
            wordList = List<int>.generate(nfKoerperteileMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(kuecheMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = kuecheMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfKuecheMAP.length)){
            wordList = List<int>.generate(hfKuecheMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfKuecheMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfKuecheMAP.length)){
            wordList = List<int>.generate(nfKuecheMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(laenderMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = laenderMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfLaenderMAP.length)){
            wordList = List<int>.generate(hfLaenderMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfLaenderMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfLaenderMAP.length)){
            wordList = List<int>.generate(nfLaenderMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(moebelMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = moebelMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfMoebelMAP.length)){
            wordList = List<int>.generate(hfMoebelMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfMoebelMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfMoebelMAP.length)){
            wordList = List<int>.generate(nfMoebelMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(musikinstrumenteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = musikinstrumenteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfMusikinstrumenteMAP.length)){
            wordList = List<int>.generate(hfMusikinstrumenteMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfMusikinstrumenteMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfMusikinstrumenteMAP.length)){
            wordList = List<int>.generate(nfMusikinstrumenteMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(obstMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = obstMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfObstMAP.length)){
            wordList = List<int>.generate(hfObstMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfObstMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfObstMAP.length)){
            wordList = List<int>.generate(nfObstMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(pflanzenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = pflanzenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfPflanzenMAP.length)){
            wordList = List<int>.generate(hfPflanzenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfPflanzenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfPflanzenMAP.length)){
            wordList = List<int>.generate(nfPflanzenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = nfPflanzenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Resteraunt:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == resterauntMAP.length)){
            wordList = List<int>.generate(resterauntMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = resterauntMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfResterauntMAP.length)){
            wordList = List<int>.generate(hfResterauntMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfResterauntMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfResterauntMAP.length)){
            wordList = List<int>.generate(nfResterauntMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = nfResterauntMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        break;
      case Category.Sportarten:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == sportartenMAP.length)){
            wordList = List<int>.generate(sportartenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = sportartenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfSportartenMAP.length)){
            wordList = List<int>.generate(hfSportartenMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfSportartenMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfSportartenMAP.length)){
            wordList = List<int>.generate(nfSportartenMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(strassenverkehrMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = strassenverkehrMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfStrassenverkehrMAP.length)){
            wordList = List<int>.generate(hfStrassenverkehrMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfStrassenverkehrMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfStrassenverkehrMAP.length)){
            wordList = List<int>.generate(nfStrassenverkehrMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(supermarktMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = supermarktMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfSupermarktMAP.length)){
            wordList = List<int>.generate(hfSupermarktMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfSupermarktMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfSupermarktMAP.length)){
            wordList = List<int>.generate(nfSupermarktMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(tiereMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = tiereMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfTiereMAP.length)){
            wordList = List<int>.generate(hfTiereMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfTiereMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfTiereMAP.length)){
            wordList = List<int>.generate(nfTiereMAP.length, (int index) => index);
            wordList.shuffle();
          }
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
            wordList = List<int>.generate(werkzeugeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = werkzeugeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfWerkzeugeMAP.length)){
            wordList = List<int>.generate(hfWerkzeugeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          entryList = hfWerkzeugeMAP.entries.toList();
          randomWord = entryList[randomIndex].key;
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfWerkzeugeMAP.length)){
            wordList = List<int>.generate(nfWerkzeugeMAP.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfWerkzeugeMAP[randomIndex];
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
        case Category.Resteraunt:
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
  Widget underscore(String chr) {
    return Text(
      "$chr ",
      style: const TextStyle(
          shadows: <Shadow>[
            Shadow(
              offset: Offset(0.0, 0.0),
              blurRadius: 2.0,
              color: Colors.black,
            ),
          ],
        // fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: "PlatNomo",
          fontSize: 30),
    );
  }

  //Buchstaben-Buttons
  Widget alphaContainer(var name, Color color) {
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
      width: 50,
      child: Text(
        name,
        style: const TextStyle(
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 2.0,
                color: Colors.black,
              ),
            ],
           //fontWeight: FontWeight.w100,
            color: Colors.black,
            fontFamily: "Qaz",
            fontSize: 30),
      ),
    );
  }

  //erstelle Buttons
  Widget createButton(var name) {
    return alphabets[name] == 0
        ? InkWell(
       //splashColor: Colors.deepOrange,
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
                if (!randomWord.contains(RegExp(r'[a-z]'))) {                             //und dieser Buchstabe der letzte Buchstabe der Wortes ist..
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
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover, image: _imageToShow),
                                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                        color: Colors.black,
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: Ink(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          height: MediaQuery.of(context).size.height * 0.13,
                                          decoration: const ShapeDecoration(
                                              color: Colors.lightGreenAccent,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 3,
                                                      color: Colors.black)
                                              )
                                          ),
                                          child: Column(
                                            children: [
                                              const Icon(
                                                Icons.check_circle_outlined,
                                                color: Colors.black,
                                                size: 40,
                                              ),
                                              Container(
                                                  height: MediaQuery.of(context).size.height * 0.01
                                              ),
                                              Text(
                                                stored.toString(),
                                                style: const TextStyle(
                                                  fontFamily: "Qaz",
                                                  fontSize: 40,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: Ink(
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          height: MediaQuery.of(context).size.height * 0.1,
                                          decoration: const ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 3,
                                                      color: Colors.black)
                                              )
                                          ),
                                          child: Column(
                                            children: [
                                              const Text(
                                                "Glückwunsch",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Qaz",
                                                    fontSize: 40),
                                              ),
                                              Container(
                                                  height: MediaQuery.of(context).size.height * 0.01
                                              ),
                                              const Text(
                                                "Alle Wörter durchgespielt!",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Qaz",
                                                    fontSize: 20),
                                              ),
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
                                              width: 50,
                                              height: 50,
                                              decoration: const ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: CircleBorder(
                                                      side: BorderSide(
                                                          width: 3,
                                                          color: Colors.black)
                                                  )
                                              ),
                                              child: IconButton(
                                                  icon: const Icon(
                                                    IconData(0xe4cb, fontFamily: 'MaterialIcons'),
                                                    size: 30,
                                                    color: Colors.black,
                                                  ),
                                                  onPressed: () {
                                                    DBHelper.insert('SCORE2', {
                                                      'date': context.read<SettingsController>().playerName.value,
                                                      'score': score,
                                                      'diff': context.read<SettingsController>().schwierigkeit.value
                                                    });
                                                    Navigator.pushNamed(context, Routes.categories);
                                                  })
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: Ink(
                                              width: 50,
                                              height: 50,
                                              decoration: const ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: CircleBorder(
                                                      side: BorderSide(
                                                          width: 3,
                                                          color: Colors.black)
                                                  )
                                              ),
                                              child: IconButton(
                                                  icon: const Icon(
                                                    IconData(0xe7ca, fontFamily: 'MaterialIcons'),
                                                    size: 30,
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
                                                    Navigator.pushNamed(context, Routes.infopage, arguments: progressSafer);
                                                  })
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            )
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
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.5,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover, image: _imageToShow),
                                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                        color: Colors.black,
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: Ink(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          height: MediaQuery.of(context).size.height * 0.13,
                                          decoration: const ShapeDecoration(
                                              color: Colors.lightGreenAccent,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 3,
                                                      color: Colors.black)
                                              )
                                          ),
                                          child: Column(
                                            children: [
                                              const Icon(
                                                Icons.check_circle_outlined,
                                                color: Colors.black,
                                                size: 40,
                                              ),
                                              Container(
                                                  height: MediaQuery.of(context).size.height * 0.01
                                              ),
                                              Text(
                                                stored.toString(),
                                                style: const TextStyle(
                                                  fontFamily: "Qaz",
                                                  fontSize: 40,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: Ink(
                                          width: 50,
                                          height: 50,
                                          decoration: const ShapeDecoration(
                                              color: Colors.white,
                                              shape: CircleBorder(
                                                  side: BorderSide(
                                                      width: 3,
                                                      color: Colors.black)
                                              )
                                          ),
                                          child: IconButton(
                                              icon: const Icon(
                                                Icons.arrow_forward_sharp,
                                                size: 30,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                progressSafer.update(stored, (value) => [1,0]);            //korektes Wort (azahl hilfe ist in newGame())
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
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover, image: _imageToShow),
                                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                        color: Colors.black,
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: Ink(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          height: MediaQuery.of(context).size.height * 0.13,
                                          decoration: const ShapeDecoration(
                                              color: Colors.redAccent,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 3,
                                                      color: Colors.black)
                                              )
                                          ),
                                          child: Column(
                                            children: [
                                              const Icon(
                                                Icons.remove_circle_outline_rounded,
                                                color: Colors.black,
                                                size: 40,
                                              ),
                                              Container(
                                                  height: MediaQuery.of(context).size.height * 0.01
                                              ),
                                              Text(
                                                stored.toString(),
                                                style: const TextStyle(
                                                  fontFamily: "Qaz",
                                                  fontSize: 40,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: Ink(
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          height: MediaQuery.of(context).size.height * 0.1,
                                          decoration: const ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 3,
                                                      color: Colors.black)
                                              )
                                          ),
                                          child: Column(
                                            children: [
                                              const Text(
                                                "ENDE",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Qaz",
                                                    fontSize: 40),
                                              ),
                                              Container(
                                                  height: MediaQuery.of(context).size.height * 0.01
                                              ),
                                              const Text(
                                                "Alle Herzen aufgebraucht!",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Qaz",
                                                    fontSize: 20),
                                              ),
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
                                              width: 50,
                                              height: 50,
                                              decoration: const ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: CircleBorder(
                                                      side: BorderSide(
                                                          width: 3,
                                                          color: Colors.black)
                                                  )
                                              ),
                                              child: IconButton(
                                                  icon: const Icon(
                                                    IconData(0xe4cb, fontFamily: 'MaterialIcons'),
                                                    size: 30,
                                                    color: Colors.black,
                                                  ),
                                                  onPressed: () {
                                                      DBHelper.insert('SCORE2', {
                                                        'date': context.read<SettingsController>().playerName.value,
                                                        'score': score,
                                                        'diff': context.read<SettingsController>().schwierigkeit.value
                                                      });
                                                    Navigator.pushNamed(context, Routes.categories);
                                                  })
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: Ink(
                                              width: 50,
                                              height: 50,
                                              decoration: const ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: CircleBorder(
                                                      side: BorderSide(
                                                          width: 3,
                                                          color: Colors.black)
                                                  )
                                              ),
                                              child: IconButton(
                                                  icon: const Icon(
                                                    IconData(0xe7ca, fontFamily: 'MaterialIcons'),
                                                    size: 30,
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
                                                    Navigator.pushNamed(context, Routes.infopage, arguments: progressSafer);
                                                  })
                                          ),
                                        ),
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
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.3,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover, image: _imageToShow),
                                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                          color: Colors.black,
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Ink(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            height: MediaQuery.of(context).size.height * 0.13,
                                            decoration: const ShapeDecoration(
                                                color: Colors.redAccent,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 3,
                                                        color: Colors.black)
                                                )
                                            ),
                                            child: Column(
                                              children: [
                                                const Icon(
                                                  Icons.remove_circle_outline_rounded,
                                                  color: Colors.black,
                                                  size: 40,
                                                ),
                                                Container(
                                                    height: MediaQuery.of(context).size.height * 0.01
                                                ),
                                                Text(
                                                  stored.toString(),
                                                  style: const TextStyle(
                                                    fontFamily: "Qaz",
                                                    fontSize: 40,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Ink(
                                            width: MediaQuery.of(context).size.width * 0.8,
                                            height: MediaQuery.of(context).size.height * 0.1,
                                            decoration: const ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 3,
                                                        color: Colors.black)
                                                )
                                            ),
                                            child: Column(
                                              children: [
                                                const Text(
                                                  "Glückwunsch",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "Qaz",
                                                      fontSize: 40),
                                                ),
                                                Container(
                                                    height: MediaQuery.of(context).size.height * 0.01
                                                ),
                                                const Text(
                                                  "Alle Wörter durchgespielt!",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "Qaz",
                                                      fontSize: 20),
                                                ),
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
                                                width: 50,
                                                height: 50,
                                                decoration: const ShapeDecoration(
                                                    color: Colors.white,
                                                    shape: CircleBorder(
                                                        side: BorderSide(
                                                            width: 3,
                                                            color: Colors.black)
                                                    )
                                                ),
                                                child: IconButton(
                                                    icon: const Icon(
                                                      IconData(0xe4cb, fontFamily: 'MaterialIcons'),
                                                      size: 30,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      DBHelper.insert('SCORE2', {
                                                        'date': context.read<SettingsController>().playerName.value,
                                                        'score': score,
                                                        'diff': context.read<SettingsController>().schwierigkeit.value
                                                      });
                                                      Navigator.pushNamed(context, Routes.categories);
                                                    })
                                            ),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            child: Ink(
                                                width: 50,
                                                height: 50,
                                                decoration: const ShapeDecoration(
                                                    color: Colors.white,
                                                    shape: CircleBorder(
                                                        side: BorderSide(
                                                            width: 3,
                                                            color: Colors.black)
                                                    )
                                                ),
                                                child: IconButton(
                                                    icon: const Icon(
                                                      IconData(0xe7ca, fontFamily: 'MaterialIcons'),
                                                      size: 30,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      DBHelper.insert('SCORE2', {
                                                        'date': context.read<SettingsController>().playerName.value,
                                                        'score': score,
                                                        'diff': context.read<SettingsController>().schwierigkeit.value
                                                      });
                                                      checkForHelp();
                                                      Navigator.pushNamed(context, Routes.infopage, arguments: progressSafer);
                                                    })
                                            ),
                                          ),
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
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.5,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover, image: _imageToShow),
                                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                          color: Colors.black,
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Ink(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            height: MediaQuery.of(context).size.height * 0.13,
                                            decoration: const ShapeDecoration(
                                                color: Colors.redAccent,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 3,
                                                        color: Colors.black)
                                                )
                                            ),
                                            child: Column(
                                              children: [
                                                const Icon(
                                                  Icons.remove_circle_outline_rounded,
                                                  color: Colors.black,
                                                  size: 40,
                                                ),
                                                Container(
                                                    height: MediaQuery.of(context).size.height * 0.01
                                                ),
                                                Text(
                                                  stored.toString(),
                                                  style: const TextStyle(
                                                    fontFamily: "Qaz",
                                                    fontSize: 40,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Ink(
                                            width: 50,
                                            height: 50,
                                            decoration: const ShapeDecoration(
                                                color: Colors.white,
                                                shape: CircleBorder(
                                                    side: BorderSide(
                                                        width: 3,
                                                        color: Colors.black)
                                                )
                                            ),
                                            child: IconButton(
                                                icon: const Icon(
                                                  Icons.arrow_forward_sharp,
                                                  size: 30,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
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
        ))
        : alphaContainer(name, Colors.blueGrey);
  }

  //Haupt build Widget
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    40 -
                    MediaQuery.of(context).padding.top,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: (() {
                            Navigator.pushNamed(context, Routes.categories);
                          }),
                          icon: const Icon(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 2.0,
                                color: Colors.black,
                              ),
                            ],
                            Icons.arrow_back_ios_new,
                            size: 35,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          score.toString(),
                          style: const TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 2.0,
                                  color: Colors.lightBlueAccent,
                                ),
                              ],
                              color: Colors.lightBlueAccent,
                              fontSize: 40,
                              fontFamily: "Qaz"),
                        ),
                        IconButton(
                          onPressed: (() {
                            showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return WillPopScope(
                                    onWillPop: () async => false,
                                    child: AlertDialog(
                                      backgroundColor: Colors.lightBlueAccent,
                                      shape: const RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 3,
                                              color: Colors.black)),
                                    icon: const Icon(
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 2.0,
                                          color: Colors.black,
                                        ),
                                      ],
                                      Icons.lightbulb,
                                      size: 50,
                                      color: Colors.black,
                                    ),
                                      title: const Text(
                                        "Hilfe",
                                        style: TextStyle(
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 2.0,
                                                color: Colors.black,
                                              ),
                                            ],
                                            color: Colors.black,
                                            fontSize: 35,
                                            fontFamily: "Qaz"),
                                      ),
                                      content: StatefulBuilder(
                                        builder: (BuildContext context, StateSetter setState){
                                          return  SizedBox(
                                            height: 800,
                                            child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                                children: <Widget>[
                                                  _isButtonAufgeklappt1 ?
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: Ink(
                                                        width: MediaQuery.of(context).size.width * 0.8,
                                                        height: MediaQuery.of(context).size.height * 0.12,
                                                        decoration: const ShapeDecoration(
                                                            color: Colors.yellow,
                                                            shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                    width: 3,
                                                                    color: Colors.black)
                                                            )
                                                        ),
                                                        child: Column(
                                                            children: [
                                                              Row(
                                                                children:  const [
                                                                  Text(
                                                                    "Tipp 1:",
                                                                    style: TextStyle(
                                                                        shadows: <Shadow>[
                                                                          Shadow(
                                                                            offset: Offset(0.0, 0.0),
                                                                            blurRadius: 2.0,
                                                                            color: Colors.black,
                                                                          ),
                                                                        ],
                                                                        // fontWeight: FontWeight.bold,
                                                                        color: Colors.black,
                                                                        fontFamily: "Qaz",
                                                                        fontSize: 20),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                entryList[randomIndex].value[0],
                                                                style: const TextStyle(
                                                                    shadows: <Shadow>[
                                                                      Shadow(
                                                                        offset: Offset(0.0, 0.0),
                                                                        blurRadius: 2.0,
                                                                        color: Colors.black,
                                                                      ),
                                                                    ],
                                                                    // fontWeight: FontWeight.bold,
                                                                    color: Colors.black,
                                                                    fontFamily: "Qaz",
                                                                    fontSize: 25),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ]
                                                        )
                                                    ),
                                                  ): Container(),
                                                  _isButtonAufgeklappt2 ?
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: Ink(
                                                        width: MediaQuery.of(context).size.width * 0.8,
                                                        height: MediaQuery.of(context).size.height * 0.12,
                                                        decoration: const ShapeDecoration(
                                                            color: Colors.yellow,
                                                            shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                    width: 3,
                                                                    color: Colors.black)
                                                            )
                                                        ),
                                                        child: Column(
                                                            children: [
                                                              Row(
                                                                children:  const [
                                                                  Text(
                                                                    "Tipp 2:",
                                                                    style: TextStyle(
                                                                        shadows: <Shadow>[
                                                                          Shadow(
                                                                            offset: Offset(0.0, 0.0),
                                                                            blurRadius: 2.0,
                                                                            color: Colors.black,
                                                                          ),
                                                                        ],
                                                                        // fontWeight: FontWeight.bold,
                                                                        color: Colors.black,
                                                                        fontFamily: "Qaz",
                                                                        fontSize: 20),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                entryList[randomIndex].value[1],
                                                                style: const TextStyle(
                                                                    shadows: <Shadow>[
                                                                      Shadow(
                                                                        offset: Offset(0.0, 0.0),
                                                                        blurRadius: 2.0,
                                                                        color: Colors.black,
                                                                      ),
                                                                    ],
                                                                    // fontWeight: FontWeight.bold,
                                                                    color: Colors.black,
                                                                    fontFamily: "Qaz",
                                                                    fontSize: 25),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ]
                                                        )
                                                    ),
                                                  ) : Container(),
                                                  _isButtonAufgeklappt3 ?
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: Ink(
                                                        width: MediaQuery.of(context).size.width * 0.8,
                                                        height: MediaQuery.of(context).size.height * 0.13,
                                                        decoration: const ShapeDecoration(
                                                            color: Colors.yellow,
                                                            shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                    width: 3,
                                                                    color: Colors.black)
                                                            )
                                                        ),
                                                        child: Column(
                                                            children: [
                                                              Row(
                                                                children:  const [
                                                                  Text(
                                                                    "Tipp 3:",
                                                                    style: TextStyle(
                                                                        shadows: <Shadow>[
                                                                          Shadow(
                                                                            offset: Offset(0.0, 0.0),
                                                                            blurRadius: 2.0,
                                                                            color: Colors.black,
                                                                          ),
                                                                        ],
                                                                        // fontWeight: FontWeight.bold,
                                                                        color: Colors.black,
                                                                        fontFamily: "Qaz",
                                                                        fontSize: 20),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                entryList[randomIndex].value[2],
                                                                style: const TextStyle(
                                                                    shadows: <Shadow>[
                                                                      Shadow(
                                                                        offset: Offset(0.0, 0.0),
                                                                        blurRadius: 2.0,
                                                                        color: Colors.black,
                                                                      ),
                                                                    ],
                                                                    // fontWeight: FontWeight.bold,
                                                                    color: Colors.black,
                                                                    fontFamily: "Qaz",
                                                                    fontSize: 25),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ]
                                                        )
                                                    ),
                                                  ) : Container(),
                                                  _isButtonAufgeklappt4 ?
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: Ink(
                                                        width: MediaQuery.of(context).size.width * 0.8,
                                                        height: MediaQuery.of(context).size.height * 0.13,
                                                        decoration: const ShapeDecoration(
                                                            color: Colors.yellow,
                                                            shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                    width: 3,
                                                                    color: Colors.black)
                                                            )
                                                        ),
                                                        child: Column(
                                                            children: [
                                                              Row(
                                                                children:  const [
                                                                  Text(
                                                                    "Tipp 4:",
                                                                    style: TextStyle(
                                                                        shadows: <Shadow>[
                                                                          Shadow(
                                                                            offset: Offset(0.0, 0.0),
                                                                            blurRadius: 2.0,
                                                                            color: Colors.black,
                                                                          ),
                                                                        ],
                                                                        // fontWeight: FontWeight.bold,
                                                                        color: Colors.black,
                                                                        fontFamily: "Qaz",
                                                                        fontSize: 20),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                entryList[randomIndex].value[3],
                                                                style: const TextStyle(
                                                                    shadows: <Shadow>[
                                                                      Shadow(
                                                                        offset: Offset(0.0, 0.0),
                                                                        blurRadius: 2.0,
                                                                        color: Colors.black,
                                                                      ),
                                                                    ],
                                                                    // fontWeight: FontWeight.bold,
                                                                    color: Colors.black,
                                                                    fontFamily: "Qaz",
                                                                    fontSize: 25),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ]
                                                        )
                                                    ),
                                                  ) : Container(),
                                                  _isButtonAufgeklappt4 == false && _isButtonAufgeklappt1 == false ?
                                                    Material(

                                                    color: Colors.transparent,
                                          child: Ink(
                                                              width: MediaQuery.of(context).size.width * 0.8,
                                                              height: MediaQuery.of(context).size.height * 0.1,
                                                              decoration: const ShapeDecoration(color: Colors.white,
                                                                  shape: RoundedRectangleBorder(
                                                                      side: BorderSide(width: 3, color: Colors.black))),
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
                                                                              .contains(MaterialState.pressed))
                                                                            return Colors.grey;
                                                                          return Colors
                                                                              .white;
                                                                        }),
                                                                        shadowColor:
                                                                            MaterialStateProperty.all(Colors
                                                                                .transparent),
                                                                        side: MaterialStateProperty.all(
                                                                            const BorderSide(width: 2))),
                                                                child:
                                                                    const Text(
                                                                  "Tipp anzeigen",
                                                                  style: TextStyle(
                                                                      shadows: <Shadow>[
                                                                        Shadow(
                                                                          offset: Offset(
                                                                              0.0,
                                                                              0.0),
                                                                          blurRadius:
                                                                              2.0,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ],
                                                                      // fontWeight: FontWeight.bold,
                                                                      color: Colors.black,
                                                                      fontFamily: "Qaz",
                                                                      fontSize: 30),
                                                                ),
                                                              )),
                                                        )
                                                      : Container(),
                                                  _isButtonAufgeklappt1 == true && _isButtonAufgeklappt4 == false ?
                                                  ElevatedButton(
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
                                                        alignment: Alignment.centerLeft,
                                                        backgroundColor: MaterialStateProperty.resolveWith((state) {
                                                          if (state.contains(MaterialState.pressed)) return Colors.grey;
                                                          return Colors.white;
                                                        }),
                                                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                                                        side: MaterialStateProperty.all(const BorderSide(width: 2))),
                                                    child: const Text(
                                                      "nächster Tipp",
                                                      style: TextStyle(
                                                          shadows: <Shadow>[
                                                            Shadow(
                                                              offset: Offset(0.0, 0.0),
                                                              blurRadius: 2.0,
                                                              color: Colors.black,
                                                            ),
                                                          ],
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                          fontFamily: "Qaz",
                                                          fontSize: 30),
                                                    ),
                                                  ): Container(),
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: Ink(
                                                        width: 50,
                                                        height: 50,
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
                                                                alignment: Alignment.centerLeft,
                                                                backgroundColor: MaterialStateProperty.resolveWith((state) {
                                                                  if (state.contains(MaterialState.pressed)) return Colors.grey;
                                                                  return Colors.black;
                                                                }),
                                                                shadowColor: MaterialStateProperty.all(Colors.transparent),
                                                                side: MaterialStateProperty.all(const BorderSide(width: 2))),
                                                            icon: const Icon(
                                                              Icons.cancel_sharp,
                                                              size: 25,
                                                              color: Colors.black,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            })
                                                    ),
                                                  ),
                                                ]),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                });
                          }),
                          icon: const Icon(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 2.0,
                                color: Colors.black,
                              ),
                            ],
                            Icons.lightbulb,
                            size: 35,
                            color: Colors.black,
                          ),
                        ),
                        Stack(
                            alignment: Alignment.center,
                            children: [
                          const Icon(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 2.0,
                                color: Colors.lightBlueAccent,
                              ),
                            ],
                            Icons.favorite,
                            size: 50,
                            color: Colors.lightBlueAccent,
                          ),
                         Text(
                              lives.toString(),
                              style: const TextStyle(
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      color: Colors.black,
                                    ),
                                  ],
                                color: Colors.black,
                                  fontFamily: "Qaz",
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),

                        ])
                      ],
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                        children: [
                          const Text(
                            ("Kategorie: "),
                            style: TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 2.0,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ],
                                color: Colors.lightBlueAccent,
                                fontFamily: "Qaz",
                                fontSize: 25),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            (widget.category),
                            style: const TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 2.0,
                                    color: Colors.black,
                                  ),
                                ],
                                color: Colors.black,
                                fontFamily: "Qaz",
                                fontSize: 25),
                          ),
                          const SizedBox(width: 10),
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
                                  .height * 0.03,
                              color: Colors.black,
                              IconData(getIcon(), fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter')
                          ),]
                    ),
                    ),
                    images[index],
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [...sword.map((e) => underscore(e))],
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: 30,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10, crossAxisCount: 6),
                      itemBuilder: (context, index) {
                        return Row(children: [
                          createButton(alphabets.keys.toList()[index])
                        ]);
                      },
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
