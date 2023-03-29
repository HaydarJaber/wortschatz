
import 'dart:convert';
import 'package:pdfx/pdfx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wortschatz/view/pdfviewer_view.dart';
import 'package:wortschatz/viewmodels/imprint_api.dart';
import '../model/constants/routes.dart';
import '../model/styles/responsive_screen.dart';
import 'package:wortschatz/viewmodels/settings/settings.dart';
import 'package:wortschatz/model/styles/palette.dart';
import 'home_view.dart';

class Manual extends StatefulWidget {
  const Manual({Key? key}) : super(key: key);

  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  final pdfPinchController = PdfControllerPinch(
    document: PdfDocument.openAsset('assets/Anleitung.pdf'),
  );
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
          return Column(
              mainAxisSize: MainAxisSize.max, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    iconSize: MediaQuery.of(context).size.width*0.1,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      shadows: <Shadow>[
                      ],
                      Icons.home,
                      color: Colors.black,
                    )),
                SizedBox(width: MediaQuery.of(context).size.width*0.02),
                Text('Anleitung',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1, shadows: const <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 1.0,
                    color: Colors.black,
                  ),
                ]), maxLines: 1, overflow: TextOverflow.ellipsis)
              ],
            ),
            Flexible(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                ElevatedButton(
                  style: ButtonStyle(
                      alignment: Alignment.center,
                      backgroundColor: MaterialStateProperty.resolveWith((state) {
                        if (state.contains(MaterialState.pressed)) {
                          return Colors.grey;
                        }
                        return Colors.lightBlueAccent;
                      }),
                      shadowColor: MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateProperty.all(const BorderSide(width: 2)),
                      minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.8, MediaQuery.of(context).size.height * 0.3))
                  ),
                  onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PdfLabPage(name: 'assets/Therapeut_Anleitung.pdf',titel: 'Anleitung Therapeut')))
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          shadows: const <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              color: Colors.black,
                            ),
                          ],
                          size: MediaQuery.of(context).size.height * 0.2,
                          color: Colors.white,
                          const IconData(0xf56d,
                              fontFamily: 'FontAwesomeSolid',
                              fontPackage: 'font_awesome_flutter')),
                      Text(
                        "Therapeut",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          shadows: const <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 2.0,
                              color: Colors.black,
                            ),
                          ],
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height * 0.06,
                          fontFamily: "Qaz",
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateProperty.resolveWith((state) {
                      if (state.contains(MaterialState.pressed)) {
                        return Colors.grey;
                      }
                      return Colors.lightBlueAccent;
                    }),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    side: MaterialStateProperty.all(const BorderSide(width: 2)),
                    minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.8, MediaQuery.of(context).size.height * 0.3)),
                  ),
                  onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PdfLabPage(name: 'assets/Spieler_Anleitung.pdf',titel: 'Anleitung Spieler')))
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          shadows: const <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              color: Colors.black,
                            ),
                          ],
                          size: MediaQuery.of(context).size.height * 0.2,
                          color: Colors.white,
                          const IconData(0xf56d,
                              fontFamily: 'FontAwesomeSolid',
                              fontPackage: 'font_awesome_flutter')),
                      Text(
                        "Spieler",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          shadows: const <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 2.0,
                              color: Colors.black,
                            ),
                          ],
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height * 0.06,
                          fontFamily: "Qaz",
                        ),
                      ),
                    ],
                  ),
                )
            ]
            ))
          ]);
        } else {
          return Column(
              mainAxisSize: MainAxisSize.max, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    iconSize: MediaQuery.of(context).size.width*0.05,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      shadows: <Shadow>[
                      ],
                      Icons.home,
                      color: Colors.black,
                    )),
                SizedBox(width: MediaQuery.of(context).size.width*0.02),
                Text('Anleitung',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, shadows: const <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 1.0,
                    color: Colors.black,
                  ),
                ]), maxLines: 1, overflow: TextOverflow.ellipsis)
              ],
            ),
            Expanded(child:
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                  ElevatedButton(
                    style: ButtonStyle(
                        alignment: Alignment.center,
                        maximumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.4, MediaQuery.of(context).size.height * 0.6)),
                        backgroundColor: MaterialStateProperty.resolveWith((state) {
                          if (state.contains(MaterialState.pressed)) {
                            return Colors.grey;
                          }
                          return Colors.lightBlueAccent;
                        }),
                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                        side: MaterialStateProperty.all(const BorderSide(width: 2)),
                        minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.4, MediaQuery.of(context).size.height * 0.1))
                    ),
                    onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const PdfLabPage(name: 'assets/Therapeut_Anleitung.pdf',titel: 'Anleitung Therapeut')))
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            shadows: const <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 10.0,
                                color: Colors.black,
                              ),
                            ],
                            size: MediaQuery.of(context).size.height * 0.2,
                            color: Colors.white,
                            const IconData(0xf56d,
                                fontFamily: 'FontAwesomeSolid',
                                fontPackage: 'font_awesome_flutter')),
                        Text(
                          "Therapeut",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            shadows: const <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 1.0,
                                color: Colors.black,
                              ),
                            ],
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height * 0.06,
                            fontFamily: "Qaz",
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      alignment: Alignment.center,
                      maximumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.4, MediaQuery.of(context).size.height * 0.6)),
                      backgroundColor: MaterialStateProperty.resolveWith((state) {
                        if (state.contains(MaterialState.pressed)) {
                          return Colors.grey;
                        }
                        return Colors.lightBlueAccent;
                      }),
                      shadowColor: MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateProperty.all(const BorderSide(width: 2)),
                      minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.4, MediaQuery.of(context).size.height * 0.1)),
                    ),
                    onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const PdfLabPage(name: 'assets/Spieler_Anleitung.pdf',titel: 'Anleitung Spieler')))
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            shadows: const <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 10.0,
                                color: Colors.black,
                              ),
                            ],
                            size: MediaQuery.of(context).size.height * 0.2,
                            color: Colors.white,
                            const IconData(0xf56d,
                                fontFamily: 'FontAwesomeSolid',
                                fontPackage: 'font_awesome_flutter')),
                        Text(
                          "Spieler",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            shadows: const <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 1.0,
                                color: Colors.black,
                              ),
                            ],
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height * 0.06,
                            fontFamily: "Qaz",
                          ),
                        ),
                      ],
                    ),
                  )
                ]
            ))
          ]);
        }
      }),
    )));
  }

  Future<List<ImprintAPI>> ReadJsonData() async {
    //read json file
    final jsondata = await rootBundle.loadString('assets/imprint.json');
    //decode json data as list
    final list = json.decode(jsondata) as List<dynamic>;

    //map json and initialize using DataModel
    return list.map((e) => ImprintAPI.fromJson(e)).toList();
  }
}

void showCustomNameDialog(BuildContext context) {
  showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          CustomNameDialog(animation: animation));
}

class CustomNameDialog extends StatefulWidget {
  final Animation<double> animation;

  const CustomNameDialog({required this.animation, super.key});

  @override
  State<CustomNameDialog> createState() => _CustomNameDialogState();
}

class _CustomNameDialogState extends State<CustomNameDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: widget.animation,
        curve: Curves.easeOutCubic,
      ),
      child: SimpleDialog(
        title: const Text('Namensänderung'),
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            maxLength: 12,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              context.read<SettingsController>().setPlayerName(value);
            },
            onSubmitted: (value) {
              // Player tapped 'Submit'/'Done' on their keyboard.
              Navigator.pop(context);
            },
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _controller.text = context.read<SettingsController>().playerName.value;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
