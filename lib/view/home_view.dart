import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wortschatz/view/highscore_view.dart';
import 'package:wortschatz/view/start_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget createButton(BuildContext context, String buttonName,int iconCodePoint,String heroTag, func) {
    return Scaffold(
        floatingActionButton:
            Container(
              alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width *0.80,
                  child: FloatingActionButton.extended(
                    heroTag: heroTag,
                    splashColor: Colors.lightGreen,
                    backgroundColor: const Color(0xFF00DFFF),
                    icon: Icon(
                        shadows: const <Shadow>[
                          Shadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 5.0,
                            color: Colors.black,
                          ),
                        ],
                        size: MediaQuery.of(context).size.height * 0.10,
                        color: Colors.white,
                        IconData(iconCodePoint,fontFamily: 'MaterialIcons')),
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => func)),
                    label: Text(
                      buttonName,
                      style: TextStyle(
                        shadows: const <Shadow>[
                          Shadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 5.0,
                            color: Colors.black,
                          ),
                        ],
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * 0.04,
                        fontFamily: "Modak",
                      ),
                    ),
                  ),

                )
            )
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: OrientationBuilder(builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.3,
                      child: Image.asset("assets/images/Homescreen_BIG.png"),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                        alignment: Alignment.center,
                            child: createButton(context, "Start", 0xf2af, "btn1", const StartScreen()),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                            child: createButton(context, "Fortschritt",0xf05ae, "btn2", const HighScoreScreen()),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                          child: createButton(context, "Anleitung",0xe309, "btn3", const HighScoreScreen()),
                    ),
                    Container(
                          width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                          child: createButton(context, "Einstellung",0xe57f, "btn4", const HighScoreScreen()),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                        child: createButton(context, "Impressum",0xe33c, "btn5", const HighScoreScreen())
                    ),
                  ],
              );
              } else {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.30,
                            child: Image.asset("assets/images/Homescreen_BIG.png"),
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: MediaQuery.of(context).size.height*0.10,
                              alignment: Alignment.center,
                              child: createButton(context, "   Start             ", 0xf2af, "btn1", const StartScreen()),
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: MediaQuery.of(context).size.height*0.10,
                              alignment: Alignment.center,
                              child: createButton(context, "    Fortschritt ",0xf05ae, "btn2", const HighScoreScreen()),
                            ),
                          ],),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: MediaQuery.of(context).size.height*0.10,
                              alignment: Alignment.center,
                              child: createButton(context, "   Einstellung ",0xe57f, "btn4", const HighScoreScreen()),
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                height: MediaQuery.of(context).size.height*0.10,
                                alignment: Alignment.center,
                                child: createButton(context, "    Impressum ",0xe33c, "btn5", const HighScoreScreen())
                            ),
                          ],),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: MediaQuery.of(context).size.height*0.10,
                              alignment: Alignment.center,
                              child: createButton(context, "    Anleitung   ",0xe309, "btn3", const HighScoreScreen()),
                            ),
                          ],
                         ),
                      ]

                );
              }
            }),
          ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
