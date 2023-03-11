// Gesamtstatistik (verloren/gewonnen)
// Statistk per Kategorie
// angeforderte Hilfe

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../model/constants/categories.dart';
import '../model/constants/routes.dart';
import '../model/progress/progressWord.dart';
import '../model/progress/progressWord_boxes.dart';
import '../viewmodels/settings/settings.dart';

final List<String> frequenz = ['Alle Wörter','Hochfrequente Wörter', 'Niedrigfrequente Wörter'];

class ProgressEinzel extends StatefulWidget {
  final List getProgress;
  const ProgressEinzel({Key? key,  required this.getProgress}) : super(key: key);

  @override
  State<ProgressEinzel> createState() => _ProgressEinzelState();
}


class _ProgressEinzelState extends State<ProgressEinzel> with TickerProviderStateMixin {
  var emoji = ['🥇', '🥈', '🥉'];
  late int rank1,rank2,rank3;
  late TabController _tabController;
  String dropdownValue = frequenz.first;
  static const _gapW = SizedBox(width: 20);
  static const _gapH = SizedBox(height: 10);
  int iconCode = 0xf144;


  @override
  void initState() {
    rank1 = 0;
    rank2 = 0;
    rank3 = 0;
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) {
        tabChanged();
        print("ausgeführt");
      }
    });
    super.initState();
  }

  int getIcon() {
    switch(widget.getProgress[2])
    {
      case Category.All:
        iconCode = 0xe473;
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

  @override
  void tabChanged() {
    rank1 = 0;
    rank2 = 0;
    rank3 = 0;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }



  TextStyle txt = const TextStyle(
      fontFamily: "PatrickHand", fontSize: 30, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    List progressData = ModalRoute.of(context)?.settings.arguments as List;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.deepPurple.shade900,
          body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Hintergrund.jpg"),
                  fit: BoxFit.cover),
            ),
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: OrientationBuilder(builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 2.0,
                                    color: Colors.black,
                                  ),
                                ],
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                                size: 35,
                              )),
                          const SizedBox(width: 60),
                          Text(
                            (progressData[2]),
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
                                fontSize: 30),
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
                          )
                        ],
                      ),
                      ValueListenableBuilder<Box<Word>>(
                          valueListenable: Boxes.getWords().listenable(),
                          builder: (context,box,_){
                            final words = box.values.toList().cast<Word>();

                            return buildContent(words);
                          }
                      ),
                      _gapH,
                      _gapH,
                      _gapH,
                      // give the tab bar a height [can change hheight to preferred height]
                      Container(height: 10),
                      // tab bar view here
                    ],
                  ),
                );
              } else {
                return Row(
                  children: [
                    /*  Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                    iconSize: 35,
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),*/
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ));
  }

  Widget buildContent(List<Word> words) {
    if (words.isEmpty) {
      return const Center(
        child: Text(
          'Keine Daten gefunden',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      List progressData = ModalRoute.of(context)?.settings.arguments as List;
      var richtigesWort = 0;
      var falschesWort = 0;
      var Spielgewonnen = 0;
      var Spielverloren = 0;
      var h1 = 0;
      var h2 = 0;
      var h3 = 0;
      var h4 = 0;
      for(int i = 0; i < words.length; i++){
        if(words[i].diff == progressData[0]){
          if(words[i].freq == progressData[1]){
            if(words[i].category == progressData[2]){
              if (words[i].H1 == 1){
                h1++;
              }
              if (words[i].H2 == 1){
                h2++;
              }
              if (words[i].H3 == 1){
                h3++;
              }
              if (words[i].H4 == 1){
                h4++;
              }
              if(words[i].rOderF.contains("richtig")){
                richtigesWort++;
              }
              if(words[i].rOderF.contains("G")){
                Spielgewonnen++;
              }
              if(words[i].rOderF.contains("falsch")){
                falschesWort++;
              }
              if(words[i].rOderF.contains("V")){
                Spielverloren++;
              }
            }
          }
        }

       // words[i].rOderF;
      }


      //Addiere Hilfense



/*
      return Column(
        children: [
          SizedBox(height: 24),
          Text(
            'Net Expense: $h1',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.deepOrange,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: words.length,
              itemBuilder: (BuildContext context, int index) {
                final transaction = words[index];

                return buildTransaction(context, transaction);
              },
            ),
          ),
        ],
      );
*/


     return Flexible(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Material(
              color: Colors.transparent,
              child: Ink(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.18,
                decoration: const ShapeDecoration(
                    color: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 2,
                            color: Colors.black)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:const [
                          Text(
                            'Spiele',
                            style: TextStyle(shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 1.0,
                                color: Colors.black,
                              ),
                            ], fontFamily: "Qaz", fontSize: 35, color: Colors.black),
                          ),
                        ],
                      ),
                      _gapH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                          Material(
                            color: Colors.transparent,
                            child: Ink(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: const ShapeDecoration(
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Colors.black)
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:const [
                                        Text(
                                          'Gewonnen',
                                          style: TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    _gapH,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[
                                        Text(
                                          '$Spielgewonnen',
                                          style: const TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Ink(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: const ShapeDecoration(
                                  color: Colors.deepOrange,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Colors.black)
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:const [
                                        Text(
                                          'Verloren',
                                          style: TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0,0.0),
                                              blurRadius: 2.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    _gapH,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$Spielverloren',
                                          style: const TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _gapH,
            _gapH,
            Material(
              color: Colors.transparent,
              child: Ink(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.18,
                decoration: const ShapeDecoration(
                    color: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 2,
                            color: Colors.black)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:const [
                          Text(
                            'Wörter',
                            style: TextStyle(shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 1.0,
                                color: Colors.black,
                              ),
                            ], fontFamily: "Qaz", fontSize: 35, color: Colors.black),
                          ),
                        ],
                      ),
                      _gapH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                          Material(
                            color: Colors.transparent,
                            child: Ink(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: const ShapeDecoration(
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Colors.black)
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:const [
                                        Text(
                                          'Richtig',
                                          style: TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    _gapH,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$richtigesWort',
                                          style: const TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Ink(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: const ShapeDecoration(
                                  color: Colors.deepOrange,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Colors.black)
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:const [
                                        Text(
                                          'Falsch',
                                          style: TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0,0.0),
                                              blurRadius: 2.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    _gapH,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$falschesWort',
                                          style: const TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          _gapH,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _gapH,
            _gapH,
            Material(
              color: Colors.transparent,
              child: Ink(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.18,
                decoration: const ShapeDecoration(
                    color: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 2,
                            color: Colors.black)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:const [
                          Text(
                            'genutzte Hilfen',
                            style: TextStyle(shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 1.0,
                                color: Colors.black,
                              ),
                            ], fontFamily: "Qaz", fontSize: 35, color: Colors.black),
                          ),
                        ],
                      ),
                      _gapH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                          Material(
                            color: Colors.transparent,
                            child: Ink(
                              width: MediaQuery.of(context).size.width * 0.175,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: const ShapeDecoration(
                                  color: Colors.yellow,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Colors.black)
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:const [
                                        Text(
                                          'H1',
                                          style: TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    _gapH,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[
                                        Text(
                                          '$h1',
                                          style: const TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Ink(
                              width: MediaQuery.of(context).size.width * 0.175,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: const ShapeDecoration(
                                  color: Colors.yellow,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Colors.black)
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:const [
                                        Text(
                                          'H2',
                                          style: TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    _gapH,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$h2',
                                          style: const TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Ink(
                              width: MediaQuery.of(context).size.width * 0.175,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: const ShapeDecoration(
                                  color: Colors.yellow,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Colors.black)
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:const [
                                        Text(
                                          'H3',
                                          style: TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    _gapH,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$h3',
                                          style: const TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Ink(
                              width: MediaQuery.of(context).size.width * 0.175,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: const ShapeDecoration(
                                  color: Colors.yellow,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Colors.black)
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:const [
                                        Text(
                                          'H4',
                                          style: TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    _gapH,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$h4',
                                          style: const TextStyle(shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ], fontFamily: "Qaz", fontSize: 28, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      );


    }
  }
}
