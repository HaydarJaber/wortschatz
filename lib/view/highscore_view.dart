import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortschatz/model/dummy_data.dart';

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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.home,
                        color: Colors.blue,
                        size: 30,
                      )),
                  const Text(
                    '      Rangliste',
                    style: TextStyle(
                        fontFamily: "PatrickHand",
                        fontSize: 35,
                        color: Colors.white),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Platz',
                        style: txt,
                      ),
                      Text(
                        'Name',
                        style: txt,
                      ),
                      Text(
                        'Punkte',
                        style: txt,
                      )
                    ],
                  ),
                  FutureBuilder(
                    future: initFuture,
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Consumer<HighScoreItems>(
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              // child: CircularProgressIndicator(),
                              child: Text(
                                'Keine Spieler gefunden!',
                                style: txt,
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
                              padding:
                              const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    rank < 3
                                        ? emoji[rank++]
                                        : (++rank).toString(),
                                    style: const TextStyle(
                                        fontFamily: "PatrickHand",
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    highscore.item[index].date,
                                    // .toString()
                                    // .substring(0, 10),
                                    style: const TextStyle(
                                        fontFamily: "PatrickHand",
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    highscore.item[index].score
                                        .toString(),
                                    style: const TextStyle(
                                        fontFamily: "PatrickHand",
                                        fontSize: 20,
                                        color: Colors.white),
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
          ),
        ),
      ),
    );
  }
}
