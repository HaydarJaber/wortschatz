import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortschatz/model/words/hf_words.dart';
import 'package:wortschatz/model/constants/routes.dart';
import 'package:wortschatz/model/db_helper.dart';
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
    print(randomWord);
    print(wordList);
  }

  void getCategory(){
    final settings = context.read<SettingsController>().frequency;
    switch(widget.category){
      case Category.All:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(all.length);
          randomWord = all[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfall.length);
          randomWord = hfall[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfall.length);
          randomWord = nfall[randomIndex];
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
          randomIndex = Random().nextInt(nfAutoteile.length);
          randomWord = nfAutoteile[randomIndex];
          break;
        }
        break;
     case Category.Badezimmer:
       if(settings.value == 'Alle Wörter'){
         randomIndex = Random().nextInt(badezimmer.length);
         randomWord = badezimmer[randomIndex];
         break;
       }
       if(settings.value == 'Hochfrequente Wörter'){
         randomIndex = Random().nextInt(hfBadezimmer.length);
         randomWord = hfBadezimmer[randomIndex];
         break;
       }
       if(settings.value == 'Niedrigfrequente Wörter'){
         randomIndex = Random().nextInt(nfBadezimmer.length);
         randomWord = nfBadezimmer[randomIndex];
         break;
       }
       break;
      case Category.Bauernhof:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(bauernhof.length);
          randomWord = bauernhof[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfBauernhof.length);
          randomWord = hfBauernhof[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfBauernhof.length);
          randomWord = nfBauernhof[randomIndex];
          break;
        }
        break ;
      case Category.Berufe:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(berufe.length);
          randomWord = berufe[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfBerufe.length);
          randomWord = hfBerufe[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfBerufe.length);
          randomWord = nfBerufe[randomIndex];
          break;
        }
        break ;
      case Category.DeutscheStaedte:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(deutscheStaedte.length);
          randomWord = deutscheStaedte[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfDeutscheStaedte.length);
          randomWord = hfDeutscheStaedte[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfDeutscheStaedte.length);
          randomWord = nfDeutscheStaedte[randomIndex];
          break;
        }
        break ;
      case Category.Fahrzeuge:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(fahrzeuge.length);
          randomWord = fahrzeuge[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfFahrzeuge.length);
          randomWord = hfFahrzeuge[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfFahrzeuge.length);
          randomWord = nfFahrzeuge[randomIndex];
          break;
        }
        break ;
      case Category.Garten:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(garten.length);
          randomWord = garten[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfGarten.length);
          randomWord = hfGarten[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfGarten.length);
          randomWord = nfGarten[randomIndex];
          break;
        }
        break ;
      case Category.Gemuese:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(gemuese.length);
          randomWord = gemuese[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfGemuese.length);
          randomWord = hfGemuese[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfGemuese.length);
          randomWord = nfGemuese[randomIndex];
          break;
        }
        break ;
      case Category.Getraenke:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(getraenke.length);
          randomWord = getraenke[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfGetraenke.length);
          randomWord = hfGetraenke[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfGetraenke.length);
          randomWord = nfGetraenke[randomIndex];
          break;
        }
        break ;
      case Category.Hauptstaedte:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(hauptstaedte.length);
          randomWord = hauptstaedte[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfHauptstaedte.length);
          randomWord = hfHauptstaedte[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfHauptstaedte.length);
          randomWord = nfHauptstaedte[randomIndex];
          break;
        }
        break ;
      case Category.Hausbau:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(hausbau.length);
          randomWord = hausbau[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfHausbau.length);
          randomWord = hfHausbau[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfHausbau.length);
          randomWord = nfHausbau[randomIndex];
          break;
        }
        break ;
      case Category.Hobbys:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(hobbys.length);
          randomWord = hobbys[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfHobbys.length);
          randomWord = hfHobbys[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfHobbys.length);
          randomWord = nfHobbys[randomIndex];
          break;
        }
        break ;
      case Category.Kleidung:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(kleidung.length);
          randomWord = kleidung[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfKleidung.length);
          randomWord = hfKleidung[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfKleidung.length);
          randomWord = nfKleidung[randomIndex];
          break;
        }
        break ;
      case Category.Koerperteile:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(koerperteile.length);
          randomWord = koerperteile[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfKoerperteile.length);
          randomWord = hfKoerperteile[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfKoerperteile.length);
          randomWord = nfKoerperteile[randomIndex];
          break;
        }
        break ;
      case Category.Kueche:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(kueche.length);
          randomWord = kueche[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfKueche.length);
          randomWord = hfKueche[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfKueche.length);
          randomWord = nfKueche[randomIndex];
          break;
        }
        break ;
      case Category.Laender:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(laender.length);
          randomWord = laender[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfLaender.length);
          randomWord = hfLaender[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfLaender.length);
          randomWord = nfLaender[randomIndex];
          break;
        }
        break ;
      case Category.Moebel:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(moebel.length);
          randomWord = moebel[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfMoebel.length);
          randomWord = hfMoebel[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfMoebel.length);
          randomWord = nfMoebel[randomIndex];
          break;
        }
        break ;
      case Category.Musikinstrumente:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(musikinstrumente.length);
          randomWord = musikinstrumente[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfMusikinstrumente.length);
          randomWord = hfMusikinstrumente[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfMusikinstrumente.length);
          randomWord = nfMusikinstrumente[randomIndex];
          break;
        }
        break ;
      case Category.Obst:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(obst.length);
          randomWord = obst[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfObst.length);
          randomWord = hfObst[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfObst.length);
          randomWord = nfObst[randomIndex];
          break;
        }
        break ;
      case Category.Pflanzen:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(pflanzen.length);
          randomWord = pflanzen[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfPflanzen.length);
          randomWord = hfPflanzen[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfPflanzen.length);
          randomWord = nfPflanzen[randomIndex];
          break;
        }
        break ;
      case Category.Resteraunt:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(resteraunt.length);
          randomWord = resteraunt[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfResteraunt.length);
          randomWord = hfResteraunt[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfResteraunt.length);
          randomWord = nfResteraunt[randomIndex];
          break;
        }
        break ;
      case Category.Sportarten:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(sportarten.length);
          randomWord = sportarten[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfSportarten.length);
          randomWord = hfSportarten[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfSportarten.length);
          randomWord = nfSportarten[randomIndex];
          break;
        }
        break ;
      case Category.Strassenverkehr:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(strassenverkehr.length);
          randomWord = strassenverkehr[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfStrassenverkehr.length);
          randomWord = hfStrassenverkehr[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfStrassenverkehr.length);
          randomWord = nfStrassenverkehr[randomIndex];
          break;
        }
        break ;
      case Category.Supermarkt:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(supermarkt.length);
          randomWord = supermarkt[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfSupermarkt.length);
          randomWord = hfSupermarkt[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfSupermarkt.length);
          randomWord = nfSupermarkt[randomIndex];
          break;
        }
        break ;
      case Category.Tiere:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(tiere.length);
          randomWord = tiere[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfTiere.length);
          randomWord = hfTiere[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfTiere.length);
          randomWord = nfTiere[randomIndex];
          break;
        }
        break ;
      case Category.Werkzeuge:
        if(settings.value == 'Alle Wörter'){
          randomIndex = Random().nextInt(werkzeuge.length);
          randomWord = werkzeuge[randomIndex];
          break;
        }
        if(settings.value == 'Hochfrequente Wörter'){
          randomIndex = Random().nextInt(hfWerkzeuge.length);
          randomWord = hfWerkzeuge[randomIndex];
          break;
        }
        if(settings.value == 'Niedrigfrequente Wörter'){
          randomIndex = Random().nextInt(nfWerkzeuge.length);
          randomWord = nfWerkzeuge[randomIndex];
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
        // fontWeight: FontWeight.bold,
          color: Colors.blue,
          fontFamily: "PatrickHand",
          fontSize: 40),
    );
  }

  //Buchstaben-Buttons
  Widget alphaContainer(var name, Color color) {
    return Container(
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      alignment: Alignment.center,
      width: 50,
      child: Text(
        name,
        style: const TextStyle(
           fontWeight: FontWeight.w100,
            color: Colors.white,
            fontFamily: "Modak",
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
                if(randomWord.contains(chr)){
                  while (randomWord.contains(chr)) {
                    int getIndex = randomWord.indexOf((chr));
                    randomWord = randomWord.replaceFirst(chr, '_');
                    sword[getIndex] = chr;
                  }
                }else{
                  while (randomWord.contains(chrUP)) {
                    int getIndex = randomWord.indexOf((chrUP));
                    randomWord = randomWord.replaceFirst(chrUP, '_');
                    sword[getIndex] = chrUP;
                  }
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
                                      const Text(
                                        "GESCHAFFT!",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: "Modak",
                                            fontSize: 20),
                                      ),
                                      const Text(
                                        "Keine weiteren Wörter vorhanden.",
                                        style: TextStyle(
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
                                            refresh();
                                            refresh();
                                          })
                                    ]),
                              ),
                            ),
                          );
                        });
                  }else{
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
                              height: 250,
                              child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(
                                      Icons.remove_circle_outline_outlined,
                                      color: Colors.red,
                                      size: 70,
                                    ),
                                    Text(
                                      stored.toString(),
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontFamily: "PatrickHand",
                                          fontSize: 40),
                                    ),
                                    if (lives == 0)
                                      TextFormField(
                                        validator: (value) => value!.isEmpty
                                            ? "Name"
                                            : null,
                                        controller: _name,
                                        decoration: const InputDecoration(
                                            hintText: "Bitte Namen eingeben"),
                                      ),
                                    IconButton(
                                        icon: const Icon(
                                          Icons.arrow_circle_right,
                                          size: 40,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          if (_name.text.isEmpty &&
                                              lives == 0) {
                                            return;
                                          }
                                          newGame();
                                          Navigator.of(context).pop();
                                          if (lives == 0) {
                                            DBHelper.insert('SCORE', {
                                              'date': _name.text,
                                              'score': score
                                            });
                                            refresh();
                                          }
                                        })
                                  ]),
                            ),
                          ),
                        );
                      });
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
          Colors.blue,
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
                            Icons.home,
                            size: 35,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          score.toString(),
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 35,
                              fontFamily: "PatrickHand"),
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
                          }),
                          icon: const Icon(
                            Icons.lightbulb,
                            size: 35,
                            color: Colors.blue,
                          ),
                        ),
                        Stack(children: [
                          const Icon(
                            Icons.favorite,
                            size: 35,
                            color: Colors.blue,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(13, 6, 0, 0),
                            child: Text(
                              lives.toString(),
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
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
                                color: Colors.blue,
                                fontFamily: "Modak",
                                fontSize: 20),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            (widget.category),
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Modak",
                                fontSize: 25),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                              shadows: const <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 5.0,
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
