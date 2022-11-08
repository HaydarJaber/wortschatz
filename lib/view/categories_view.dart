import 'package:flutter/material.dart';
import 'package:wortschatz/model/styles/palette.dart';
import 'package:wortschatz/viewmodels/widgets/CategoryButton.dart';
import 'package:wortschatz/viewmodels/widgets/menuButton.dart';
import 'package:wortschatz/model/constants/routes.dart';
import 'package:wortschatz/model/constants/categories.dart';
import 'package:wortschatz/model/styles/palette.dart';



List<Widget> items = [
  const CategoryButton(
      label: Category.All,
      route: Routes.newGame,
      iconCodePoint: 0xf144,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Autoteile,
      route: Routes.newGame,
      iconCodePoint: 0xf1b9,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Badezimmer,
      route: Routes.newGame,
      iconCodePoint: 0xf2cd,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Bauernhof,
      route: Routes.newGame,
      iconCodePoint: 0xe2cd,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Berufe,
      route: Routes.newGame,
      iconCodePoint: 0xf85e,
      color: Colors.blue),
  const CategoryButton(
      label: Category.DeutscheStaedte,
      route: Routes.newGame,
      iconCodePoint: 0xf64f,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Fahrzeuge,
      route: Routes.newGame,
      iconCodePoint: 0xf21c,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Garten,
      route: Routes.newGame,
      iconCodePoint: 0xf1bb,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Gemuese,
      route: Routes.newGame,
      iconCodePoint: 0xf787,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Getraenke,
      route: Routes.newGame,
      iconCodePoint: 0xf000,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Hauptstaedte,
      route: Routes.newGame,
      iconCodePoint: 0xf64f,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Hausbau,
      route: Routes.newGame,
      iconCodePoint: 0xf015,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Hobbys,
      route: Routes.newGame,
      iconCodePoint: 0xf554,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Kleidung,
      route: Routes.newGame,
      iconCodePoint: 0xf553,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Koerperteile,
      route: Routes.newGame,
      iconCodePoint: 0xf06e,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Kueche,
      route: Routes.newGame,
      iconCodePoint: 0xe51a,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Laender,
      route: Routes.newGame,
      iconCodePoint: 0xf024,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Moebel,
      route: Routes.newGame,
      iconCodePoint: 0xf4b8,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Musikinstrumente,
      route: Routes.newGame,
      iconCodePoint: 0xf001,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Obst,
      route: Routes.newGame,
      iconCodePoint: 0xf5d1,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Pflanzen,
      route: Routes.newGame,
      iconCodePoint: 0xe5aa,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Resteraunt,
      route: Routes.newGame,
      iconCodePoint: 0xf2e7,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Sportarten,
      route: Routes.newGame,
      iconCodePoint: 0xf1e3,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Strassenverkehr,
      route: Routes.newGame,
      iconCodePoint: 0xf018,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Supermarkt,
      route: Routes.newGame,
      iconCodePoint: 0xf54f,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Tiere,
      route: Routes.newGame,
      iconCodePoint: 0xf6f0,
      color: Colors.blue),
  const CategoryButton(
      label: Category.Werkzeuge,
      route: Routes.newGame,
      iconCodePoint: 0xf7d9,
      color: Colors.blue),
];

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.home,
                            color: Colors.blueGrey,
                            size: 30,
                          )),
                      const Text(
                        '      Kategorien',
                        style: TextStyle(
                            fontFamily: "Modak",
                            fontSize: 35,
                            color: Colors.blueGrey),
                      )
                    ],
                  ),
                  //const Text('Kategorien', style: TextStyle(fontSize: 60,fontFamily: "Modak")
                  Expanded(
                  child:
                      ListView.builder(
                          itemCount: items.length,
                        itemBuilder: (context,index) {
                            return items[index];
                        },

                  ))
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
                            color: Colors.blue),
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

