import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wortschatz/view/highscore_view.dart';
import 'package:wortschatz/view/start_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget createButton(BuildContext context, String buttonName,int iconCodePoint, func) {
    return SizedBox(
      height: 70,
      width: 300,
      child: FloatingActionButton.extended(
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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  60,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/images/Homescreen_BIG.png"),
                    createButton(context, "Start", 0xf2af, const StartScreen()),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    createButton(context, "Fortschritt",0xf05ae, const HighScoreScreen()),
                    createButton(context, "Anleitung",0xe309, const HighScoreScreen()),
                    createButton(context, "Einstellung",0xe57f, const HighScoreScreen()),
                    createButton(context, "Impressum",0xe33c, const HighScoreScreen())
                  ]),
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
