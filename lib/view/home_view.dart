import 'package:flutter/material.dart';
import 'package:wortschatz/view/highscore_view.dart';
import 'package:wortschatz/view/start_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget createButton(BuildContext context, String buttonName, func) {
    return SizedBox(
      height: 45,
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue.shade600,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => func)),
        child: Text(
          buttonName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: "PatrickHand",
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
                    const Center(
                      child: Text("HANGMAN",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "PatrickHand",
                              fontSize: 50)),
                    ),
                    Image.asset("assets/images/gallow.png"),
                    // const SizedBox(
                    //   height: 40,
                    // ),
                    createButton(context, "Start", const StartScreen()),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    createButton(context, "High Score", const HighScoreScreen())
                  ]),
            ),
          ),
        ),
        backgroundColor: Colors.deepPurple.shade900,
      ),
    );
  }
}
