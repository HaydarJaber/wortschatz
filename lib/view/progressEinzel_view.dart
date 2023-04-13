// Gesamtstatistik (verloren/gewonnen)
// Statistk per Kategorie
// angeforderte Hilfe

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../model/constants/categories.dart';
import '../model/constants/routes.dart';
import '../model/progress/progressWord.dart';
import '../model/progress/progressWord_boxes.dart';
import '../viewmodels/settings/settings.dart';

final List<String> frequenz = ['Alle Wörter','Häufige Wörter', 'Seltene Wörter'];

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
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: OrientationBuilder(builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              iconSize: MediaQuery.of(context).size.width*0.1,
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                shadows: <Shadow>[
                                ],
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                              )),
                          Text((progressData[2]),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.09, shadows: const <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 1.0,
                              color: Colors.black,
                            ),
                          ]), maxLines: 1, overflow: TextOverflow.ellipsis),
                          SizedBox(width: MediaQuery.of(context).size.width*0.02),
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
                                  .width * 0.1,
                              color: Colors.black,
                              IconData(getIcon(), fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter')
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      ValueListenableBuilder<Box<Word>>(
                          valueListenable: Boxes.getWords().listenable(),
                          builder: (context,box,_){
                            final words = box.values.toList().cast<Word>();

                            return buildContent(words,orientation);
                          }
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              iconSize: MediaQuery.of(context).size.width*0.05,
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                shadows: <Shadow>[
                                ],
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                              )),
                          Text((progressData[2]),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045, shadows: const <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 1.0,
                              color: Colors.black,
                            ),
                          ]), maxLines: 1, overflow: TextOverflow.ellipsis),
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
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.00),
                      ValueListenableBuilder<Box<Word>>(
                          valueListenable: Boxes.getWords().listenable(),
                          builder: (context,box,_){
                            final words = box.values.toList().cast<Word>();

                            return buildContent(words,orientation);
                          }
                      ),
                    ],
                  ),
                );
              }
            }),
          ),
        ));
  }

  Widget buildContent(List<Word> words, Orientation orientation) {
    var mySizeGRP_V = AutoSizeGroup();
    var mySizeGRP_V2 = AutoSizeGroup();
    var mySizeGRP_V3 = AutoSizeGroup();
    var mySizeGRP_H = AutoSizeGroup();
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
            if(words[i].category == progressData[2] || progressData[2] == "Gesamt"){
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
      if (orientation == Orientation.portrait) {
        return Flexible(
          child: Column(children: [
            Material(
                color: Colors.transparent,
                child: Ink(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: const ShapeDecoration(
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 2,
                              color: Colors.black)
                      )
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Flexible(child:
                            AutoSizeText('Spiele', group: mySizeGRP_V, style: const TextStyle(fontSize: 80, shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 1.0,
                                color: Colors.black,
                              ),
                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                          ],
                        )),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Flexible(child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:[
                            Material(
                              color: Colors.transparent,
                              child: Ink(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: MediaQuery.of(context).size.height * 0.15,
                                decoration: const ShapeDecoration(
                                    color: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 2,
                                            color: Colors.black)
                                    )
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Flexible(child:
                                          AutoSizeText('Gewonnen', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                        ],
                                      ),),
                                      SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                                      Flexible(child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          Flexible(child:
                                          AutoSizeText('$Spielgewonnen', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 2.0,
                                              color: Colors.black,
                                            ),
                                          ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                        ],
                                      ),
                                      )
                                    ],
                                  )
                              ),
                            ),
                            Material(
                            color: Colors.transparent,
                            child: Ink(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: const ShapeDecoration(
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Colors.black)
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Flexible(child:
                                        AutoSizeText('Verloren', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[
                                        Flexible(child:
                                        AutoSizeText('$Spielverloren', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 2.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ],
                        )),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      ],
                    ),
                ),
              ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Material(
              color: Colors.transparent,
              child: Ink(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: const ShapeDecoration(
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 2,
                            color: Colors.black)
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Flexible(child:
                        AutoSizeText('Wörter', group: mySizeGRP_V, style: const TextStyle(fontSize: 80, shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 1.0,
                            color: Colors.black,
                          ),
                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                      ],
                    )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Flexible(child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:[
                        Material(
                          color: Colors.transparent,
                          child: Ink(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: const ShapeDecoration(
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Colors.black)
                                  )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(child:
                                      AutoSizeText('Richtig', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 1.0,
                                          color: Colors.black,
                                        ),
                                      ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                    ],
                                  ),),
                                  SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                                  Flexible(child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      Flexible(child:
                                      AutoSizeText('$richtigesWort', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 2.0,
                                          color: Colors.black,
                                        ),
                                      ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                    ],
                                  ),
                                  )
                                ],
                              )
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: Ink(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: const ShapeDecoration(
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 2,
                                        color: Colors.black)
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(child:
                                      AutoSizeText('Falsch', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 1.0,
                                          color: Colors.black,
                                        ),
                                      ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      Flexible(child:
                                      AutoSizeText('$falschesWort', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 2.0,
                                          color: Colors.black,
                                        ),
                                      ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Material(
                color: Colors.transparent,
                child: Ink(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: const ShapeDecoration(
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 2,
                              color: Colors.black)
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Flexible(child:
                            AutoSizeText('Hilfen', group: mySizeGRP_V, style: const TextStyle(fontSize: 80, shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 1.0,
                                color: Colors.black,
                              ),
                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Flexible(child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:[
                            Material(
                              color: Colors.transparent,
                              child: Ink(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.height * 0.11,
                                decoration: const ShapeDecoration(
                                    color: Colors.yellow,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 2,
                                            color: Colors.black)
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          Flexible(child:
                                        AutoSizeText('Tipp 1', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          Flexible(child:
                                          AutoSizeText('$h1', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 2.0,
                                              color: Colors.black,
                                            ),
                                          ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
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
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.height * 0.11,
                                decoration: const ShapeDecoration(
                                    color: Colors.yellow,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 2,
                                            color: Colors.black)
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          Flexible(child:
                                          AutoSizeText('Tipp 2', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          Flexible(child:
                                          AutoSizeText('$h2', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 2.0,
                                              color: Colors.black,
                                            ),
                                          ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
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
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.height * 0.11,
                                decoration: const ShapeDecoration(
                                    color: Colors.yellow,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 2,
                                            color: Colors.black)
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          Flexible(child:
                                          AutoSizeText('Tipp 3', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          Flexible(child:
                                          AutoSizeText('$h3', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 2.0,
                                              color: Colors.black,
                                            ),
                                          ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
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
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.height * 0.11,
                                decoration: const ShapeDecoration(
                                    color: Colors.yellow,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 2,
                                            color: Colors.black)
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          Flexible(child:
                                          AutoSizeText('Tipp 4', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          Flexible(child:
                                          AutoSizeText('$h4', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 2.0,
                                              color: Colors.black,
                                            ),
                                          ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      ],
                    ),
                  ),
                ),
              ),
            progressData[2] == "Gesamt" ? const SizedBox.shrink() :
            Row(mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child:
                  IconButton(
                      icon: Icon(
                        Icons.play_circle_outline,
                        size: MediaQuery.of(context).size.width * 0.2,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        context.read<SettingsController>().setSchwierigkeit(progressData[0]);
                        context.read<SettingsController>().setFrequency(progressData[1]);
                        Navigator.pushNamed(context, Routes.newGame,arguments: progressData[2]);
                      })),
                  Expanded(child:
                  IconButton(
                      icon: Icon(
                        Icons.home,
                        size: MediaQuery.of(context).size.width * 0.2,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.home);
                      }))
                ],
              )
            ]),
        );
      }
      else {
        return Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    width: MediaQuery.of(context).size.width * 0.31,
                    height: MediaQuery.of(context).size.height * 0.65,
                    decoration: const ShapeDecoration(
                        color: Colors.white70,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 2,
                                color: Colors.black)
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Flexible(child:
                            AutoSizeText('Spiele', group: mySizeGRP_V, style: const TextStyle(fontSize: 60, shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 1.0,
                                color: Colors.black,
                              ),
                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                          ],
                        )),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Expanded(child:
                            Material(
                              color: Colors.transparent,
                              child: Ink(
                                  width: MediaQuery.of(context).size.width * 0.28,
                                  height: MediaQuery.of(context).size.height * 0.25,
                                  decoration: const ShapeDecoration(
                                      color: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 2,
                                              color: Colors.black)
                                      )
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Flexible(child:
                                          AutoSizeText('Gewonnen', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                        ],
                                      ),),
                                      SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                                      Flexible(child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          Flexible(child:
                                          AutoSizeText('$Spielgewonnen', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 2.0,
                                              color: Colors.black,
                                            ),
                                          ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                        ],
                                      ),
                                      )
                                    ],
                                  )
                              ),
                            )),
                            Expanded(child:
                            Material(
                              color: Colors.transparent,
                              child: Ink(
                                width: MediaQuery.of(context).size.width * 0.28,
                                height: MediaQuery.of(context).size.height * 0.25,
                                decoration: const ShapeDecoration(
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 2,
                                            color: Colors.black)
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Flexible(child:
                                          AutoSizeText('Verloren', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 1.0,
                                              color: Colors.black,
                                            ),
                                          ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          Flexible(child:
                                          AutoSizeText('$Spielverloren', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 2.0,
                                              color: Colors.black,
                                            ),
                                          ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                      ],
                    ),
                  ),
                )]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: Ink(
                            width: MediaQuery.of(context).size.width * 0.31,
                            height: MediaQuery.of(context).size.height * 0.65,
                            decoration: const ShapeDecoration(
                                color: Colors.white70,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 2,
                                        color: Colors.black)
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:[
                                    Flexible(child:
                                    AutoSizeText('Wörter', group: mySizeGRP_V, style: const TextStyle(fontSize: 200, shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 1.0,
                                        color: Colors.black,
                                      ),
                                    ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                  ],
                                )),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                Expanded(child:
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                      width: MediaQuery.of(context).size.width * 0.28,
                                      height: MediaQuery.of(context).size.height * 0.25,
                                      decoration: const ShapeDecoration(
                                          color: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 2,
                                                  color: Colors.black)
                                          )
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Flexible(child:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Flexible(child:
                                              AutoSizeText('Richtig', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 0.0),
                                                  blurRadius: 1.0,
                                                  color: Colors.black,
                                                ),
                                              ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                            ],
                                          ),),
                                          SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                                          Flexible(child:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children:[
                                              Flexible(child:
                                              AutoSizeText('$richtigesWort', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 0.0),
                                                  blurRadius: 2.0,
                                                  color: Colors.black,
                                                ),
                                              ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                            ],
                                          ),
                                          )
                                        ],
                                      )
                                  ),
                                )),
                                Expanded(child:
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    width: MediaQuery.of(context).size.width * 0.28,
                                    height: MediaQuery.of(context).size.height * 0.25,
                                    decoration: const ShapeDecoration(
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 2,
                                                color: Colors.black)
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Flexible(child:
                                              AutoSizeText('Falsch', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 0.0),
                                                  blurRadius: 1.0,
                                                  color: Colors.black,
                                                ),
                                              ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                            ],
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children:[
                                              Flexible(child:
                                              AutoSizeText('$falschesWort', group: mySizeGRP_V2, style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 0.0),
                                                  blurRadius: 2.0,
                                                  color: Colors.black,
                                                ),
                                              ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                              ],
                            ),
                          ),
                        )]),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    width: MediaQuery.of(context).size.width * 0.31,
                    height: MediaQuery.of(context).size.height * 0.65,
                    decoration: const ShapeDecoration(
                        color: Colors.white70,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 2,
                                color: Colors.black)
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Flexible(child:
                              AutoSizeText('Hilfen', group: mySizeGRP_V, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 1.0,
                                  color: Colors.black,
                                ),
                              ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          Flexible(child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:[
                              Material(
                                color: Colors.transparent,
                                child: Ink(
                                  width: MediaQuery.of(context).size.width * 0.28,
                                  height: MediaQuery.of(context).size.height * 0.10,
                                  decoration: const ShapeDecoration(
                                      color: Colors.yellow,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 2,
                                              color: Colors.black)
                                      )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(child:
                                        AutoSizeText('Tipp 1:', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                        Flexible(child:
                                        AutoSizeText('$h1', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 2.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: Ink(
                                  width: MediaQuery.of(context).size.width * 0.28,
                                  height: MediaQuery.of(context).size.height * 0.10,
                                  decoration: const ShapeDecoration(
                                      color: Colors.yellow,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 2,
                                              color: Colors.black)
                                      )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(child:
                                        AutoSizeText('Tipp 2:', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                        Flexible(child:
                                        AutoSizeText('$h2', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 2.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: Ink(
                                  width: MediaQuery.of(context).size.width * 0.28,
                                  height: MediaQuery.of(context).size.height * 0.10,
                                  decoration: const ShapeDecoration(
                                      color: Colors.yellow,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 2,
                                              color: Colors.black)
                                      )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(child:
                                        AutoSizeText('Tipp 3:', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                        Flexible(child:
                                        AutoSizeText('$h3', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 2.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: Ink(
                                  width: MediaQuery.of(context).size.width * 0.28,
                                  height: MediaQuery.of(context).size.height * 0.10,
                                  decoration: const ShapeDecoration(
                                      color: Colors.yellow,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 2,
                                              color: Colors.black)
                                      )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(child:
                                        AutoSizeText('Tipp 4:', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                        Flexible(child:
                                        AutoSizeText('$h4', group: mySizeGRP_V2, style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 2.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                )],)
            ]),
            progressData[2] == "Gesamt" ? const SizedBox.shrink() :
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child:
                IconButton(
                    icon: Icon(
                      Icons.play_circle_rounded,
                      size: MediaQuery.of(context).size.height * 0.15,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      context.read<SettingsController>().setSchwierigkeit(progressData[0]);
                      context.read<SettingsController>().setFrequency(progressData[1]);
                      Navigator.pushNamed(context, Routes.newGame,arguments: progressData[2]);
                    })),
                Expanded(child:
                IconButton(
                    icon: Icon(
                      Icons.home,
                      size: MediaQuery.of(context).size.height * 0.15,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.home);
                    }))
              ],
            )
          ]),
        );
      }



    }
  }
}
