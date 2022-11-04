import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wortschatz/view/highscore_view.dart';
import 'package:wortschatz/view/start_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget createButton(BuildContext context, String buttonName,int iconCodePoint,String heroTag, func) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: FloatingActionButton.extended(
        heroTag: heroTag,
        //extendedPadding: EdgeInsets.fromLTRB(20, 30, 20, 30),
        //extendedIconLabelSpacing: 2,
        splashColor: Colors.lightGreen,
        backgroundColor: Color(0xFF00DFFF),
        icon: Icon(
            shadows: const <Shadow>[
             Shadow(
               offset: Offset(0.0, 0.0),
                blurRadius: 5.0,
                color: Colors.black,
              ),
            ],
            size: 50,
            color: Colors.white,
            IconData(iconCodePoint,fontFamily: 'MaterialIcons')),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => func)),
        label: Text(
          buttonName,
          style: const TextStyle(
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 5.0,
                color: Colors.black,
              ),
            ],
            color: Colors.white,
            fontSize: 30,
            fontFamily: "Modak",
          ),
        ),
      ),
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
                      height: MediaQuery.of(context).size.height*0.30,
                      child: Image.asset("assets/images/Homescreen_BIG.png"),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                        alignment: Alignment.center,
                            child: createButton(context, "   Start             ", 0xf2af, "btn1", const StartScreen()),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                            child: createButton(context, "    Fortschritt ",0xf05ae, "btn2", const HighScoreScreen()),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                          child: createButton(context, "    Anleitung   ",0xe309, "btn3", const HighScoreScreen()),
                    ),
                    Container(
                          width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                          child: createButton(context, "   Einstellung ",0xe57f, "btn4", const HighScoreScreen()),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                        child: createButton(context, "    Impressum ",0xe33c, "btn5", const HighScoreScreen())
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
