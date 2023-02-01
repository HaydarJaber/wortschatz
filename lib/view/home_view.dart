import 'dart:ffi';
import 'package:wortschatz/viewmodels/widgets/menuButton.dart';
import 'package:flutter/material.dart';
import 'package:wortschatz/model/constants/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
         decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Hintergrund.jpg"),
              fit: BoxFit.cover
            ),
          ),
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
                            child: const MenuButton(label: "Start", route:  Routes.categories, iconCodePoint: 0xf2af,),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                            child: const MenuButton(label: "Rangliste", route: Routes.rank , iconCodePoint: 0xf05ae,)
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                        alignment: Alignment.center,
                        child: const MenuButton(label: "Fortschritt", route: Routes.progress , iconCodePoint: 0xe7ca,)
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                          child: const MenuButton(label: "Anleitung", route:  Routes.manual, iconCodePoint: 0xe309,)
                    ),
                    Container(
                          width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                          child: const MenuButton(label: "Einstellung", route: Routes.settings , iconCodePoint: 0xe57f,)
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                        child: const MenuButton(label: "Impressum", route: Routes.imprint , iconCodePoint: 0xe33c,)
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
                              child: const MenuButton(label: "Start", route:  Routes.categories, iconCodePoint: 0xf2af,),
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: MediaQuery.of(context).size.height*0.10,
                              alignment: Alignment.center,
                              child: const MenuButton(label: "Fortschritt", route: Routes.progress , iconCodePoint: 0xf05ae,)
                            ),
                          ],),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: MediaQuery.of(context).size.height*0.10,
                              alignment: Alignment.center,
                              child: const MenuButton(label: "Anleitung", route: Routes.manual , iconCodePoint: 0xe309,)
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                height: MediaQuery.of(context).size.height*0.10,
                                alignment: Alignment.center,
                                child: const MenuButton(label: "Einstellung", route: Routes.settings , iconCodePoint: 0xe57f,)
                            ),
                          ],),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: MediaQuery.of(context).size.height*0.10,
                              alignment: Alignment.center,
                              child: const MenuButton(label: "Impressum", route: Routes.imprint , iconCodePoint: 0xe33c,)
                            ),
                          ],
                         ),
                      ]
                );
              }
            }),
          ),
      ),
    );
  }
}
