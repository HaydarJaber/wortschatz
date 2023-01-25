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

class _HighScoreScreenState extends State<HighScoreScreen> {
  var emoji = ['🥇', '🥈', '🥉'];
  late int rank;
  late Future<List<HighScore>> initFuture;

  @override
  void initState() {
    initFuture =
        Provider.of<HighScoreItems>(context, listen: false).fetchData();
    rank = 0;
    super.initState();
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
            return SingleChildScrollView(
              child: Column(children: [
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
                                    itemCount: highscore.item.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            rank < 3
                                                ? emoji[rank++]
                                                : (++rank).toString(),
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
                                    ),
                                  ),
                          );
                        }
                      }),
                    )
                  ]),
                )
              ]),
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
