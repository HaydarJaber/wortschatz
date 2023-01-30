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
import '../model/styles/responsive_screen.dart';
import 'package:wortschatz/viewmodels/settings/settings.dart';
import 'package:wortschatz/model/styles/palette.dart';
import '../viewmodels/player_progress/player_progress.dart';

class Infopage extends StatefulWidget {
  final Map getProgress;

  const Infopage({Key? key, required this.getProgress}) : super(key: key);

  @override
  _InfopageState createState() => _InfopageState();
}

class _InfopageState extends State<Infopage> {
  final controller = PageController();
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool? newValue = false;
  bool showErrorMessage = false;
  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final palette = context.watch<Palette>();
    late MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    Map ProgresMap = ModalRoute.of(context)?.settings.arguments as Map;
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
                      Icons.home,
                      color: Colors.black,
                      size: 35,
                    )),
                const SizedBox(width: 50),
                const Text(
                  'Spielübersicht',
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Richtig',
                  style: TextStyle(shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 1.0,
                      color: Colors.black,
                    ),
                  ], fontFamily: "Qaz", fontSize: 35, color: Colors.green),
                ),
                SizedBox(width: 80),
                Text(
                  'Falsch',
                  style: TextStyle(shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 1.0,
                      color: Colors.black,
                    ),
                  ], fontFamily: "Qaz", fontSize: 35, color: Colors.red),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: ProgresMap.entries.toList().length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (ProgresMap.entries.toList()[index].value[0].toString() == "1")
                          ? Card(
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
                                    color: Colors.green),
                              ),
                              subtitle: Text(
                                "Hilfen: " +
                                    ProgresMap.entries
                                        .toList()[index]
                                        .value[1]
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
                                    fontSize: 30,
                                    color: Colors.black),
                              ),
                              leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/Wörter/${ProgresMap.entries.toList()[index].key}.jpg'),
                                  radius: 40),
                              // trailing: Icon(Icons.star)
                            ))
                          : (ProgresMap.entries.toList()[index].value[0].toString() == "0") ?
                           Card(
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
                                    color: Colors.red),
                              ),
                              subtitle: Text(
                                "Hilfen: " +
                                    ProgresMap.entries
                                        .toList()[index]
                                        .value[1]
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
                                    fontSize: 30,
                                    color: Colors.black),
                              ),
                              leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/Wörter/${ProgresMap.entries.toList()[index].key}.jpg'),
                                  radius: 40),
                              // trailing: Icon(Icons.star)
                            )):
                           Card(
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
                          ))
                    ],
                  ),
                ),
              ),
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
