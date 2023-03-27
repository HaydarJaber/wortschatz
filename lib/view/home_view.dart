import 'package:auto_size_text/auto_size_text.dart';
import 'package:wortschatz/viewmodels/widgets/menuButton.dart';
import 'package:flutter/material.dart';
import 'package:wortschatz/model/constants/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mySizeGRP_V = AutoSizeGroup();
    var mySizeGRP_H = AutoSizeGroup();
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
                      height: MediaQuery.of(context).size.height*0.2,
                      child: Image.asset("assets/images/Homescreen_BIG.png"),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.10,
                        alignment: Alignment.center,
                            child: ElevatedButton.icon(
            style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(double.infinity,double.infinity)),
            alignment: Alignment.centerLeft,
            backgroundColor: MaterialStateProperty.resolveWith((state) {
            if (state.contains(MaterialState.pressed)) return Colors.grey;
            return Colors.lightBlueAccent;
            }),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            side: MaterialStateProperty.all(const BorderSide(width: 2))),
            onPressed: () =>
            Navigator.pushNamed(context, Routes.categories, arguments: "Start"),
            icon: Icon(
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
                .height * 0.08,
            color: Colors.white,
            const IconData(0xf2af, fontFamily: 'MaterialIcons')),
            label: AutoSizeText('Start', group: mySizeGRP_V,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                color: Colors.black,
              ),
            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
            )
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                            child: ElevatedButton.icon(
            style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(double.infinity,double.infinity)),
            alignment: Alignment.centerLeft,
            backgroundColor: MaterialStateProperty.resolveWith((state) {
            if (state.contains(MaterialState.pressed)) return Colors.grey;
            return Colors.lightBlueAccent;
            }),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            side: MaterialStateProperty.all(const BorderSide(width: 2))),
            onPressed: () =>
            Navigator.pushNamed(context, Routes.rank, arguments: "Rangliste"),
            icon: Icon(
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
                .height * 0.08,
            color: Colors.white,
            const IconData(0xf05ae, fontFamily: 'MaterialIcons')),
            label: AutoSizeText('Rangliste', group: mySizeGRP_V,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                color: Colors.black,
              ),
            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
            )
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.10,
                        alignment: Alignment.center,
                        child:
                          ElevatedButton.icon(
            style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(double.infinity,double.infinity)),
            alignment: Alignment.centerLeft,
            backgroundColor: MaterialStateProperty.resolveWith((state) {
            if (state.contains(MaterialState.pressed)) return Colors.grey;
            return Colors.lightBlueAccent;
            }),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            side: MaterialStateProperty.all(const BorderSide(width: 2))),
            onPressed: () =>
            Navigator.pushNamed(context, Routes.progress, arguments: "Fortschritt"),
            icon: Icon(
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
                .height * 0.08,
            color: Colors.white,
            const IconData(0xe7ca, fontFamily: 'MaterialIcons')),
            label: AutoSizeText('Fortschritt', group: mySizeGRP_V,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                color: Colors.black,
              ),
            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
            )
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                          child: ElevatedButton.icon(
            style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(double.infinity,double.infinity)),
            alignment: Alignment.centerLeft,
            backgroundColor: MaterialStateProperty.resolveWith((state) {
            if (state.contains(MaterialState.pressed)) return Colors.grey;
            return Colors.lightBlueAccent;
            }),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            side: MaterialStateProperty.all(const BorderSide(width: 2))),
            onPressed: () =>
            Navigator.pushNamed(context, Routes.manual, arguments: "Anleitung"),
            icon: Icon(
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
                .height * 0.08,
            color: Colors.white,
            const IconData(0xe309, fontFamily: 'MaterialIcons')),
            label: AutoSizeText('Anleitung', group: mySizeGRP_V,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                color: Colors.black,
              ),
            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
            )
                    ),
                    Container(
                          width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                          child: ElevatedButton.icon(
            style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(double.infinity,double.infinity)),
            alignment: Alignment.centerLeft,
            backgroundColor: MaterialStateProperty.resolveWith((state) {
            if (state.contains(MaterialState.pressed)) return Colors.grey;
            return Colors.lightBlueAccent;
            }),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            side: MaterialStateProperty.all(const BorderSide(width: 2))),
            onPressed: () =>
            Navigator.pushNamed(context, Routes.settings, arguments: "Einstellungen"),
            icon: Icon(
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
                .height * 0.08,
            color: Colors.white,
            const IconData(0xe57f, fontFamily: 'MaterialIcons')),
            label: AutoSizeText('Einstellungen', group: mySizeGRP_V,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
            Shadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            color: Colors.black,
            ),
            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
            )
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.10,
                          alignment: Alignment.center,
                        child: ElevatedButton.icon(
            style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(double.infinity,double.infinity)),
            alignment: Alignment.centerLeft,
            backgroundColor: MaterialStateProperty.resolveWith((state) {
            if (state.contains(MaterialState.pressed)) return Colors.grey;
            return Colors.lightBlueAccent;
            }),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            side: MaterialStateProperty.all(const BorderSide(width: 2))),
            onPressed: () =>
            Navigator.pushNamed(context, Routes.imprint, arguments: "Impressum"),
            icon: Icon(
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
                .height * 0.08,
            color: Colors.white,
            const IconData(0xe33c, fontFamily: 'MaterialIcons')),
            label: AutoSizeText('Impressum', group: mySizeGRP_V,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                color: Colors.black,
              ),
            ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
            )
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
                            width: MediaQuery.of(context).size.width*0.9,
                            height: MediaQuery.of(context).size.height*0.3,
                            child: Image.asset("assets/images/Homescreen_BIG.png"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height*0.15,
                              alignment: Alignment.center,
                              child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(const Size(double.infinity,double.infinity)),
                                    alignment: Alignment.centerLeft,
                                    backgroundColor: MaterialStateProperty.resolveWith((state) {
                                      if (state.contains(MaterialState.pressed)) return Colors.grey;
                                      return Colors.lightBlueAccent;
                                    }),
                                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                                    side: MaterialStateProperty.all(const BorderSide(width: 2))),
                                onPressed: () =>
                                    Navigator.pushNamed(context, Routes.categories, arguments: "Start"),
                                icon: Icon(
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
                                        .height * 0.1,
                                    color: Colors.white,
                                    const IconData(0xf2af, fontFamily: 'MaterialIcons')),
                                label: AutoSizeText('Start', group: mySizeGRP_H,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width*0.4,
                                height: MediaQuery.of(context).size.height*0.15,
                                alignment: Alignment.center,
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(const Size(double.infinity,double.infinity)),
                                      alignment: Alignment.centerLeft,
                                      backgroundColor: MaterialStateProperty.resolveWith((state) {
                                        if (state.contains(MaterialState.pressed)) return Colors.grey;
                                        return Colors.lightBlueAccent;
                                      }),
                                      shadowColor: MaterialStateProperty.all(Colors.transparent),
                                      side: MaterialStateProperty.all(const BorderSide(width: 2))),
                                  onPressed: () =>
                                      Navigator.pushNamed(context, Routes.rank, arguments: "Rangliste"),
                                  icon: Icon(
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
                                          .height * 0.10,
                                      color: Colors.white,
                                      const IconData(0xf05ae, fontFamily: 'MaterialIcons')),
                                  label: AutoSizeText('Rangliste', group: mySizeGRP_H,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      color: Colors.black,
                                    ),
                                  ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                                )
                            ),
                          ],),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height*0.15,
                              alignment: Alignment.center,
                              child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(const Size(double.infinity,double.infinity)),
                                    alignment: Alignment.centerLeft,
                                    backgroundColor: MaterialStateProperty.resolveWith((state) {
                                      if (state.contains(MaterialState.pressed)) return Colors.grey;
                                      return Colors.lightBlueAccent;
                                    }),
                                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                                    side: MaterialStateProperty.all(const BorderSide(width: 2))),
                                onPressed: () =>
                                    Navigator.pushNamed(context, Routes.progress, arguments: "Fortschritt"),
                                icon: Icon(
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
                                        .height * 0.1,
                                    color: Colors.white,
                                    const IconData(0xe7ca, fontFamily: 'MaterialIcons')),
                                label: AutoSizeText('Fortschritt', group: mySizeGRP_H,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                              )
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.height*0.15,
                                alignment: Alignment.center,
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(const Size(double.infinity,double.infinity)),
                                      alignment: Alignment.centerLeft,
                                      backgroundColor: MaterialStateProperty.resolveWith((state) {
                                        if (state.contains(MaterialState.pressed)) return Colors.grey;
                                        return Colors.lightBlueAccent;
                                      }),
                                      shadowColor: MaterialStateProperty.all(Colors.transparent),
                                      side: MaterialStateProperty.all(const BorderSide(width: 2))),
                                  onPressed: () =>
                                      Navigator.pushNamed(context, Routes.manual, arguments: "Anleitung"),
                                  icon: Icon(
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
                                          .height * 0.1,
                                      color: Colors.white,
                                      const IconData(0xe309, fontFamily: 'MaterialIcons')),
                                  label: AutoSizeText('Anleitung', group: mySizeGRP_H,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      color: Colors.black,
                                    ),
                                  ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                                )
                            ),
                          ],),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height*0.15,
                              alignment: Alignment.center,
                              child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(const Size(double.infinity,double.infinity)),
                                    alignment: Alignment.centerLeft,
                                    backgroundColor: MaterialStateProperty.resolveWith((state) {
                                      if (state.contains(MaterialState.pressed)) return Colors.grey;
                                      return Colors.lightBlueAccent;
                                    }),
                                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                                    side: MaterialStateProperty.all(const BorderSide(width: 2))),
                                onPressed: () =>
                                    Navigator.pushNamed(context, Routes.settings, arguments: "Einstellungen"),
                                icon: Icon(
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
                                        .height * 0.10,
                                    color: Colors.white,
                                    const IconData(0xe57f, fontFamily: 'MaterialIcons')),
                                label: AutoSizeText('Einstellungen', group: mySizeGRP_H,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    color: Colors.black,
                                  ),
                                ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                              )
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.height*0.15,
                                alignment: Alignment.center,
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(const Size(double.infinity,double.infinity)),
                                      alignment: Alignment.centerLeft,
                                      backgroundColor: MaterialStateProperty.resolveWith((state) {
                                        if (state.contains(MaterialState.pressed)) return Colors.grey;
                                        return Colors.lightBlueAccent;
                                      }),
                                      shadowColor: MaterialStateProperty.all(Colors.transparent),
                                      side: MaterialStateProperty.all(const BorderSide(width: 2))),
                                  onPressed: () =>
                                      Navigator.pushNamed(context, Routes.imprint, arguments: "Impressum"),
                                  icon: Icon(
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
                                          .height * 0.1,
                                      color: Colors.white,
                                      const IconData(0xe33c, fontFamily: 'MaterialIcons')),
                                  label: AutoSizeText('Impressum', group: mySizeGRP_H,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      color: Colors.black,
                                    ),
                                  ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis)
                                )
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
