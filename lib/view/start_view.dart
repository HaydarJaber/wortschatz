import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wortschatz/model/words/hf_words.dart';
import 'package:wortschatz/model/constants/routes.dart';
import 'package:wortschatz/model/db_helper.dart';
import 'package:wortschatz/viewmodels/router/app_router.dart';
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
  final _name = TextEditingController();
  late String stored;
  int lives = 3;
  int score = 0;
  var index = 0;
  List sword = [];
  late int randomIndex;
  late String randomWord;


  //Nächstes Wort
  void newGame() {
    setState(() {
      alphabets.updateAll((key, value) => value = 0);
      index = 0;
      getCategory();
      sword = List.generate(randomWord.length, (index) => "_");
      stored = randomWord;
      print(randomWord);
    });
  }

  @override //Erstes Wort
  void initState() {
    alphabets.updateAll((key, value) => value = 0);
    getCategory();
    sword = List.generate(randomWord.length, (index) => "_");
    stored = randomWord;
    print(randomWord);
    super.initState();
  }

  void getCategory(){
    switch(widget.category){
      case Category.All:
        randomIndex = Random().nextInt(hfall.length);
        randomWord = hfall[randomIndex];
        break;
      case Category.Autoteile:
        randomIndex = Random().nextInt(hfAutoteile.length);
        randomWord = hfAutoteile[randomIndex];
        break;
    /* case Category.Badezimmer:
        randomIndex = Random().nextInt(hfBadezimmer.length);
        randomWord = hfBadezimmer[randomIndex];
        break;
      case Category.Bauernhof:
        return ;
      case Category.Berufe:
        return ;
      case Category.DeutscheStädte:
        return ;
      case Category.Fahrzeuge:
        return ;
      case Category.Garten:
        return ;
      case Category.Gemüse:
        return ;
      case Category.Getränke:
        return ;
      case Category.Hauptstädte:
      return ;
      case Category.Hausbau:
        return ;
      case Category.Hobbys:
        return ;
      case Category.Kleidung:
        return ;
      case Category.Körperteile:
      return ;
      case Category.Küche:
      return ;
      case Category.Länder:
      return ;
      case Category.Möbel:
      return ;
      case Category.Musikinstrumente:
        return ;
      case Category.Obst:
        return ;
      case Category.Pflanzen:
        return ;
      case Category.Resteraunt:
        return ;
      case Category.Sportarten:
        return ;
      case Category.Straßenverkehr:
        return ;
      case Category.Supermarkt:
        return ;
      case Category.Tiere:
        return ;
      case Category.Werkzeuge:
        randomIndex = Random().nextInt(word.length);
        randomWord = word[randomIndex]; */
    }
  }


  //refresh die Seite
  void refresh() {
    Navigator.of(context).pop();
    return;
  }

  //Unterstrich
  Widget underscore(String chr) {
    return Text(
      "$chr ",
      style: const TextStyle(
        // fontWeight: FontWeight.bold,
          color: Color(0xff00DFFF),
          fontFamily: "PatrickHand",
          fontSize: 40),
    );
  }

  //Buchstaben-Buttons
  Widget alphaContainer(var name, Color color) {
    return Container(
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      alignment: Alignment.center,
      width: 50,
      child: Text(
        name,
        style: const TextStyle(
           fontWeight: FontWeight.w100,
            color: Colors.white,
            fontFamily: "Modak",
            fontSize: 30),
      ),
    );
  }

  //erstelle Buttons
  Widget createButton(var name) {
    return alphabets[name] == 0
        ? InkWell(
       //splashColor: Colors.deepOrange,
        onTap: () {
          setState(() {
            if (alphabets[name] == 0) {
              var chr = name.toString().toLowerCase();
              var chrUP = name.toString();
              print(chr);
              print(chrUP);
              if (randomWord.contains(chr) || randomWord.contains(chrUP)) {
                if(randomWord.contains(chr)){
                  while (randomWord.contains(chr)) {
                    int getIndex = randomWord.indexOf((chr));
                    randomWord = randomWord.replaceFirst(chr, '_');
                    sword[getIndex] = chr;
                  }
                }else{
                  while (randomWord.contains(chrUP)) {
                    int getIndex = randomWord.indexOf((chrUP));
                    randomWord = randomWord.replaceFirst(chrUP, '_');
                    sword[getIndex] = chrUP;
                  }
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
                                      size: 60,
                                    ),
                                    Text(
                                      stored.toString(),
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontFamily: "Modak",
                                          fontSize: 20),
                                    ),
                                    IconButton(
                                        icon: const Icon(
                                          Icons.arrow_circle_right,
                                          size: 40,
                                          color: Color(0xff00DFFF),
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
                                          color: Color(0xff00DFFF),
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
          const Color(0xff00DFFF),
        ))
        : alphaContainer(name, Colors.blueGrey);
  }

  //Haupt build Widget
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
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
                            color: Color(0xff00DFFF),
                          ),
                        ),
                        Text(
                          score.toString(),
                          style: const TextStyle(
                              color: Color(0xff00DFFF),
                              fontSize: 35,
                              fontFamily: "PatrickHand"),
                        ),
                        Stack(children: [
                          const Icon(
                            Icons.favorite,
                            size: 35,
                            color: Color(0xff00DFFF),
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child:
                        Text(
                          ("Kategorie: ${widget.category}"),
                          style: const TextStyle(
                              color: Color(0xff00DFFF),
                              fontFamily: "PatrickHand",
                              fontSize: 30),
                        ),
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
                          mainAxisSpacing: 10, crossAxisCount: 6),
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
