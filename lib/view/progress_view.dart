// Gesamtstatistik (verloren/gewonnen)
// Statistk per Kategorie
// angeforderte Hilfe

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortschatz/model/progress/progress.dart';

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
  var emoji = ['🥇', '🥈', '🥉'];
  late int rank1,rank2,rank3;
  late Future<List<Progress>> initFuture;
  late TabController _tabController;
  String dropdownValue = frequenz.first;
  static const _gapW = SizedBox(width: 20);
  static const _gapH = SizedBox(height: 10);


  @override
  void initState() {
    initFuture =
        Provider.of<ProgressItems>(context, listen: false).fetchData();
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

  Future<List<Progress>> getList() async {
    List<Progress> initFuture =
    await Provider.of<ProgressItems>(context, listen: false).fetchData();
    return initFuture;
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
                          tabs: const[
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
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                                          children:const [
                                                            Text(
                                                              '2',
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
                                                          children:const [
                                                            Text(
                                                              '2',
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
                                                          children:const [
                                                            Text(
                                                              '2',
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
                                                          children:const [
                                                            Text(
                                                              '2',
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
                                                          children:const [
                                                            Text(
                                                              '2',
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
                                                          children:const [
                                                            Text(
                                                              '2',
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
                                                          children:const [
                                                            Text(
                                                              '2',
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
                                                          children:const [
                                                            Text(
                                                              '200',
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
                                Directionality(textDirection: TextDirection.rtl, child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(const Size(1,1)),
                                      alignment: Alignment.center,
                                      backgroundColor: MaterialStateProperty.resolveWith((state) {
                                        if (state.contains(MaterialState.pressed)) return Colors.grey;
                                        return Colors.white;
                                      }),
                                      shadowColor: MaterialStateProperty.all(Colors.transparent),
                                      side: MaterialStateProperty.all(const BorderSide(width: 2))),
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                  icon: Icon(
                                      shadows: const <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 2.0,
                                          color: Colors.black,
                                        ),
                                      ],
                                      size: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.07,
                                      color: Colors.black,
                                      const IconData(0xe09c, fontFamily: 'MaterialIcons')),
                                  label: Text("Kategorie Fortschritt",
                                    style: TextStyle(
                                      shadows: const <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 2.0,
                                          color: Colors.black,
                                        ),
                                      ],
                                      color: Colors.black,
                                      fontSize: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.03,
                                      fontFamily: "Qaz",
                                    ),
                                  ),
                                ))
                              ]),
                            ),
                            // second tab bar view widget
                            Padding(
                              padding: const EdgeInsets.all(20),
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
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                            )
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              ]),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(20),
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
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                            )
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                                /*
                                FutureBuilder(
                                  future: initFuture,
                                  builder: ((context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      return Consumer<HighScoreItems>(
                                        child: const SizedBox(
                                          height: 50,
                                          child: Center(
                                            // child: CircularProgressIndicator(),
                                            child: Text(
                                              'Keine Spieler gefunden!',
                                              style: TextStyle(
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
                                          ),
                                        ),
                                        builder: (context, highscore, ch) =>
                                        highscore.item.isEmpty ? ch!
                                            : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: highscore.item.length,
                                          itemBuilder: (context, index) =>
                                          highscore.item[index].diff == 'Leicht' ?
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  rank1 < 3
                                                      ? emoji[rank1++]
                                                      : " ${++rank1}",
                                                  style: const TextStyle(
                                                      shadows: <Shadow>[
                                                        Shadow(
                                                          offset: Offset(0.0, 0.0),
                                                          blurRadius: 2.0,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                      fontFamily: "Qaz",
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  highscore.item[index].date,
                                                  // .toString()
                                                  // .substring(0, 10),
                                                  style: const TextStyle(
                                                      shadows: <Shadow>[
                                                        Shadow(
                                                          offset: Offset(0.0, 0.0),
                                                          blurRadius: 2.0,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                      fontFamily: "Qaz",
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  highscore.item[index].score
                                                      .toString(),
                                                  style: const TextStyle(
                                                      shadows: <Shadow>[
                                                        Shadow(
                                                          offset: Offset(0.0, 0.0),
                                                          blurRadius: 2.0,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                      fontFamily: "Qaz",
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ): const SizedBox.shrink(),
                                        ),
                                      );
                                    }
                                  }),
                                )

                                 */
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
}
