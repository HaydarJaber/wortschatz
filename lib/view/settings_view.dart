import 'package:flutter/material.dart';
import 'package:wortschatz/viewmodels/widgets/menuButton.dart';
import 'package:wortschatz/model/constants/routes.dart';
import 'package:wortschatz/model/constants/categories.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Center(
          child: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Kategorien', style: TextStyle(fontSize: 60)),
                  Column(children: const [
                    MenuButton(
                        label: Category.All,
                        route: Routes.newGame,
                        iconCodePoint: 0xf2af,
                        color: Colors.blue),
                    MenuButton(
                        label: Category.Autoteile,
                        route: Routes.newGame,
                        iconCodePoint: 0xf2af,
                        color: Colors.green),
                    MenuButton(
                        label: Category.Food,
                        route: Routes.newGame,
                        iconCodePoint: 0xf2af,
                        color: Colors.yellow),
                    MenuButton(
                        label: Category.Cinema,
                        route: Routes.newGame,
                        iconCodePoint: 0xf2af,
                        color: Colors.orange),
                    MenuButton(
                        label: Category.Sport,
                        route: Routes.newGame,
                        iconCodePoint: 0xf2af,
                        color: Colors.red),
                    MenuButton(
                        label: Category.Music,
                        route: Routes.newGame,
                        iconCodePoint: 0xf2af,
                        color: Colors.pink),
                    MenuButton(
                        label: Category.Animals,
                        route: Routes.newGame,
                        iconCodePoint: 0xf2af,
                        color: Colors.purple),
                  ]),
                  /*  IconButton(
                  iconSize: 35,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }), */
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
                                    label: Category.Food,
                                    route: Routes.newGame,
                                    iconCodePoint: 0xf2af,
                                    color: Colors.yellow),
                                MenuButton(
                                    label: Category.Cinema,
                                    route: Routes.newGame,
                                    iconCodePoint: 0xf2af,
                                    color: Colors.orange),
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                MenuButton(
                                    label: Category.Sport,
                                    route: Routes.newGame,
                                    iconCodePoint: 0xf2af,
                                    color: Colors.red),
                                MenuButton(
                                    label: Category.Music,
                                    route: Routes.newGame,
                                    iconCodePoint: 0xf2af,
                                    color: Colors.pink),
                                MenuButton(
                                    label: Category.Animals,
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
        ));
  }
}
