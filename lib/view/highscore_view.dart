import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortschatz/model/highscore/dummy_data.dart';

class HighScoreScreen extends StatefulWidget {
  // final List<HighScore> scores;
  const HighScoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HighScoreScreen> createState() => _HighScoreScreenState();
}

class _HighScoreScreenState extends State<HighScoreScreen> with TickerProviderStateMixin {
  var emoji = ['🥇', '🥈', '🥉'];
  late int rank1,rank2,rank3;
  late Future<List<HighScore>> initFuture;
  late TabController _tabController;

  @override
  void initState() {
    initFuture =
        Provider.of<HighScoreItems>(context, listen: false).fetchData();
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

  Future<List<HighScore>> getList() async {
    List<HighScore> initFuture =
        await Provider.of<HighScoreItems>(context, listen: false).fetchData();
    return initFuture;
  }


  TextStyle txt = const TextStyle(
      fontFamily: "PatrickHand", fontSize: 30, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    var mySizeGRP_V = AutoSizeGroup();
    var mySizeGRP2_V = AutoSizeGroup();
    var mySizeGRP_H = AutoSizeGroup();
    var mySizeGRP2_H = AutoSizeGroup();
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
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
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
                          iconSize: MediaQuery.of(context).size.width*0.1,
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            shadows: <Shadow>[
                            ],
                            Icons.home,
                            color: Colors.black,
                          )),
                      SizedBox(width: MediaQuery.of(context).size.width*0.02),
                      Text('Rangliste',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1, shadows: const <Shadow>[
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
                          padding: const EdgeInsets.fromLTRB(8,8,8,8),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child:
                                AutoSizeText('Platz', group: mySizeGRP2_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                Flexible(child:
                                AutoSizeText('Name', group: mySizeGRP2_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                Flexible(child:
                                AutoSizeText('Punkte', group: mySizeGRP2_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                              ],
                            ),
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
                                        child: AutoSizeText('Keine Spieler gefunden!', style: TextStyle(fontSize: 200, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
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
                                            0, 8, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            AutoSizeText(rank1 < 3
                                                ? emoji[rank1++]
                                                : " ${++rank1}", group: mySizeGRP_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                            AutoSizeText(highscore.item[index].date, group: mySizeGRP_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                            AutoSizeText(highscore.item[index].score
                                                .toString(), group: mySizeGRP_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                                          ],
                                        ),
                                      ): const SizedBox.shrink(),
                                    ),
                                  );
                                }
                              }),
                            )
                          ]),
                        ),
                        // second tab bar view widget
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8,8,8,8),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child:
                                AutoSizeText('Platz', group: mySizeGRP2_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                Flexible(child:
                                AutoSizeText('Name', group: mySizeGRP2_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                Flexible(child:
                                AutoSizeText('Punkte', group: mySizeGRP2_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                              ],
                            ),
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
                                        child: AutoSizeText('Keine Spieler gefunden!', style: TextStyle(fontSize: 200, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    builder: (context, highscore, ch) =>
                                    highscore.item.isEmpty ? ch!
                                        : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: highscore.item.length,
                                      itemBuilder: (context, index) =>
                                      highscore.item[index].diff == 'Normal' ?
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            AutoSizeText(rank1 < 3
                                                ? emoji[rank1++]
                                                : " ${++rank1}", group: mySizeGRP_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                            AutoSizeText(highscore.item[index].date, group: mySizeGRP_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                            AutoSizeText(highscore.item[index].score
                                                .toString(), group: mySizeGRP_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                                          ],
                                        ),
                                      ): const SizedBox.shrink(),
                                    ),
                                  );
                                }
                              }),
                            )
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8,8,8,8),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child:
                                AutoSizeText('Platz', group: mySizeGRP2_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                Flexible(child:
                                AutoSizeText('Name', group: mySizeGRP2_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                Flexible(child:
                                AutoSizeText('Punkte', group: mySizeGRP2_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                              ],
                            ),
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
                                        child: AutoSizeText('Keine Spieler gefunden!', style: TextStyle(fontSize: 200, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    builder: (context, highscore, ch) =>
                                    highscore.item.isEmpty ? ch!
                                        : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: highscore.item.length,
                                      itemBuilder: (context, index) =>
                                      highscore.item[index].diff == 'Schwer' ?
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            AutoSizeText(rank1 < 3
                                                ? emoji[rank1++]
                                                : " ${++rank1}", group: mySizeGRP_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                            AutoSizeText(highscore.item[index].date, group: mySizeGRP_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                            AutoSizeText(highscore.item[index].score
                                                .toString(), group: mySizeGRP_V, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                                          ],
                                        ),
                                      ): const SizedBox.shrink(),
                                    ),
                                  );
                                }
                              }),
                            )
                          ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          iconSize: MediaQuery.of(context).size.width*0.06,
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            shadows: <Shadow>[
                            ],
                            Icons.home,
                            color: Colors.black,
                          )),
                      SizedBox(width: MediaQuery.of(context).size.width*0.02),
                      Text('Rangliste',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, shadows: const <Shadow>[
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
                    height: MediaQuery.of(context).size.height*0.1,
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
                            AutoSizeText('Leicht', group: mySizeGRP_H, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 1.0,
                                color: Colors.black,
                              ),
                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                        ),

                        // second tab [you can add an icon using the icon property]
                        Tab(
                            child : AutoSizeText('Normal', group: mySizeGRP_H, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 1.0,
                                color: Colors.black,
                              ),
                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                        ),

                        Tab(
                            child : AutoSizeText('Schwer', group: mySizeGRP_H, style: const TextStyle(fontSize: 70, shadows: <Shadow>[
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
                          padding: const EdgeInsets.fromLTRB(8,8,8,8),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child:
                                AutoSizeText('Platz', group: mySizeGRP2_H, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                Flexible(child:
                                AutoSizeText('Name', group: mySizeGRP2_H, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                Flexible(child:
                                AutoSizeText('Punkte', group: mySizeGRP2_H, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                              ],
                            ),
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
                                        child: AutoSizeText('Keine Spieler gefunden!', style: TextStyle(fontSize: 200, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
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
                                            0, 8, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            AutoSizeText(rank1 < 3
                                                ? emoji[rank1++]
                                                : " ${++rank1}", group: mySizeGRP_V, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                            AutoSizeText(highscore.item[index].date, group: mySizeGRP_V, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                            AutoSizeText(highscore.item[index].score
                                                .toString(), group: mySizeGRP_V, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                                          ],
                                        ),
                                      ): const SizedBox.shrink(),
                                    ),
                                  );
                                }
                              }),
                            )
                          ]),
                        ),
                        // second tab bar view widget
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8,8,8,8),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child:
                                AutoSizeText('Platz', group: mySizeGRP2_H, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                Flexible(child:
                                AutoSizeText('Name', group: mySizeGRP2_H, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                Flexible(child:
                                AutoSizeText('Punkte', group: mySizeGRP2_H, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                              ],
                            ),
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
                                        child: AutoSizeText('Keine Spieler gefunden!', style: TextStyle(fontSize: 200, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    builder: (context, highscore, ch) =>
                                    highscore.item.isEmpty ? ch!
                                        : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: highscore.item.length,
                                      itemBuilder: (context, index) =>
                                      highscore.item[index].diff == 'Normal' ?
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            AutoSizeText(rank1 < 3
                                                ? emoji[rank1++]
                                                : " ${++rank1}", group: mySizeGRP_V, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                            AutoSizeText(highscore.item[index].date, group: mySizeGRP_V, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                            AutoSizeText(highscore.item[index].score
                                                .toString(), group: mySizeGRP_V, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                                          ],
                                        ),
                                      ): const SizedBox.shrink(),
                                    ),
                                  );
                                }
                              }),
                            )
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8,8,8,8),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child:
                                AutoSizeText('Platz', group: mySizeGRP2_H, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                Flexible(child:
                                AutoSizeText('Name', group: mySizeGRP2_H, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                Flexible(child:
                                AutoSizeText('Punkte', group: mySizeGRP2_H, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 5, maxLines: 1, overflow: TextOverflow.ellipsis)),
                              ],
                            ),
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
                                        child: AutoSizeText('Keine Spieler gefunden!', style: TextStyle(fontSize: 200, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    builder: (context, highscore, ch) =>
                                    highscore.item.isEmpty ? ch!
                                        : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: highscore.item.length,
                                      itemBuilder: (context, index) =>
                                      highscore.item[index].diff == 'Schwer' ?
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            AutoSizeText(rank1 < 3
                                                ? emoji[rank1++]
                                                : " ${++rank1}", group: mySizeGRP_V, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                            AutoSizeText(highscore.item[index].date, group: mySizeGRP_V, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                                            AutoSizeText(highscore.item[index].score
                                                .toString(), group: mySizeGRP_V, style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                                color: Colors.black,
                                              ),
                                            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                                          ],
                                        ),
                                      ): const SizedBox.shrink(),
                                    ),
                                  );
                                }
                              }),
                            )
                          ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    ));
  }
}
