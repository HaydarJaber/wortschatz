// Gesamtstatistik (verloren/gewonnen)
// Statistk per Kategorie
// angeforderte Hilfe

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

final List<String> frequenz = ['Alle Wörter','Hochfrequente Wörter', 'Niedrigfrequente Wörter'];

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
                                Icons.home,
                                color: Colors.black,
                                size: 35,
                              )),
                          const SizedBox(width: 60),
                          const Text(
                            'Fortschritt',
                            style: TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 2.0,
                                    color: Colors.black,
                                  ),
                                ],
                                fontFamily: "Qaz",
                                fontSize: 35,
                                color: Colors.black),
                          )
                        ],
                      ),
                      // give the tab bar a height [can change hheight to preferred height]
                      Container(height: 10),
                      Container(
                        height: 45,
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
                          tabs: const [
                            // first tab [you can add an icon using the icon property]
                            Tab(
                              child : Text(
                                'Leicht',
                                style: TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 2.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                            ),
                            // second tab [you can add an icon using the icon property]
                            Tab(
                              child : Text(
                                'Normal',
                                style: TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 2.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                            ),
                            Tab(
                              child : Text(
                                'Schwer',
                                style: TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 2.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
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
                              padding: const EdgeInsets.all(10),
                              child: Column(children: [
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      height: MediaQuery.of(context).size.height * 0.07,
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
                                              icon: const Icon(Icons.arrow_downward),
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
                                                    .height * 0.035,
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
                                                        fontSize: MediaQuery.of(context).size.height * 0.03,
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

                                      return buildContent(words);
                                    }
                                ),
                              ]),
                            ),
                            // second tab bar view widget
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(children: [
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height * 0.07,
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
                                            icon: const Icon(Icons.arrow_downward),
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
                                                  .height * 0.035,
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
                                                      fontSize: MediaQuery.of(context).size.height * 0.03,
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

                                      return buildContent(words);
                                    }
                                ),
                              ]),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(children: [
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height * 0.07,
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
                                            icon: const Icon(Icons.arrow_downward),
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
                                                  .height * 0.035,
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
                                                      fontSize: MediaQuery.of(context).size.height * 0.03,
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

                                      return buildContent(words);
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

      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemsMAP.entries.toList().length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                          title: Text(
                            itemsMAP.entries.toList()[index].key,
                            style: const TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 2.0,
                                    color: Colors.black,
                                  ),
                                ],
                                fontFamily: "Qaz",
                                fontSize: 30,
                                color: Colors.black),
                          ),
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
                                  .height * 0.03,
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
                                  .height * 0.03,
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
