import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortschatz/model/words/hf_words.dart';
import 'package:wortschatz/model/constants/routes.dart';
import 'package:wortschatz/model/db_helper.dart';
import 'package:wortschatz/view/settings_view.dart';
import 'package:wortschatz/viewmodels/router/app_router.dart';
import '../model/constants/categories.dart';
import '../model/dummy_data.dart';
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
  late AssetImage _imageToShow;
  final _name = TextEditingController();
  late String stored;
  int lives = 3;
  int score = 0;
  var index = 0;
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
      stored = randomWord;
      _imageToShow = AssetImage('assets/images/Wörter/$stored.jpg');
      print(randomWord);
      print(wordList);
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
    sword = List.generate(randomWord.length, (index) => "_");
    stored = randomWord;
    _imageToShow = AssetImage('assets/images/Wörter/$stored.jpg');
    print(randomWord);
    print(wordList);
  }

  void getCategory(){
    final settings = context.read<SettingsController>().frequency;
    switch(widget.category){
      case Category.All:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == all.length)){
            wordList = List<int>.generate(all.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = all[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfall.length)){
            wordList = List<int>.generate(hfall.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfall[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfall.length)){
            wordList = List<int>.generate(nfall.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfAutoteile[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Autoteile:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == autoteile.length)){
            wordList = List<int>.generate(autoteile.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = autoteile[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfAutoteile.length)){
            wordList = List<int>.generate(hfAutoteile.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfAutoteile[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfAutoteile.length)){
            wordList = List<int>.generate(nfAutoteile.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfAutoteile[randomIndex];
          wordListCounter++;
          break;
        }
        break;
     case Category.Badezimmer:
       if(settings.value == 'Alle Wörter'){
         if(!(wordList.length == badezimmer.length)){
           wordList = List<int>.generate(badezimmer.length, (int index) => index);
           wordList.shuffle();
         }
         randomIndex = wordList[wordListCounter];
         randomWord = badezimmer[randomIndex];
         wordListCounter++;
         break;
       }
       if(settings.value == 'Hochfrequente Wörter'){
         if(!(wordList.length == hfBadezimmer.length)){
           wordList = List<int>.generate(hfBadezimmer.length, (int index) => index);
           wordList.shuffle();
         }
         randomIndex = wordList[wordListCounter];
         randomWord = hfBadezimmer[randomIndex];
         wordListCounter++;
         break;
       }
       if(settings.value == 'Niedrigfrequente Wörter'){
         if(!(wordList.length == nfBadezimmer.length)){
           wordList = List<int>.generate(nfBadezimmer.length, (int index) => index);
           wordList.shuffle();
         }
         randomIndex = wordList[wordListCounter];
         randomWord = nfBadezimmer[randomIndex];
         wordListCounter++;
         break;
       }
       break;
      case Category.Bauernhof:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == bauernhof.length)){
            wordList = List<int>.generate(bauernhof.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = bauernhof[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfBauernhof.length)){
            wordList = List<int>.generate(hfBauernhof.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfBauernhof[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfBauernhof.length)){
            wordList = List<int>.generate(nfBauernhof.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfBauernhof[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Berufe:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == berufe.length)){
            wordList = List<int>.generate(berufe.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = berufe[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfBerufe.length)){
            wordList = List<int>.generate(hfBerufe.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfBerufe[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfBerufe.length)){
            wordList = List<int>.generate(nfBerufe.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfBerufe[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.DeutscheStaedte:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == deutscheStaedte.length)){
            wordList = List<int>.generate(deutscheStaedte.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = deutscheStaedte[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfDeutscheStaedte.length)){
            wordList = List<int>.generate(hfDeutscheStaedte.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfDeutscheStaedte[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfDeutscheStaedte.length)){
            wordList = List<int>.generate(nfDeutscheStaedte.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfDeutscheStaedte[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Fahrzeuge:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == fahrzeuge.length)){
            wordList = List<int>.generate(fahrzeuge.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = fahrzeuge[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfFahrzeuge.length)){
            wordList = List<int>.generate(hfFahrzeuge.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfFahrzeuge[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfFahrzeuge.length)){
            wordList = List<int>.generate(nfFahrzeuge.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfFahrzeuge[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Garten:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == garten.length)){
            wordList = List<int>.generate(garten.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = garten[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfGarten.length)){
            wordList = List<int>.generate(hfGarten.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfGarten[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfGarten.length)){
            wordList = List<int>.generate(nfGarten.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfGarten[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Gemuese:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == gemuese.length)){
            wordList = List<int>.generate(gemuese.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = gemuese[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfGemuese.length)){
            wordList = List<int>.generate(hfGemuese.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfGemuese[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfGemuese.length)){
            wordList = List<int>.generate(nfGemuese.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfGemuese[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Getraenke:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == getraenke.length)){
            wordList = List<int>.generate(getraenke.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = getraenke[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfGetraenke.length)){
            wordList = List<int>.generate(hfGetraenke.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfGetraenke[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfGetraenke.length)){
            wordList = List<int>.generate(nfGetraenke.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfGetraenke[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Hauptstaedte:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == hauptstaedte.length)){
            wordList = List<int>.generate(hauptstaedte.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hauptstaedte[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfHauptstaedte.length)){
            wordList = List<int>.generate(hfHauptstaedte.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfHauptstaedte[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfHauptstaedte.length)){
            wordList = List<int>.generate(nfHauptstaedte.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfHauptstaedte[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Hausbau:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == hausbau.length)){
            wordList = List<int>.generate(hausbau.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hausbau[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfHausbau.length)){
            wordList = List<int>.generate(hfHausbau.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfHausbau[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfHausbau.length)){
            wordList = List<int>.generate(nfHausbau.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfHausbau[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Hobbys:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == hobbys.length)){
            wordList = List<int>.generate(hobbys.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hobbys[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfHobbys.length)){
            wordList = List<int>.generate(hfHobbys.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfHobbys[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfHobbys.length)){
            wordList = List<int>.generate(nfHobbys.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfHobbys[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Kleidung:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == kleidung.length)){
            wordList = List<int>.generate(kleidung.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = kleidung[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfKleidung.length)){
            wordList = List<int>.generate(hfKleidung.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfKleidung[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfKleidung.length)){
            wordList = List<int>.generate(nfKleidung.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfKleidung[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Koerperteile:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == koerperteile.length)){
            wordList = List<int>.generate(koerperteile.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = koerperteile[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfKoerperteile.length)){
            wordList = List<int>.generate(hfKoerperteile.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfKoerperteile[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfKoerperteile.length)){
            wordList = List<int>.generate(nfKoerperteile.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfKoerperteile[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Kueche:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == kueche.length)){
            wordList = List<int>.generate(kueche.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = kueche[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfKueche.length)){
            wordList = List<int>.generate(hfKueche.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfKueche[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfKueche.length)){
            wordList = List<int>.generate(nfKueche.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfKueche[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Laender:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == laender.length)){
            wordList = List<int>.generate(laender.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = laender[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfLaender.length)){
            wordList = List<int>.generate(hfLaender.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfLaender[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfLaender.length)){
            wordList = List<int>.generate(nfLaender.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfLaender[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Moebel:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == moebel.length)){
            wordList = List<int>.generate(moebel.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = moebel[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfMoebel.length)){
            wordList = List<int>.generate(hfMoebel.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfMoebel[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfMoebel.length)){
            wordList = List<int>.generate(nfMoebel.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfMoebel[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Musikinstrumente:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == musikinstrumente.length)){
            wordList = List<int>.generate(musikinstrumente.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = musikinstrumente[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfMusikinstrumente.length)){
            wordList = List<int>.generate(hfMusikinstrumente.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfMusikinstrumente[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfMusikinstrumente.length)){
            wordList = List<int>.generate(nfMusikinstrumente.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfMusikinstrumente[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Obst:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == obst.length)){
            wordList = List<int>.generate(obst.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = obst[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfObst.length)){
            wordList = List<int>.generate(hfObst.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfObst[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfObst.length)){
            wordList = List<int>.generate(nfObst.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfObst[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Pflanzen:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == pflanzen.length)){
            wordList = List<int>.generate(pflanzen.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = pflanzen[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfPflanzen.length)){
            wordList = List<int>.generate(hfPflanzen.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfPflanzen[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfPflanzen.length)){
            wordList = List<int>.generate(nfPflanzen.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfPflanzen[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Resteraunt:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == resteraunt.length)){
            wordList = List<int>.generate(resteraunt.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = resteraunt[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfResteraunt.length)){
            wordList = List<int>.generate(hfResteraunt.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfResteraunt[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfResteraunt.length)){
            wordList = List<int>.generate(nfResteraunt.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfResteraunt[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Sportarten:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == sportarten.length)){
            wordList = List<int>.generate(sportarten.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = sportarten[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfSportarten.length)){
            wordList = List<int>.generate(hfSportarten.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfSportarten[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfSportarten.length)){
            wordList = List<int>.generate(nfSportarten.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfSportarten[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Strassenverkehr:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == strassenverkehr.length)){
            wordList = List<int>.generate(strassenverkehr.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = strassenverkehr[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfStrassenverkehr.length)){
            wordList = List<int>.generate(hfStrassenverkehr.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfStrassenverkehr[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfStrassenverkehr.length)){
            wordList = List<int>.generate(nfStrassenverkehr.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfStrassenverkehr[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Supermarkt:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == supermarkt.length)){
            wordList = List<int>.generate(supermarkt.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = supermarkt[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfSupermarkt.length)){
            wordList = List<int>.generate(hfSupermarkt.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfSupermarkt[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfSupermarkt.length)){
            wordList = List<int>.generate(nfSupermarkt.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfSupermarkt[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Tiere:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == tiere.length)){
            wordList = List<int>.generate(tiere.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = tiere[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfTiere.length)){
            wordList = List<int>.generate(hfTiere.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfTiere[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfTiere.length)){
            wordList = List<int>.generate(nfTiere.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfTiere[randomIndex];
          wordListCounter++;
          break;
        }
        break;
      case Category.Werkzeuge:
        if(settings.value == 'Alle Wörter'){
          if(!(wordList.length == werkzeuge.length)){
            wordList = List<int>.generate(werkzeuge.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = werkzeuge[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          if(!(wordList.length == hfWerkzeuge.length)){
            wordList = List<int>.generate(hfWerkzeuge.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = hfWerkzeuge[randomIndex];
          wordListCounter++;
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          if(!(wordList.length == nfWerkzeuge.length)){
            wordList = List<int>.generate(nfWerkzeuge.length, (int index) => index);
            wordList.shuffle();
          }
          randomIndex = wordList[wordListCounter];
          randomWord = nfWerkzeuge[randomIndex];
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
              if (randomWord.contains(chr) || randomWord.contains(chrUP)) {
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
                if (!randomWord.contains(RegExp(r'[a-z]'))) {
                  if(wordListCounter == wordList.length){
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return WillPopScope(
                            onWillPop: () async => false,
                            child: AlertDialog(
                              backgroundColor:
                              const Color.fromARGB(255, 29, 3, 142),
                              content: SizedBox(
                                height: 800,
                                child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          height: MediaQuery.of(context).size.height * 0.5,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: _imageToShow,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                      const Icon(
                                        Icons.check_circle_outlined,
                                        color: Colors.green,
                                        size: 50,
                                      ),
                                      Text(
                                        stored.toString(),
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontFamily: "Qaz",
                                            fontSize: 20),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Glückwunsch!",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: "Qaz",
                                            fontSize: 20),
                                      ),
                                      const Text(
                                        "Durchlauf beendet",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: "Qaz",
                                            fontSize: 20),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                              icon: const Icon(
                                                Icons.arrow_circle_right,
                                                size: 40,
                                                color: Colors.blue,
                                              ),
                                              onPressed: () {
                                                refresh();
                                                refresh();
                                              }),
                                          IconButton(
                                              icon: const Icon(
                                                Icons.info,
                                                size: 40,
                                                color: Colors.blue,
                                              ),
                                              onPressed: () {
                                                refresh();
                                                refresh();
                                              }),
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          );
                        });
                  }
                  else{
                    score = score + 1;
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return WillPopScope(
                            onWillPop: () async => false,
                            child: AlertDialog(
                              backgroundColor:
                              const Color.fromARGB(255, 29, 3, 142),
                              content: SizedBox(
                                height: 800,
                                child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                          Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                            height: MediaQuery.of(context).size.height * 0.5,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: _imageToShow,
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      const Icon(
                                        Icons.check_circle_outlined,
                                        color: Colors.green,
                                        size: 60,
                                      ),
                                      Text(
                                        stored.toString(),
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontFamily: "Modak",
                                            fontSize: 20),
                                      ),
                                      IconButton(
                                          icon: const Icon(
                                            Icons.arrow_circle_right,
                                            size: 40,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () {
                                            newGame();
                                            Navigator.of(context).pop();
                                          })
                                    ]),
                              ),
                            ),
                          );
                        });
                  }
                }
              } else {
                if (index == 11) {
                  index = index + 1;
                  lives -= 1;
                  if(lives == 0){
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return WillPopScope(
                            onWillPop: () async => false,
                            child: AlertDialog(
                              backgroundColor:
                              const Color.fromARGB(255, 29, 3, 142),
                              content: SizedBox(
                                height: 800,
                                child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          height: MediaQuery.of(context).size.height * 0.5,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: _imageToShow,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                      const Icon(
                                        Icons.remove_circle_outline_outlined,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                      Text(
                                        stored.toString(),
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontFamily: "PatrickHand",
                                            fontSize: 30),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Keine Leben mehr",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: "Modak",
                                            fontSize: 20),
                                      ),
                                      const Text(
                                        "Versuche es nochmal!",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: "Modak",
                                            fontSize: 20),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                              icon: const Icon(
                                                Icons.arrow_circle_right,
                                                size: 40,
                                                color: Colors.lightBlueAccent,
                                              ),
                                              onPressed: () {
                                                refresh();
                                                refresh();
                                              }),
                                          IconButton(
                                              icon: const Icon(
                                                Icons.info,
                                                size: 40,
                                                color: Colors.lightBlueAccent,
                                              ),
                                              onPressed: () {
                                                refresh();
                                                refresh();
                                              }),
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          );
                        });
                  }
                  else {
                    if(wordListCounter == wordList.length){
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return WillPopScope(
                              onWillPop: () async => false,
                              child: AlertDialog(
                                backgroundColor:
                                const Color.fromARGB(255, 29, 3, 142),
                                content: SizedBox(
                                  height: 800,
                                  child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(left: 10.0),
                                            height: MediaQuery.of(context).size.height * 0.5,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: _imageToShow,
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                        const Icon(
                                          Icons.check_circle_outlined,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                        Text(
                                          stored.toString(),
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontFamily: "PatrickHand",
                                              fontSize: 30),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Glückwunsch!",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontFamily: "Modak",
                                              fontSize: 20),
                                        ),
                                        const Text(
                                          "Durchlauf beendet",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontFamily: "Modak",
                                              fontSize: 20),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                                icon: const Icon(
                                                  Icons.arrow_circle_right,
                                                  size: 40,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                onPressed: () {
                                                  refresh();
                                                  refresh();
                                                }),
                                            IconButton(
                                                icon: const Icon(
                                                  Icons.info,
                                                  size: 40,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                onPressed: () {
                                                  refresh();
                                                  refresh();
                                                }),
                                          ],
                                        ),
                                      ]),
                                ),
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
                              child: AlertDialog(
                                backgroundColor:
                                const Color.fromARGB(255, 29, 3, 142),
                                content: SizedBox(
                                  height: 800,
                                  child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(left: 10.0),
                                            height: MediaQuery.of(context).size.height * 0.5,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: _imageToShow,
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                        const Icon(
                                          Icons.remove_circle_outline_outlined,
                                          color: Colors.red,
                                          size: 70,
                                        ),
                                        Text(
                                          stored.toString(),
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontFamily: "Qaz",
                                              fontSize: 40),
                                        ),
                             /*           if (lives == 0)
                                          TextFormField(
                                            validator: (value) => value!.isEmpty
                                                ? "Name"
                                                : null,
                                            controller: _name,
                                            decoration: const InputDecoration(
                                                hintText: "Bitte Namen eingeben"),
                                          ), */
                                        IconButton(
                                            icon: const Icon(
                                              Icons.arrow_circle_right,
                                              size: 40,
                                              color: Colors.lightBlueAccent,
                                            ),
                                            onPressed: () {
                                              /*     if (_name.text.isEmpty &&
                                                lives == 0) {
                                              return;
                                            } */
                                              newGame();
                                              Navigator.of(context).pop();
                                              /*      if (lives == 0) {
                                              DBHelper.insert('SCORE', {
                                                'date': _name.text,
                                                'score': score
                                              });
                                              refresh();
                                            } */
                                            })
                                      ]),
                                ),
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
          body: SingleChildScrollView(
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
                            Navigator.of(context).pop();
                          }),
                          icon: const Icon(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 2.0,
                                color: Colors.black,
                              ),
                            ],
                            Icons.home,
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
                              fontSize: 35,
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
                                      backgroundColor:
                                      const Color.fromARGB(255, 29, 3, 142),
                                      content: SizedBox(
                                        height: 200,
                                        child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              const Icon(
                                                Icons.check_circle_outlined,
                                                color: Colors.green,
                                                size: 60,
                                              ),
                                              Text(
                                                stored.toString(),
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: "Qaz",
                                                    fontSize: 20),
                                              ),
                                              IconButton(
                                                  icon: const Icon(
                                                    Icons.arrow_circle_right,
                                                    size: 40,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    newGame();
                                                    Navigator.of(context).pop();
                                                  })
                                            ]),
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
                        Stack(children: [
                          const Icon(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 2.0,
                                color: Colors.lightBlueAccent,
                              ),
                            ],
                            Icons.favorite,
                            size: 35,
                            color: Colors.lightBlueAccent,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(13, 6, 0, 0),
                            child: Text(
                              lives.toString(),
                              style: const TextStyle(
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 1.0,
                                      color: Colors.black,
                                    ),
                                  ],
                                color: Colors.black,
                                  fontFamily: "Qaz",
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
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
