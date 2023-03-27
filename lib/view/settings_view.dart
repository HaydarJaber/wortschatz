// Frequenz der Wörter (DONE)
///TODO: mit oder ohne Hilfe

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../model/styles/responsive_screen.dart';
import 'package:wortschatz/viewmodels/settings/settings.dart';
import 'package:wortschatz/model/styles/palette.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final palette = context.watch<Palette>();
    var mySizeGRP_V = AutoSizeGroup();
    var mySizeGRP_H = AutoSizeGroup();
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Hintergrund.jpg"),
                    fit: BoxFit.cover
                ),
              ),
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
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
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                shadows: <Shadow>[
                                ],
                                Icons.home,
                                color: Colors.black,
                              )),
                          SizedBox(width: MediaQuery.of(context).size.width*0.02),
                          Text('Einstellungen',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1, shadows: const <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 1.0,
                              color: Colors.black,
                            ),
                          ]), maxLines: 1, overflow: TextOverflow.ellipsis)
                        ],
                      ),
                      //const Text('Kategorien', style: TextStyle(fontSize: 60,fontFamily: "Modak")
                      Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child:
                                  AutoSizeText('Name:',group: mySizeGRP_V,style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      color: Colors.black,
                                    ),
                                  ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                ],
                              )
                              ,_NameChangeLine('Name:',orientation)
                            ],
                          ),),
                        Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child:
                                  AutoSizeText('Frequenz der Wörter:',group: mySizeGRP_V,style: const TextStyle(fontSize: 70, shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      color: Colors.black,
                                    ),
                                  ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                ],
                              )
                              ,_FrequenzChangeLine('Frequenz der Wörter:',orientation)
                            ],
                          ),),
                        Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child:
                                  AutoSizeText('Schwierigkeit:',group: mySizeGRP_V,style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      color: Colors.black,
                                    ),
                                  ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                ],
                              )
                              ,_SchwierigkeitChangeLine('Schwierigkeit:',orientation)
                            ],
                          ),),
                      ],
                            ),
                      )
                    ],
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              iconSize: MediaQuery.of(context).size.width*0.06,
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                shadows: <Shadow>[
                                ],
                                Icons.home,
                                color: Colors.black,
                              )),
                          SizedBox(width: MediaQuery.of(context).size.width*0.02),
                          Text('Einstellungen',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, shadows: const <Shadow>[
                            Shadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 1.0,
                              color: Colors.black,
                            ),
                          ]), maxLines: 1, overflow: TextOverflow.ellipsis)
                        ],
                      ),
                      //const Text('Kategorien', style: TextStyle(fontSize: 60,fontFamily: "Modak")
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              //padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                              child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child:
                                      AutoSizeText('Name:',group: mySizeGRP_H,style: const TextStyle(fontSize: 300, shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          color: Colors.black,
                                        ),
                                      ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                      ,_NameChangeLine('Name:',orientation)
                                    ],
                                  )),
                            Expanded(
                              //padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                              child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Flexible(child:
                                      AutoSizeText('Frequenz der Wörter:',group: mySizeGRP_H,style: const TextStyle(fontSize: 400, shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          color: Colors.black,
                                        ),
                                      ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 2, overflow: TextOverflow.ellipsis))
                                    ,_FrequenzChangeLine('Frequenz der Wörter:',orientation)
                                    ],
                                  ),
                                ),
                            Expanded(
                              //padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                              child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child:
                                      AutoSizeText('Schwierigkeit:',group: mySizeGRP_H,style: const TextStyle(fontSize: 300, shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          color: Colors.black,
                                        ),
                                      ],fontFamily: "Qaz",color: Colors.black),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                                    ,_SchwierigkeitChangeLine('Schwierigkeit:',orientation)
                                    ],
                                  )
                                  ,),
                          ],
                        ),
                      )
                    ],
                  );
                }
              }),
            )));
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
  late Orientation orientation;

  CustomNameDialog({required this.animation, super.key});

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
      child:
      SimpleDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        title: Text('Namensänderung:',style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.04, shadows: const <Shadow>[
          Shadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 1.0,
            color: Colors.black,
          ),
        ],fontFamily: "Qaz",color: Colors.black),maxLines: 1, overflow: TextOverflow.ellipsis),
        children: [
          TextField(
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.1, shadows: const <Shadow>[
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 1.0,
                color: Colors.lightBlueAccent,
              ),
            ],fontFamily: "Qaz",color: Colors.lightBlueAccent),
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
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((state) {
                if (state.contains(MaterialState.pressed)) return Colors.grey;
                return Colors.lightBlue;
                }),
                minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.05, MediaQuery.of(context).size.height * 0.05))
            ),
            onPressed: () => Navigator.pop(context),
            child: Text('OK',style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.1, shadows: const <Shadow>[
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 1.0,
                color: Colors.black,
              ),
            ],fontFamily: "Qaz",color: Colors.black),maxLines: 1, overflow: TextOverflow.ellipsis),
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

