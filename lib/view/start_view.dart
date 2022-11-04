import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wortschatz/model/db_helper.dart';
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
  late final String category;
  final _name = TextEditingController();
  late String stored;
  int lives = 3;
  int score = 0;
  var index = 0;
  List sword = [];
  late int randomIndex;
  late String randomWord;

  void newGame() {
    setState(() {
      alphabets.updateAll((key, value) => value = 0);
      index = 0;
      randomIndex = Random().nextInt(word.length);
      randomWord = word[randomIndex];
      sword = List.generate(randomWord.length, (index) => "_");
      stored = randomWord;
      print(randomWord);
    });
  }

  @override
  void initState() {
    alphabets.updateAll((key, value) => value = 0);
    randomIndex = Random().nextInt(word.length);
    randomWord = word[randomIndex];
    sword = List.generate(randomWord.length, (index) => "_");
    stored = randomWord;
    print(randomWord);
    print('as');
    super.initState();
  }

  void refresh() {
    Navigator.of(context).pop();
    return;
  }

  Widget underscore(String chr) {
    return Text(
      "$chr ",
      style: const TextStyle(
        // fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: "PatrickHand",
          fontSize: 30),
    );
  }

  Widget alphaContainer(var name, Color color) {
    return Container(
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      alignment: Alignment.center,
      width: 50,
      child: Text(
        name,
        style: const TextStyle(
          // fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: "PatrickHand",
            fontSize: 30),
      ),
    );
  }

  Widget createButton(var name) {
    return alphabets[name] == 0
        ? InkWell(
       //splashColor: Colors.deepOrange,
        onTap: () {
          setState(() {
            if (alphabets[name] == 0) {
              var chr = name.toString().toLowerCase();
              if (randomWord.contains(chr)) {
                while (randomWord.contains(chr)) {
                  int getIndex = randomWord.indexOf((chr));
                  randomWord = randomWord.replaceFirst(chr, '_');
                  sword[getIndex] = chr;
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
                                      size: 70,
                                    ),
                                    Text(
                                      stored.toString(),
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontFamily: "PatrickHand",
                                          fontSize: 50),
                                    ),
                                    IconButton(
                                        icon: const Icon(
                                          Icons.arrow_circle_right,
                                          size: 40,
                                          color: Colors.white,
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
                                          color: Colors.white,
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
          Colors.blue.shade600,
        ))
        : alphaContainer(name, Colors.blueGrey);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.deepPurple.shade900,
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
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          score.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontFamily: "PatrickHand"),
                        ),
                        Stack(children: [
                          const Icon(
                            Icons.favorite,
                            size: 35,
                            color: Colors.white,
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
                          mainAxisSpacing: 10, crossAxisCount: 7),
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
