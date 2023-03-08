// Frequenz der Wörter (DONE)
///TODO: mit oder ohne Hilfe

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wortschatz/viewmodels/imprint_api.dart';
import 'package:wortschatz/view/start_view.dart';
import '../model/constants/categories.dart';
import '../model/constants/routes.dart';
import '../model/styles/responsive_screen.dart';
import 'package:wortschatz/viewmodels/settings/settings.dart';
import 'package:wortschatz/model/styles/palette.dart';

class ProgressCategory extends StatefulWidget {
  //final Map getProgress;

  const ProgressCategory({Key? key}) : super(key: key);

  @override
  _ProgressCategoryState createState() => _ProgressCategoryState();
}

class _ProgressCategoryState extends State<ProgressCategory> {
  final controller = PageController();
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool? newValue = false;
  bool showErrorMessage = false;
  static const _gap = SizedBox(width: 20);


  @override
  Widget build(BuildContext context) {

    final settings = context.watch<SettingsController>();
    final palette = context.watch<Palette>();
    late MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return SafeArea(
        child: Scaffold(
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
                  return Column(mainAxisSize: MainAxisSize.max, children: [
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
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                              size: 35,
                            )),
                        const SizedBox(width: 50),
                        const Text(
                          'Fortschritt',
                          style: TextStyle(shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 2.0,
                              color: Colors.black,
                            ),
                          ], fontFamily: "Qaz", fontSize: 35, color: Colors.black),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10-1,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             // (ProgresMap.entries.toList()[index].value[0].toString() == "1")
                                 // ?
                              Container(
                                  color: Colors.green[600],
                                  child: Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pushNamed(context, Routes.home);
                                        },
                                        title: Text(
                                          "Kategoriename",
                                          style: const TextStyle(
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 0.0),
                                                  blurRadius: 2.0,
                                                  color: Colors.black,
                                                ),
                                              ],
                                              fontFamily: "Qaz",
                                              fontSize: 35,
                                              color: Colors.green),
                                        ),
                                        subtitle: Text(
                                          "Hilfen: ",
                                          style: const TextStyle(
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
                                        leading: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/Wörter/".jpg'),
                                            radius: 40),
                                        // trailing: Icon(Icons.star)
                                      )))
                              /*
                                  : (ProgresMap.entries.toList()[index].value[0].toString() == "0") ?
                              Container(
                                  color: Colors.red[600],
                                  child: Card(
                                      child: ListTile(
                                        title: Text(
                                          "s",
                                          style: const TextStyle(
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 0.0),
                                                  blurRadius: 2.0,
                                                  color: Colors.black,
                                                ),
                                              ],
                                              fontFamily: "Qaz",
                                              fontSize: 40,
                                              color: Colors.red),
                                        ),
                                        subtitle: Text(
                                          "Hilfen: ",
                                          style: const TextStyle(
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
                                        leading: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/Wörter/${ProgresMap.entries.toList()[index].key}.jpg'),
                                            radius: 40),
                                        // trailing: Icon(Icons.star)
                                      )))
                                  : Card(
                                  child: ListTile(
                                    title: Text(
                                      ProgresMap.entries.toList()[index].key,
                                      style: const TextStyle(
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 2.0,
                                              color: Colors.black,
                                            ),
                                          ],
                                          fontFamily: "Qaz",
                                          fontSize: 40,
                                          color: Colors.grey),
                                    ),
                                    subtitle: const Text(
                                      "WORT NICHT BEHANDELT",
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
                                          color: Colors.grey),
                                    ),
                                    leading: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/Wörter/${ProgresMap.entries.toList()[index].key}.jpg'),
                                        radius: 40),
                                    // trailing: Icon(Icons.star)
                                  )) */
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: Ink(
                              width: 50,
                              height: 50,
                              decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: CircleBorder(
                                      side: BorderSide(
                                          width: 3,
                                          color: Colors.black)
                                  )
                              ),
                              child: IconButton(
                                  icon: const Icon(
                                    Icons.autorenew,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    //  DBHelper.insert('SCORE', {
                                    //    'date': context.read<SettingsController>().playerName.value,
                                    //   'score': score
                                    //  });
                                    //getCategoryFromNumber();
                                    //print("Kategorie"+category);
                                    Navigator.pushNamed(context, Routes.home);
                                  })
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: Ink(
                              width: 50,
                              height: 50,
                              decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: CircleBorder(
                                      side: BorderSide(
                                          width: 3,
                                          color: Colors.black)
                                  )
                              ),
                              child: IconButton(
                                  icon: const Icon(
                                    Icons.home,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    //   DBHelper.insert('SCORE', {
                                    //    'date': context.read<SettingsController>().playerName.value,
                                    //    'score': score
                                    //  });
                                    //   progressSafer.update(stored, (value) => [1,0]);    //für korrektes Wort
                                    //   checkForHelp();                                    //check wie viele Hilfen benötigt
                                    Navigator.pushNamed(context, Routes.home);
                                  })
                          ),
                        ),
                      ],
                    ),
                  ]);
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
            )));
  }




}