class _NameChangeLine extends StatelessWidget {
  final String title;
  Orientation orientation;

  _NameChangeLine(this.title, this.orientation);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    if (orientation == Orientation.portrait) {
      return InkResponse(
          highlightShape: BoxShape.rectangle,
          onTap: () => showCustomNameDialog(context),
          child: Material(
            color: Colors.transparent,
            child: Ink(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: const ShapeDecoration(
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 2,
                          color: Colors.black)
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: settings.playerName,
                        builder: (context, name, child) =>
                            Flexible(child:
                            AutoSizeText('$name', style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 2.0,
                                color: Colors.lightBlueAccent,
                              ),
                            ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                    ),
                  ],
                ),
              ),
            ),
          )
      );
    }else{
      return InkResponse(
          highlightShape: BoxShape.rectangle,
          onTap: () => showCustomNameDialog(context),
          child: Material(
            color: Colors.transparent,
            child: Ink(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: const ShapeDecoration(
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 2,
                          color: Colors.black)
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: settings.playerName,
                        builder: (context, name, child) =>
                            Flexible(child:
                            AutoSizeText('$name', style: const TextStyle(fontSize: 100, shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 2.0,
                                color: Colors.lightBlueAccent,
                              ),
                            ],fontFamily: "Qaz",color: Colors.lightBlueAccent),minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis))
                    ),
                  ],
                ),
              ),
            ),
          )
      );
    }

  }
}


class _FrequenzChangeLine extends StatelessWidget {
  final String title;
  final List<String> frequenz = ['Alle Wörter','Häufige Wörter', 'Seltene Wörter'];
  Orientation orientation;
  _FrequenzChangeLine(this.title, this.orientation);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    if (orientation == Orientation.portrait) {
      return InkResponse(
          highlightShape: BoxShape.rectangle,
          child:

          Material(
            color: Colors.transparent,
            child: Ink(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.11,
                decoration: const ShapeDecoration(
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 2,
                            color: Colors.black)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: settings.frequency,
                          builder: (context, value, child) =>
                              Flexible(child:
                              DropdownButton<String>(
                                itemHeight: MediaQuery.of(context).size.height*0.1,
                                value: value,
                                icon: Icon(Icons.arrow_downward,size: MediaQuery.of(context).size.width * 0.1),
                                isExpanded: true,
                                elevation: 16,
                                style: const TextStyle(
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      color: Colors.black,
                                    ),
                                  ],
                                  color: Colors.black,
                                  fontFamily: "Qaz",
                                ),
                                underline: Container(
                                  height: 0,
                                  color: Colors.transparent,
                                ),
                                onChanged: (value) {
                                  // This is called when the user selects an item.
                                  context.read<SettingsController>().setFrequency(value!);
                                },
                                items: frequenz.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value,
                                      child: AutoSizeText(value,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1, shadows: const <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          color: Colors.black,
                                        ),
                                      ],fontFamily: "Qaz",color: Colors.black), maxLines: 1, overflow: TextOverflow.ellipsis)
                                  );
                                }).toList(),
                              ))
                      ),
                    ],
                  ),
                )
            ),
          )


      );
    }
    else{
      return InkResponse(
          highlightShape: BoxShape.rectangle,
          child:

          Material(
            color: Colors.transparent,
            child: Ink(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: const ShapeDecoration(
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 2,
                            color: Colors.black)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: settings.frequency,
                          builder: (context, value, child) =>
                              Flexible(child:
                              DropdownButton<String>(
                                itemHeight: MediaQuery.of(context).size.height*0.15,
                                value: value,
                                icon: Icon(Icons.arrow_downward,size: MediaQuery.of(context).size.height * 0.1),
                                isExpanded: true,
                                elevation: 16,
                                style: const TextStyle(
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      color: Colors.black,
                                    ),
                                  ],
                                  color: Colors.black,
                                  fontFamily: "Qaz",
                                ),
                                underline: Container(
                                  height: 0,
                                  color: Colors.transparent,
                                ),
                                onChanged: (value) {
                                  // This is called when the user selects an item.
                                  context.read<SettingsController>().setFrequency(value!);
                                },
                                items: frequenz.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value,
                                      child: AutoSizeText(value,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, shadows: const <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          color: Colors.black,
                                        ),
                                      ],fontFamily: "Qaz",color: Colors.black), maxLines: 1, overflow: TextOverflow.ellipsis)
                                  );
                                }).toList(),
                              ))
                      ),
                    ],
                  ),
                )
            ),
          )


      );
    }

  }
}

