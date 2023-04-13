// Frequenz der Wörter (DONE)
///TODO: mit oder ohne Hilfe

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
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
  static const _gap = SizedBox(width: 20);


  @override
  Widget build(BuildContext context) {

    final settings = context.watch<SettingsController>();
    final palette = context.watch<Palette>();
    late MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    Map ProgresMap = ModalRoute.of(context)?.settings.arguments as Map;
    late int richtig = ProgresMap.entries.where((e) => e.value[0] == 1).toList().length;
    late int falsch = ProgresMap.entries.where((e) => e.value[0] == 0).toList().length;
    late int offen = ProgresMap.entries.where((e) => e.value[0] == 2).toList().length;
    if(ProgresMap.entries.last.value.toString() == "[0]") {
      if(falsch != 0){  //da wegen Kategorie: 2,1 und 0  in der map die 0 von der Kategorie fälschlerwweise mitgezählt wird als wort richtig/falsch/offen
        falsch = falsch -1;
      }
    }
    if(ProgresMap.entries.last.value.toString() == "[1]") {
      if(richtig != 0){  //da wegen Kategorie: 2,1 und 0  in der map die zwei fälschlerwweise mitgezählt wird
        richtig = richtig -1;
      }
    }
    if(ProgresMap.entries.last.value.toString() == "[2]") {
      if(offen != 0){  //da wegen Kategorie: 2,1 und 0  in der map die zwei fälschlerwweise mitgezählt wird
        offen = offen -1;
      }
    }
    var category = "";
    void getCategoryFromNumber() {
      ProgresMap.entries.last.value;
      print(ProgresMap);
      switch(ProgresMap.entries.last.value.toString()) {
        case "[0]":
          category = "Alle Kategorien";
          break;
        case "[1]":
          category = "Autoteile";
          break;
        case "[2]":
          category = "Badezimmer";
          break;
        case "[3]":
          category = "Bauernhof";
          break;
        case "[4]":
          category = "Berufe";
          break;
        case "[5]":
          category = "Deutsche Städte";
          break;
        case "[6]":
          category = "Fahrzeuge";
          break;
        case "[7]":
          category = "Garten";
          break;
        case "[8]":
          category = "Gemüse";
          break;
        case "[9]":
          category = "Getränke";
          break;
        case "[10]":
          category = "Hauptstädte";
          break;
        case "[11]":
          category = "Hausbau";
          break;
        case "[12]":
          category = "Hobbys";
          break;
        case "[13]":
          category = "Kleidung";
          break;
        case "[14]":
          category = "Körperteile";
          break;
        case "[15]":
          category = "Küche";
          break;
        case "[16]":
          category = "Länder";
          break;
        case "[17]":
          category = "Möbel";
          break;
        case "[18]":
          category = "Musikinstrumente";
          break;
        case "[19]":
          category = "Obst";
          break;
        case "[20]":
          category = "Pflanzen";
          break;
        case "[21]":
          category = "Restaurant";
          break;
        case "[22]":
          category = "Sportarten";
          break;
        case "[23]":
          category = "Straßenverkehr";
          break;
        case "[24]":
          category = "Supermarkt";
          break;
        case "[25]":
          category = "Tiere";
          break;
        case "[26]":
          category = "Werkzeuge";
          break;
    }}
    var mySizeGRP_V1 = AutoSizeGroup();
    var mySizeGRP_V2 = AutoSizeGroup();
    var mySizeGRP_V3 = AutoSizeGroup();

    return SafeArea(
        child: Scaffold(
            body: Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/Hintergrund.jpg"),
            fit: BoxFit.cover),
      ),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    iconSize: MediaQuery.of(context).size.width*0.1,
                    onPressed: () => Navigator.pushNamed(context, Routes.home),
                    icon: const Icon(
                      shadows: <Shadow>[
                      ],
                      Icons.home,
                      color: Colors.black,
                    )),
                SizedBox(width: MediaQuery.of(context).size.width*0.02),
                Text('Spielübersicht',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1, shadows: const <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 1.0,
                    color: Colors.black,
                  ),
                ]), maxLines: 1, overflow: TextOverflow.ellipsis)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                Flexible(child:
                AutoSizeText('Richtig', group: mySizeGRP_V1,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    color: Colors.black,
                  ),
                ],fontFamily: "Qaz",color: Colors.green),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                   SizedBox(width: MediaQuery.of(context).size.width*0.1),
                   Flexible(child:
                  AutoSizeText('Falsch', group: mySizeGRP_V1,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    color: Colors.black,
                  ),
                ],fontFamily: "Qaz",color: Colors.redAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                SizedBox(width: MediaQuery.of(context).size.width*0.1),
                Flexible(child:
                AutoSizeText('Offen', group: mySizeGRP_V1,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    color: Colors.black,
                  ),
                ],fontFamily: "Qaz",color: Colors.grey),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
              ],
            ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    Flexible(child:
                    AutoSizeText(richtig.toString(), group: mySizeGRP_V1,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        color: Colors.black,
                      ),
                    ],fontFamily: "Qaz",color: Colors.green),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    SizedBox(width: MediaQuery.of(context).size.width*0.1),
                    Flexible(child:
                    AutoSizeText(falsch.toString(), group: mySizeGRP_V1,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        color: Colors.black,
                      ),
                    ],fontFamily: "Qaz",color: Colors.redAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    SizedBox(width: MediaQuery.of(context).size.width*0.1),
                    Flexible(child:
                    AutoSizeText(offen.toString(), group: mySizeGRP_V1,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        color: Colors.black,
                      ),
                    ],fontFamily: "Qaz",color: Colors.grey),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                  ],
                ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: ProgresMap.entries.toList().length-1,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (ProgresMap.entries.toList()[index].value[0].toString() == "1")
                          ?
                      Container(
                        color: Colors.green[600],
                        child: Card(
                              child: ListTile(
                              title:
                              Text(ProgresMap.entries.toList()[index].key, style:  TextStyle(fontSize: MediaQuery.of(context).size.height*0.05, shadows: const <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  color: Colors.black,
                                ),
                              ],fontFamily: "Qaz",color: Colors.green),maxLines: 1, overflow: TextOverflow.ellipsis),
                              subtitle:
                              Text("Hilfen: ${ProgresMap.entries
                                  .toList()[index]
                                  .value[1]}", style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.032, shadows: const <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  color: Colors.black,
                                ),
                              ],fontFamily: "Qaz",color: Colors.black), maxLines: 1, overflow: TextOverflow.ellipsis),
                              leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/Wörter/${ProgresMap.entries.toList()[index].key}.jpg'),
                                  radius: 30),
                              // trailing: Icon(Icons.star)
                            )))
                          : (ProgresMap.entries.toList()[index].value[0].toString() == "0") ?
                      Container(
                                  color: Colors.red[600],
                                  child: Card(
                                      child: ListTile(
                                    title:
                                    Text(ProgresMap.entries.toList()[index].key, style:  TextStyle(fontSize: MediaQuery.of(context).size.height*0.05, shadows: const <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        color: Colors.black,
                                      ),
                                    ],fontFamily: "Qaz",color: Colors.redAccent),maxLines: 1, overflow: TextOverflow.ellipsis),
                                    subtitle: Text("Hilfen: ${ProgresMap.entries
                                        .toList()[index]
                                        .value[1]}", style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.032, shadows: const <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        color: Colors.black,
                                      ),
                                    ],fontFamily: "Qaz",color: Colors.black), maxLines: 1, overflow: TextOverflow.ellipsis),
                                    leading: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/Wörter/${ProgresMap.entries.toList()[index].key}.jpg'),
                                        radius: 30),
                                    // trailing: Icon(Icons.star)
                                  )))
                              : Card(
                          child: ListTile(
                            title:
                            Text(ProgresMap.entries.toList()[index].key, style:  TextStyle(fontSize: MediaQuery.of(context).size.height*0.05, shadows: const <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                color: Colors.black,
                              ),
                            ],fontFamily: "Qaz",color: Colors.grey),maxLines: 1, overflow: TextOverflow.ellipsis),
                            subtitle: Text("WORT NICHT BEHANDELT", style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.032, shadows: const <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                color: Colors.black,
                              ),
                            ],fontFamily: "Qaz",color: Colors.black), maxLines: 1, overflow: TextOverflow.ellipsis),
                            leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/Wörter/${ProgresMap.entries.toList()[index].key}.jpg'),
                                radius: 30),
                            // trailing: Icon(Icons.star)
                          ))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Ink(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.10,
                      decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(
                              side: BorderSide(
                                  width: 3,
                                  color: Colors.black)
                          )
                      ),
                      child: IconButton(
                          icon: Icon(
                            Icons.autorenew,
                            size: MediaQuery.of(context).size.width * 0.07,
                            color: Colors.black,
                          ),
                          onPressed: () {
                          //  DBHelper.insert('SCORE', {
                          //    'date': context.read<SettingsController>().playerName.value,
                           //   'score': score
                          //  });
                            getCategoryFromNumber();
                            print("Kategorie"+category);
                            Navigator.pushNamed(context, Routes.newGame,arguments: category);
                          })
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: Ink(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.10,
                      decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(
                              side: BorderSide(
                                  width: 3,
                                  color: Colors.black)
                          )
                      ),
                      child: IconButton(
                          icon: Icon(
                            Icons.home,
                            size: MediaQuery.of(context).size.width * 0.07,
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
          return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        iconSize: MediaQuery.of(context).size.width*0.05,
                        onPressed: () => Navigator.pushNamed(context, Routes.home),
                        icon: const Icon(
                          shadows: <Shadow>[
                          ],
                          Icons.home,
                          color: Colors.black,
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width*0.02),
                    Text('Spielübersicht',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, shadows: const <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 1.0,
                        color: Colors.black,
                      ),
                    ]), maxLines: 1, overflow: TextOverflow.ellipsis)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    SizedBox(width: MediaQuery.of(context).size.width*0.02),
                    Flexible(child:
                    AutoSizeText('Richtig', group: mySizeGRP_V1,style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        color: Colors.black,
                      ),
                    ],fontFamily: "Qaz",color: Colors.green),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    SizedBox(width: MediaQuery.of(context).size.width*0.3),
                    Flexible(child:
                    AutoSizeText('Falsch', group: mySizeGRP_V1,style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        color: Colors.black,
                      ),
                    ],fontFamily: "Qaz",color: Colors.redAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    SizedBox(width: MediaQuery.of(context).size.width*0.3),
                    Flexible(child:
                    AutoSizeText('Offen', group: mySizeGRP_V1,style: const TextStyle(fontSize: 50, shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        color: Colors.black,
                      ),
                    ],fontFamily: "Qaz",color: Colors.grey),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                    ,SizedBox(width: MediaQuery.of(context).size.width*0.02),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    Flexible(child:
                    AutoSizeText(richtig.toString(), group: mySizeGRP_V1,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        color: Colors.black,
                      ),
                    ],fontFamily: "Qaz",color: Colors.green),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    SizedBox(width: MediaQuery.of(context).size.width*0.1),
                    Flexible(child:
                    AutoSizeText(falsch.toString(), group: mySizeGRP_V1,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        color: Colors.black,
                      ),
                    ],fontFamily: "Qaz",color: Colors.redAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    SizedBox(width: MediaQuery.of(context).size.width*0.1),
                    Flexible(child:
                    AutoSizeText(offen.toString(), group: mySizeGRP_V1,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        color: Colors.black,
                      ),
                    ],fontFamily: "Qaz",color: Colors.grey),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ProgresMap.entries.toList().length-1,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (ProgresMap.entries.toList()[index].value[0].toString() == "1")
                              ?
                          Container(
                              color: Colors.green[600],
                              child: Card(
                                  child: ListTile(
                                    title:
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(child:
                                        AutoSizeText(ProgresMap.entries.toList()[index].key,group: mySizeGRP_V2,style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            color: Colors.green,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.green),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                        SizedBox(width: MediaQuery.of(context).size.width*0.05),
                                        Flexible(child:
                                        AutoSizeText("Hilfen: ${ProgresMap.entries
                                            .toList()[index]
                                            .value[1]}",group: mySizeGRP_V3,style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                      ],
                                    ),
                                    leading: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/Wörter/${ProgresMap.entries.toList()[index].key}.jpg'),
                                        radius: 30),
                                    // trailing: Icon(Icons.star)
                                  )))
                              : (ProgresMap.entries.toList()[index].value[0].toString() == "0") ?
                          Container(
                              color: Colors.red[600],
                              child: Card(
                                  child: ListTile(
                                    title:
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(child:
                                        AutoSizeText(ProgresMap.entries.toList()[index].key,group: mySizeGRP_V2,style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            color: Colors.red,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.red),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                        SizedBox(width: MediaQuery.of(context).size.width*0.05),
                                        Flexible(child:
                                        AutoSizeText("Hilfen: ${ProgresMap.entries
                                            .toList()[index]
                                            .value[1]}",group: mySizeGRP_V3,style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            color: Colors.black,
                                          ),
                                        ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                      ],
                                    ),
                                    leading: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/Wörter/${ProgresMap.entries.toList()[index].key}.jpg'),
                                        radius: 30),
                                    // trailing: Icon(Icons.star)
                                  )))
                              : Card(
                              child: ListTile(
                                title:
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(child:
                                    AutoSizeText(ProgresMap.entries.toList()[index].key,group: mySizeGRP_V2,style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        color: Colors.grey,
                                      ),
                                    ],fontFamily: "Qaz",color: Colors.grey),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                    SizedBox(width: MediaQuery.of(context).size.width*0.05),
                                    Flexible(child:
                                    AutoSizeText("OFFEN",group: mySizeGRP_V3,style: const TextStyle(fontSize: 40, shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        color: Colors.black,
                                      ),
                                    ],fontFamily: "Qaz",color: Colors.grey),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                  ],
                                ),
                                leading: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/Wörter/${ProgresMap.entries.toList()[index].key}.jpg'),
                                    radius: 30),
                                // trailing: Icon(Icons.star)
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Ink(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(
                                  side: BorderSide(
                                      width: 3,
                                      color: Colors.black)
                              )
                          ),
                          child: IconButton(
                              icon: Icon(
                                Icons.autorenew,
                                size: MediaQuery.of(context).size.width * 0.035,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                //  DBHelper.insert('SCORE', {
                                //    'date': context.read<SettingsController>().playerName.value,
                                //   'score': score
                                //  });
                                getCategoryFromNumber();
                                print("Kategorie"+category);
                                Navigator.pushNamed(context, Routes.newGame,arguments: category);
                              })
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Ink(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(
                                  side: BorderSide(
                                      width: 3,
                                      color: Colors.black)
                              )
                          ),
                          child: IconButton(
                              icon: Icon(
                                Icons.home,
                                size: MediaQuery.of(context).size.width * 0.035,
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
        }
      }),
    )));
  }




}
