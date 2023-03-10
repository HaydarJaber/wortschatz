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
  final List getProgress;

  const ProgressCategory({Key? key, required this.getProgress}) : super(key: key);

  @override
  _ProgressCategoryState createState() => _ProgressCategoryState();
}

Map<String, List<dynamic>> itemsMAP = {
  //"Alle Kategorien":[Category.All,0xf144,0],
  "Autoteile":[Category.Autoteile,0xf1b9,0],
  "Badezimmer":[Category.Badezimmer,0xf2cd,0],
  "Bauernhof":[Category.Bauernhof,0xe2cd,0],
  "Berufe":[Category.Berufe,0xf85e,0],
  "Deutsche Städte":[Category.DeutscheStaedte,0xf64f,0],
  "Fahrzeuge":[Category.Fahrzeuge,0xf21c,0],
  "Garten":[Category.Garten,0xf1bb,0],
  "Gemüse":[Category.Gemuese,0xf787,0],
  "Getränke":[Category.Getraenke,0xf000,0],
  "Hauptstädte":[Category.Hauptstaedte,0xf64f,0],
  "Hausbau":[Category.Hausbau,0xf015,0],
  "Hobbys":[Category.Hobbys,0xf554,0],
  "Kleidung":[Category.Kleidung,0xf553,0],
  "Körperteile":[Category.Koerperteile,0xf06e,0],
  "Küche":[Category.Kueche,0xe51a,0],
  "Länder":[Category.Laender,0xf024,0],
  "Möbel":[Category.Moebel,0xf4b8,0],
  "Musikinstrumente":[Category.Musikinstrumente,0xf001,0],
  "Obst":[Category.Obst,0xf5d1,0],
  "Pflanzen":[Category.Pflanzen,0xe5aa,0],
  "Resteraunt":[Category.Resteraunt,0xf2e7,0],
  "Sportarten":[Category.Sportarten,0xf1e3,0],
  "Strassenverkehr":[Category.Strassenverkehr,0xf018,0],
  "Supermarkt":[Category.Supermarkt,0xf54f,0],
  "Tiere":[Category.Tiere,0xf6f0,0],
  "Werkzeuge":[Category.Werkzeuge,0xf7d9,0],
};


class _ProgressCategoryState extends State<ProgressCategory> {

  final controller = PageController();
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool? newValue = false;
  bool showErrorMessage = false;
  static const _gap = SizedBox(width: 20);


  @override
  Widget build(BuildContext context) {
    List DiffFrequencyLIST = ModalRoute.of(context)?.settings.arguments as List;
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
                        itemCount: itemsMAP.entries.toList().length-1,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  color: Colors.black,
                                  child: Card(
                                      color: Colors.white70,
                                      child: ListTile(
                                        onTap: () {
                                          List progressData = [DiffFrequencyLIST[0],DiffFrequencyLIST[1],itemsMAP.entries.toList()[index].value[0]];
                                          Navigator.pushNamed(context, Routes.progressEINZEL, arguments: progressData);
                                        },
                                        title: Text(
                                          itemsMAP.entries.toList()[index].key,
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
                                        leading: Icon(
                                            shadows: const <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 5.0,
                                                color: Colors.black,
                                              ),
                                            ],
                                            size: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.03,
                                            color: Colors.white,
                                            IconData(itemsMAP.entries.toList()[index].value[1], fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter')
                                        ),
                                         trailing: Icon(
                                             shadows: const <Shadow>[
                                               Shadow(
                                                 offset: Offset(0.0, 0.0),
                                                 blurRadius: 5.0,
                                                 color: Colors.black,
                                               ),
                                             ],
                                             size: MediaQuery
                                                 .of(context)
                                                 .size
                                                 .height * 0.03,
                                             //nicht vollständig
                                              color: Colors.grey,
                                             IconData(0xf110, fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter')
                                             //vollständig
                                             //color: Colors.yellow,
                                             //IconData(0xf091, fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter')
                                         ),
                                      )))
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
