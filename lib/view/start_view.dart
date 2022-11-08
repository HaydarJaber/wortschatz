import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wortschatz/model/words/hf_words.dart';
import 'package:wortschatz/model/constants/routes.dart';
import 'package:wortschatz/model/db_helper.dart';
import 'package:wortschatz/viewmodels/router/app_router.dart';
import '../model/constants/categories.dart';
import '../model/dummy_data.dart';
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
    });
  }

  @override //Erstes Wort
  void initState() {
    alphabets.updateAll((key, value) => value = 0);
    getCategory();
    sword = List.generate(randomWord.length, (index) => "_");
    stored = randomWord;
    print(randomWord);
    super.initState();
  }

  void getCategory(){
    switch(widget.category){
      case Category.All:
        randomIndex = Random().nextInt(hfall.length);
        randomWord = hfall[randomIndex];
        break;
      case Category.Autoteile:
        randomIndex = Random().nextInt(hfAutoteile.length);
        randomWord = hfAutoteile[randomIndex];
        break;
     case Category.Badezimmer:
        randomIndex = Random().nextInt(hfBadezimmer.length);
        randomWord = hfBadezimmer[randomIndex];
        break;
      case Category.Bauernhof:
        randomIndex = Random().nextInt(hfBauernhof.length);
        randomWord = hfBauernhof[randomIndex];
        break ;
      case Category.Berufe:
        randomIndex = Random().nextInt(hfBerufe.length);
        randomWord = hfBerufe[randomIndex];
        break ;
      case Category.DeutscheStaedte:
        randomIndex = Random().nextInt(hfDeutscheStaedte.length);
        randomWord = hfDeutscheStaedte[randomIndex];
        break ;
      case Category.Fahrzeuge:
        randomIndex = Random().nextInt(hfFahrzeuge.length);
        randomWord = hfFahrzeuge[randomIndex];
        break ;
      case Category.Garten:
        randomIndex = Random().nextInt(hfGarten.length);
        randomWord = hfGarten[randomIndex];
        break ;
      case Category.Gemuese:
        randomIndex = Random().nextInt(hfGemuese.length);
        randomWord = hfGemuese[randomIndex];
        break ;
      case Category.Getraenke:
        randomIndex = Random().nextInt(hfGetraenke.length);
        randomWord = hfGetraenke[randomIndex];
        break ;
      case Category.Hauptstaedte:
        randomIndex = Random().nextInt(hfHauptstaedte.length);
        randomWord = hfHauptstaedte[randomIndex];
        break ;
      case Category.Hausbau:
        randomIndex = Random().nextInt(hfHausbau.length);
        randomWord = hfHausbau[randomIndex];
        break ;
      case Category.Hobbys:
        randomIndex = Random().nextInt(hfHobbys.length);
        randomWord = hfHobbys[randomIndex];
        break ;
      case Category.Kleidung:
        randomIndex = Random().nextInt(hfKleidung.length);
        randomWord = hfKleidung[randomIndex];
        break ;
      case Category.Koerperteile:
        randomIndex = Random().nextInt(hfKoerperteile.length);
        randomWord = hfKoerperteile[randomIndex];
        break ;
      case Category.Kueche:
        randomIndex = Random().nextInt(hfKueche.length);
        randomWord = hfKueche[randomIndex];
        break ;
      case Category.Laender:
        randomIndex = Random().nextInt(hfLaender.length);
        randomWord = hfLaender[randomIndex];
        break ;
      case Category.Moebel:
        randomIndex = Random().nextInt(hfMoebel.length);
        randomWord = hfMoebel[randomIndex];
        break ;
      case Category.Musikinstrumente:
        randomIndex = Random().nextInt(hfMusikinstrumente.length);
        randomWord = hfMusikinstrumente[randomIndex];
        break ;
      case Category.Obst:
        randomIndex = Random().nextInt(hfObst.length);
        randomWord = hfObst[randomIndex];
        break ;
      case Category.Pflanzen:
        randomIndex = Random().nextInt(hfPflanzen.length);
        randomWord = hfPflanzen[randomIndex];
        break ;
      case Category.Resteraunt:
        randomIndex = Random().nextInt(hfResteraunt.length);
        randomWord = hfResteraunt[randomIndex];
        break ;
      case Category.Sportarten:
        randomIndex = Random().nextInt(hfSportarten.length);
        randomWord = hfSportarten[randomIndex];
        break ;
      case Category.Strassenverkehr:
        randomIndex = Random().nextInt(hfStrassenverkehr.length);
        randomWord = hfStrassenverkehr[randomIndex];
        break ;
      case Category.Supermarkt:
        randomIndex = Random().nextInt(hfSupermarkt.length);
        randomWord = hfSupermarkt[randomIndex];
        break ;
      case Category.Tiere:
        randomIndex = Random().nextInt(hfTiere.length);
        randomWord = hfTiere[randomIndex];
        break ;
      case Category.Werkzeuge:
        randomIndex = Random().nextInt(hfWerkzeuge.length);
        randomWord = hfWerkzeuge[randomIndex];
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
              } else {
                if (index == 5) {
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
                                            ? "please enter your name"
                                            : null,
                                        controller: _name,
                                        decoration: const InputDecoration(
                                            hintText: "Enter your name"),
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
