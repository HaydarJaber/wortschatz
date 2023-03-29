// Gesamtstatistik (verloren/gewonnen)
// Statistk per Kategorie
// angeforderte Hilfe

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wortschatz/view/categories_view.dart';
import '../model/constants/categories.dart';
import '../model/constants/routes.dart';
import '../model/progress/progressWord.dart';
import '../model/progress/progressWord_boxes.dart';
import '../viewmodels/settings/settings.dart';

final List<String> frequenz = ['Alle Wörter','Häufige Wörter', 'Seltene Wörter'];

class ProgressScreen extends StatefulWidget {
  // final List<HighScore> scores;
  const ProgressScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressState();
}

class _ProgressState extends State<ProgressScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  String dropdownValue = frequenz.first;
  static const _gapW = SizedBox(width: 20);
  static const _gapH = SizedBox(height: 5);
  late int Rcount,Fcount;
  var currentDiff = "Leicht";

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) {
        getTab();
      }
    });
    super.initState();
  }


  //HIVE
  @override
  void disposeBOX(){
    Hive.close(); //löscht alle boxen
    Hive.box('einzelWorter').close(); //löscht nur eine spezielle Box

    super.dispose();
  }

  //HIVE ENDE

  Map<String, List<dynamic>> itemsMAP = {
    "Gesamt":[Category.All,0xe473,0],
    "Autoteile":[Category.Autoteile,0xf1b9,0],
    "Badezimmer":[Category.Badezimmer,0xf2cd,0],
    "Bauernhof":[Category.Bauernhof,0xe2cd,0],
    "Berufe":[Category.Berufe,0xf85e,0],
    "Deutsche Städte":[Category.DeutscheStaedte,0xf64f,0],
    "Fahrzeuge":[Category.Fahrzeuge,0xf21c,0],
    "Garten":[Category.Garten,0xf1bb,0],
    "Gemüse":[Category.Gemuese,0xf787,0],
    "Getränke":[Category.Getraenke,0xf000,0],
    "Hauptstädte":[Category.Hauptstaedte,0xf64f,0],
    "Hausbau":[Category.Hausbau,0xf015,0],
    "Hobbys":[Category.Hobbys,0xf554,0],
    "Kleidung":[Category.Kleidung,0xf553,0],
    "Körperteile":[Category.Koerperteile,0xf06e,0],
    "Küche":[Category.Kueche,0xe51a,0],
    "Länder":[Category.Laender,0xf024,0],
    "Möbel":[Category.Moebel,0xf4b8,0],
    "Musikinstrumente":[Category.Musikinstrumente,0xf001,0],
    "Obst":[Category.Obst,0xf5d1,0],
    "Pflanzen":[Category.Pflanzen,0xe5aa,0],
    "Resteraunt":[Category.Resteraunt,0xf2e7,0],
    "Sportarten":[Category.Sportarten,0xf1e3,0],
    "Strassenverkehr":[Category.Strassenverkehr,0xf018,0],
    "Supermarkt":[Category.Supermarkt,0xf54f,0],
    "Tiere":[Category.Tiere,0xf6f0,0],
    "Werkzeuge":[Category.Werkzeuge,0xf7d9,0],
  };


  @override
  void getTab() {
    if(_tabController.index == 2) {
      currentDiff = "Schwer";
    }
    if(_tabController.index == 1) {
      currentDiff = "Normal";
    }
    if(_tabController.index == 0) {
      currentDiff = "Leicht";
    }
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
    var mySizeGRP_V = AutoSizeGroup();
    var mySizeGRP_H = AutoSizeGroup();
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
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: OrientationBuilder(builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return Padding(
                  padding: const EdgeInsets.all(0.0),
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
                                Icons.home,
                                color: Colors.black,
                              )),
                          SizedBox(width: MediaQuery.of(context).size.width*0.02),
                          Text('Fortschritt',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1, shadows: const <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 1.0,
                              color: Colors.black,
                            ),
                          ]), maxLines: 1, overflow: TextOverflow.ellipsis)
                        ],
                      ),
                      // give the tab bar a height [can change hheight to preferred height]
                      Container(
                        height: MediaQuery.of(context).size.height*0.07,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          // give the indicator a decoration (color and border radius)
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                            color: Colors.lightBlueAccent,
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            // first tab [you can add an icon using the icon property]
                            Tab(
                                child :
                                AutoSizeText('Leicht', group: mySizeGRP_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                            ),

                            // second tab [you can add an icon using the icon property]
                            Tab(
                                child : AutoSizeText('Normal', group: mySizeGRP_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                            ),

                            Tab(
                                child : AutoSizeText('Schwer', group: mySizeGRP_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                            ),
                          ],
                        ),
                      ),
                      // tab bar view here
                      Flexible(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // first tab bar view widget
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(children: [
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                      width: MediaQuery.of(context).size.width * 1,
                                      height: MediaQuery.of(context).size.height * 0.1,
                                      decoration: const ShapeDecoration(
                                          color: Colors.white70,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 2,
                                                  color: Colors.black)
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                              DropdownButton<String>(
                                                isExpanded: true,
                                              value: dropdownValue,
                                                itemHeight: MediaQuery.of(context).size.height*0.09,
                                              icon: Icon(Icons.arrow_downward,size: MediaQuery.of(context).size.width * 0.1),
                                              elevation: 16,
                                              style: TextStyle(
                                                shadows: const <Shadow>[
                                                  Shadow(
                                                    offset: Offset(0.0, 0.0),
                                                    blurRadius: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                                color: Colors.black,
                                                fontSize: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.05,
                                                fontFamily: "Qaz",
                                              ),
                                                underline: const SizedBox.shrink(),
                                              onChanged: (String? value) {
                                                // This is called when the user selects an item.
                                                setState(() {
                                                  dropdownValue = value!;
                                                });
                                              },
                                              items: frequenz.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value,
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(context).size.height * 0.05,
                                                      )),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ),
                                ),
                                ValueListenableBuilder<Box<Word>>(
                                    valueListenable: Boxes.getWords().listenable(),
                                    builder: (context,box,_){
                                      final words = box.values.toList().cast<Word>();

                                      return buildContent(words,orientation);
                                    }
                                ),
                              ]),
                            ),
                            // second tab bar view widget
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(children: [
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: MediaQuery.of(context).size.height * 0.1,
                                    decoration: const ShapeDecoration(
                                        color: Colors.white70,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 2,
                                                color: Colors.black)
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            value: dropdownValue,
                                            itemHeight: MediaQuery.of(context).size.height*0.09,
                                            icon: Icon(Icons.arrow_downward,size: MediaQuery.of(context).size.width * 0.1),
                                            elevation: 16,
                                            style: TextStyle(
                                              shadows: const <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 0.0),
                                                  blurRadius: 0.0,
                                                  color: Colors.black,
                                                ),
                                              ],
                                              color: Colors.black,
                                              fontSize: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.05,
                                              fontFamily: "Qaz",
                                            ),
                                            underline: const SizedBox.shrink(),
                                            onChanged: (String? value) {
                                              // This is called when the user selects an item.
                                              setState(() {
                                                dropdownValue = value!;
                                              });
                                            },
                                            items: frequenz.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value,
                                                    style: TextStyle(
                                                      fontSize: MediaQuery.of(context).size.height * 0.05,
                                                    )),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ValueListenableBuilder<Box<Word>>(
                                    valueListenable: Boxes.getWords().listenable(),
                                    builder: (context,box,_){
                                      final words = box.values.toList().cast<Word>();

                                      return buildContent(words,orientation);
                                    }
                                ),
                              ]),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(children: [
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: MediaQuery.of(context).size.height * 0.1,
                                    decoration: const ShapeDecoration(
                                        color: Colors.white70,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 2,
                                                color: Colors.black)
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            value: dropdownValue,
                                            itemHeight: MediaQuery.of(context).size.height*0.09,
                                            icon: Icon(Icons.arrow_downward,size: MediaQuery.of(context).size.width * 0.1),
                                            elevation: 16,
                                            style: TextStyle(
                                              shadows: const <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 0.0),
                                                  blurRadius: 0.0,
                                                  color: Colors.black,
                                                ),
                                              ],
                                              color: Colors.black,
                                              fontSize: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.05,
                                              fontFamily: "Qaz",
                                            ),
                                            underline: const SizedBox.shrink(),
                                            onChanged: (String? value) {
                                              // This is called when the user selects an item.
                                              setState(() {
                                                dropdownValue = value!;
                                              });
                                            },
                                            items: frequenz.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value,
                                                    style: TextStyle(
                                                      fontSize: MediaQuery.of(context).size.height * 0.05,
                                                    )),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ValueListenableBuilder<Box<Word>>(
                                    valueListenable: Boxes.getWords().listenable(),
                                    builder: (context,box,_){
                                      final words = box.values.toList().cast<Word>();

                                      return buildContent(words,orientation);
                                    }
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
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
                                Icons.home,
                                color: Colors.black,
                              )),
                          SizedBox(width: MediaQuery.of(context).size.width*0.02),
                          Text('Fortschritt',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, shadows: const <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 1.0,
                              color: Colors.black,
                            ),
                          ]), maxLines: 1, overflow: TextOverflow.ellipsis)
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width*0.05,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          // give the indicator a decoration (color and border radius)
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                            color: Colors.lightBlueAccent,
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            // first tab [you can add an icon using the icon property]
                            Tab(
                                child :
                                AutoSizeText('Leicht', group: mySizeGRP_H, style: const TextStyle(fontSize: 200, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                            ),

                            // second tab [you can add an icon using the icon property]
                            Tab(
                                child : AutoSizeText('Normal', group: mySizeGRP_H, style: const TextStyle(fontSize: 200, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                            ),

                            Tab(
                                child : AutoSizeText('Schwer', group: mySizeGRP_H, style: const TextStyle(fontSize: 200, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                            ),
                          ],
                        ),
                      ),
                      // tab bar view here
                      Flexible(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // first tab bar view widget
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Column(children: [
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: MediaQuery.of(context).size.width * 0.098,
                                    decoration: const ShapeDecoration(
                                        color: Colors.white70,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 2,
                                                color: Colors.black)
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            value: dropdownValue,
                                            //itemHeight: MediaQuery.of(context).size.height*0.15,
                                            icon: Icon(Icons.arrow_downward,size: MediaQuery.of(context).size.width * 0.05),
                                            elevation: 16,
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
                                            ),
                                            underline: const SizedBox.shrink(),
                                            onChanged: (String? value) {
                                              // This is called when the user selects an item.
                                              setState(() {
                                                dropdownValue = value!;
                                              });
                                            },
                                            items: frequenz.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value,
                                                    style: TextStyle(
                                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                                    )),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ValueListenableBuilder<Box<Word>>(
                                    valueListenable: Boxes.getWords().listenable(),
                                    builder: (context,box,_){
                                      final words = box.values.toList().cast<Word>();

                                      return buildContent(words,orientation);
                                    }
                                ),
                              ]),
                            ),
                            // second tab bar view widget
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Column(children: [
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: MediaQuery.of(context).size.height * 0.163,
                                    decoration: const ShapeDecoration(
                                        color: Colors.white70,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 2,
                                                color: Colors.black)
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            value: dropdownValue,
                                            //itemHeight: MediaQuery.of(context).size.height*0.15,
                                            icon: Icon(Icons.arrow_downward,size: MediaQuery.of(context).size.width * 0.05),
                                            elevation: 16,
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
                                            ),
                                            underline: const SizedBox.shrink(),
                                            onChanged: (String? value) {
                                              // This is called when the user selects an item.
                                              setState(() {
                                                dropdownValue = value!;
                                              });
                                            },
                                            items: frequenz.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value,
                                                    style: TextStyle(
                                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                                    )),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ValueListenableBuilder<Box<Word>>(
                                    valueListenable: Boxes.getWords().listenable(),
                                    builder: (context,box,_){
                                      final words = box.values.toList().cast<Word>();

                                      return buildContent(words,orientation);
                                    }
                                ),
                              ]),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Column(children: [
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    width: MediaQuery.of(context).size.width * 1,
                                    height: MediaQuery.of(context).size.height * 0.163,
                                    decoration: const ShapeDecoration(
                                        color: Colors.white70,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 2,
                                                color: Colors.black)
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            value: dropdownValue,
                                            //itemHeight: MediaQuery.of(context).size.height*0.15,
                                            icon: Icon(Icons.arrow_downward,size: MediaQuery.of(context).size.width * 0.05),
                                            elevation: 16,
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
                                            ),
                                            underline: const SizedBox.shrink(),
                                            onChanged: (String? value) {
                                              // This is called when the user selects an item.
                                              setState(() {
                                                dropdownValue = value!;
                                              });
                                            },
                                            items: frequenz.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value,
                                                    style: TextStyle(
                                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                                    )),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ValueListenableBuilder<Box<Word>>(
                                    valueListenable: Boxes.getWords().listenable(),
                                    builder: (context,box,_){
                                      final words = box.values.toList().cast<Word>();

                                      return buildContent(words,orientation);
                                    }
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      // give the tab bar a height [can change hheight to preferred height]
                    ],
                  );
              }
            }),
          ),
        ));
  }

  Widget buildContent(List<Word> words, Orientation orientation) {
    var mySizeGRP_V_kategorien = AutoSizeGroup();
    if (words.isEmpty) {
      return const Center(
        child: AutoSizeText('Keine Daten gefunden!', style: TextStyle(fontSize: 70, shadows: <Shadow>[
          Shadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 1.0,
            color: Colors.black,
          ),
        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis),
      );
    } else {
      var richtigesWort = 0;
      var falschesWort = 0;
      var Spielgewonnen = 0;
      var Spielverloren = 0;
      var h1 = 0;
      var h2 = 0;
      var h3 = 0;
      var h4 = 0;
      var currentDiff_ = "Leicht";
      var gewonneneKateogrien = [];

      if(_tabController.index == 0) {
          currentDiff_ = "Leicht";
      }
      if(_tabController.index == 1) {
        currentDiff_ = "Normal";
      }
      if(_tabController.index == 2) {
        currentDiff_ = "Schwer";
      }
      print(currentDiff_);
      print(dropdownValue);
      for(int i = 0; i < words.length; i++){
        if(words[i].diff == currentDiff_){
          if(words[i].freq == dropdownValue){
              if (words[i].H1 == 1) {
                h1++;
              }
              if (words[i].H2 == 1) {
                h2++;
              }
              if (words[i].H3 == 1) {
                h3++;
              }
              if (words[i].H4 == 1) {
                h4++;
              }
              if (words[i].rOderF.contains("richtig")) {
                richtigesWort++;
              }
              if (words[i].rOderF.contains("G")) {
                Spielgewonnen++;
                gewonneneKateogrien.add(words[i].category);
              }
              if (words[i].rOderF.contains("falsch")) {
                falschesWort++;
              }
              if (words[i].rOderF.contains("V")) {
                Spielverloren++;
              }
          }
        }
      }
      if (orientation == Orientation.portrait) {
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: itemsMAP.entries.toList().length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      color: Colors.black,
                      child: Card(
                          color: gewonneneKateogrien.contains(itemsMAP.entries.toList()[index].value[0])? Colors.green: itemsMAP.entries.toList()[index].value[0] == "Gesamt" ? Colors.lightBlueAccent:Colors.white70,
                          child: ListTile(
                            onTap: () {
                              List progressData = [currentDiff_,dropdownValue,itemsMAP.entries.toList()[index].value[0]];
                              Navigator.pushNamed(context, Routes.progressEINZEL, arguments: progressData);
                            },
                            contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              minLeadingWidth: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.1,
                            title:
                            AutoSizeText(itemsMAP.entries.toList()[index].key, group: mySizeGRP_V_kategorien, style: const TextStyle(fontSize: 80, shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 1.0,
                                color: Colors.black,
                              ),
                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                            leading: Icon(
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
                                    .height * 0.06,
                                color: Colors.white,
                                IconData(itemsMAP.entries.toList()[index].value[1], fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter')
                            ),
                            trailing:
                            itemsMAP.entries.toList()[index].value[0] != "Gesamt" ?
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
                                    .height * 0.06,
                                color: gewonneneKateogrien.contains(itemsMAP.entries.toList()[index].value[0])? Colors.yellow: Colors.white70,
                                gewonneneKateogrien.contains(itemsMAP.entries.toList()[index].value[0])? const IconData(0xf091, fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter'): const IconData(0xf110, fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter')
                            )
                                : const SizedBox.shrink()
                            ,
                          )))
                ],
              ),
            ),
          ),
        );
      }
      else
        {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemsMAP.entries.toList().length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        color: Colors.black,
                        child: Card(
                            color: gewonneneKateogrien.contains(itemsMAP.entries.toList()[index].value[0])? Colors.green: itemsMAP.entries.toList()[index].value[0] == "Gesamt" ? Colors.lightBlueAccent:Colors.white70,
                            child:
                            ListTile(
                              onTap: () {
                                List progressData = [currentDiff_,dropdownValue,itemsMAP.entries.toList()[index].value[0]];
                                Navigator.pushNamed(context, Routes.progressEINZEL, arguments: progressData);
                              },
                              contentPadding: const EdgeInsets.fromLTRB(10, 0, 10,0),
                              title:
                              AutoSizeText(itemsMAP.entries.toList()[index].key, group: mySizeGRP_V_kategorien, style: const TextStyle(fontSize: 30, shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 1.0,
                                  color: Colors.black,
                                ),
                              ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                              leading: Icon(
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
                                      .width * 0.04,
                                  color: Colors.white,
                                  IconData(itemsMAP.entries.toList()[index].value[1], fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter')
                              ),
                              trailing:
                              itemsMAP.entries.toList()[index].value[0] != "Gesamt" ?
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
                                      .width * 0.04,
                                  color: gewonneneKateogrien.contains(itemsMAP.entries.toList()[index].value[0])? Colors.yellow: Colors.white70,
                                  gewonneneKateogrien.contains(itemsMAP.entries.toList()[index].value[0])? const IconData(0xf091, fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter'): const IconData(0xf110, fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter')
                              )
                                  : SizedBox.shrink()
                              ,
                            )))
                  ],
                ),
              ),
            ),
          );
        }

    }
  }


}