class _SchwierigkeitChangeLine extends StatelessWidget {
  final String title;
  final List<String> schwierigkeit = ['Leicht','Normal','Schwer'];
  Orientation orientation;
  _SchwierigkeitChangeLine(this.title, this.orientation);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    if (orientation == Orientation.portrait) {
      return InkResponse(
        highlightShape: BoxShape.rectangle,
        child:
        Material(
            color: Colors.transparent,
            child: Ink(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.11,
              decoration: const ShapeDecoration(
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 2,
                          color: Colors.black)
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: settings.schwierigkeit,
                        builder: (context, value, child) =>
                            DropdownButton<String>(
                              isExpanded: true,
                              value: value,
                              itemHeight: MediaQuery.of(context).size.height*0.1,
                              icon: Icon(Icons.arrow_downward,size: MediaQuery.of(context).size.width * 0.1),
                              elevation: 16,
                              style: const TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    color: Colors.black,
                                  ),
                                ],
                                color: Colors.black,
                                fontFamily: "Qaz",
                              ),
                              underline: Container(
                                height: 0,
                                color: Colors.transparent,
                              ),
                              onChanged: (value) {
                                // This is called when the user selects an item.
                                context.read<SettingsController>().setSchwierigkeit(value!);
                              },
                              items: schwierigkeit.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: AutoSizeText(value, style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1, shadows: const <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      color: Colors.black,
                                    ),
                                  ],fontFamily: "Qaz",color: Colors.black), maxLines: 1, overflow: TextOverflow.ellipsis)
                                  ,
                                );
                              }).toList(),
                            )
                    ),
                  ],
                ),
              ),
            )
        ),
      );
    }
    else {
      return InkResponse(
        highlightShape: BoxShape.rectangle,
        child:
        Material(
            color: Colors.transparent,
            child: Ink(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: const ShapeDecoration(
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 2,
                          color: Colors.black)
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: settings.schwierigkeit,
                        builder: (context, value, child) =>
                            DropdownButton<String>(
                              isExpanded: true,
                              value: value,
                              itemHeight: MediaQuery.of(context).size.height*0.15,
                              icon: Icon(Icons.arrow_downward,size: MediaQuery.of(context).size.height * 0.1),
                              elevation: 16,
                              style: const TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    color: Colors.black,
                                  ),
                                ],
                                color: Colors.black,
                                fontFamily: "Qaz",
                              ),
                              underline: Container(
                                height: 0,
                                color: Colors.transparent,
                              ),
                              onChanged: (value) {
                                // This is called when the user selects an item.
                                context.read<SettingsController>().setSchwierigkeit(value!);
                              },
                              items: schwierigkeit.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: AutoSizeText(value, style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, shadows: const <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      color: Colors.black,
                                    ),
                                  ],fontFamily: "Qaz",color: Colors.black), maxLines: 1, overflow: TextOverflow.ellipsis)
                                  ,
                                );
                              }).toList(),
                            )
                    ),
                  ],
                ),
              ),
            )
        ),
      );
    }

  }
}




