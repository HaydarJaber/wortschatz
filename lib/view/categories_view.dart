import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortschatz/model/styles/palette.dart';
import 'package:wortschatz/view/settings_view.dart';
import 'package:wortschatz/viewmodels/widgets/menuButton.dart';
import 'package:wortschatz/model/constants/routes.dart';
import 'package:wortschatz/model/constants/categories.dart';
import 'package:wortschatz/model/styles/palette.dart';

import '../viewmodels/settings/settings.dart';


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



class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pushNamed(context, Routes.home),
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
                      const SizedBox(width: 60),
                      const Text(
                        'Kategorien',
                        style: TextStyle(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 2.0,
                                color: Colors.black,
                              ),
                            ],
                            fontFamily: "Qaz",
                            fontSize: 35,
                            color: Colors.black),
                      )
                    ],
                  ),
                  //const Text('Kategorien', style: TextStyle(fontSize: 60,fontFamily: "Modak")
                  /*Expanded(
                  child:
                      ListView.builder(
                          itemCount: items.length,
                        itemBuilder: (context,index) {
                            return items[index];
                        },

                  ))*/
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
                                  color: Colors.lightBlueAccent,
                                    child: ListTile(
                                      onTap: () {Navigator.pushNamed(context, Routes.newGame, arguments: itemsMAP.entries.toList()[index].value[0] );
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
                                      // trailing: Icon(Icons.star)
                                    )))
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              );
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
                        const MenuButton(
                            label: Category.All,
                            route: Routes.newGame,
                            iconCodePoint: 0xf2af,
                            color: Colors.lightBlueAccent),
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                MenuButton(
                                    label: Category.Autoteile,
                                    route: Routes.newGame,
                                    iconCodePoint: 0xf2af,
                                    color: Colors.green),
                                MenuButton(
                                    label: Category.Badezimmer,
                                    route: Routes.newGame,
                                    iconCodePoint: 0xf2af,
                                    color: Colors.yellow),
                                MenuButton(
                                    label: Category.Bauernhof,
                                    route: Routes.newGame,
                                    iconCodePoint: 0xf2af,
                                    color: Colors.orange),
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                MenuButton(
                                    label: Category.Berufe,
                                    route: Routes.newGame,
                                    iconCodePoint: 0xf2af,
                                    color: Colors.red),
                                MenuButton(
                                    label: Category.DeutscheStaedte,
                                    route: Routes.newGame,
                                    iconCodePoint: 0xf2af,
                                    color: Colors.pink),
                                MenuButton(
                                    label: Category.Fahrzeuge,
                                    route: Routes.newGame,
                                    iconCodePoint: 0xf2af,
                                    color: Colors.purple),
                              ]),
                        ]),
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

