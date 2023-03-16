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
                        'Rangliste',
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
                          padding: const EdgeInsets.all(20),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Platz',
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
                                Text(
                                  'Name',
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
                                Text(
                                  'Punkte',
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
                                            const Text(
                                             // highscore.item[index].date,
                                              "Haydar H.J.",
                                              style: TextStyle(
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
                          ]),
                        ),
                        // second tab bar view widget
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Platz',
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
                                Text(
                                  'Name',
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
                                Text(
                                  'Punkte',
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
                                    builder: (context, highscore, ch) => highscore
                                        .item.isEmpty
                                        ? ch!
                                        : ListView.builder(
                                      shrinkWrap: true,
                                      //itemCount: highscore.item.length,
                                      itemCount: 15,
                                      itemBuilder: (context, index) =>
                                      highscore.item[index].diff == 'Normal' ?
                                               Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                              Text(
                                                rank2 < 3
                                                    ? emoji[rank2++]
                                                    : " ${++rank2}",
                                                style: const TextStyle(
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset: Offset(
                                                            0.0, 0.0),
                                                        blurRadius: 2.0,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                    fontFamily: "Qaz",
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            const Text(
                                                //highscore.item[index].date,
                                              "Haydar H.J.",
                                                style: TextStyle(
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset: Offset(
                                                            0.0, 0.0),
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
                                                        offset: Offset(
                                                            0.0, 0.0),
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
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Platz',
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
                                Text(
                                  'Name',
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
                                Text(
                                  'Punkte',
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
                                    builder: (context, highscore, ch) => highscore
                                        .item.isEmpty
                                        ? ch!
                                        : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 15,
                                      itemBuilder: (context, index) =>
                                      highscore.item[index].diff == 'Schwer' ?
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              rank3 < 3
                                                  ? emoji[rank3++]
                                                  : " ${++rank3}",
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
                                            const Text(
                                              //highscore.item[index].date,
                                              "Haydar H.J.",
                                              style: TextStyle(
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
                          ]),
                        )
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
