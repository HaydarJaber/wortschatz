// Frequenz der Wörter (DONE)
///TODO: mit oder ohne Hilfe

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../model/styles/responsive_screen.dart';
import 'package:wortschatz/viewmodels/settings/settings.dart';
import 'package:wortschatz/model/styles/palette.dart';
import '../viewmodels/player_progress/player_progress.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
                          const SizedBox(width: 60),
                          const Text(
                            'Einstellungen',
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
                      Expanded(
                          child: ListView(
                      children: [
                      _gap,
                      const _NameChangeLine(
                      'Name:',
                      ),
                      /*   ValueListenableBuilder<bool>(
              valueListenable: settings.soundsOn,
              builder: (context, soundsOn, child) => _SettingsLine(
                'Sound FX',
                Icon(soundsOn ? Icons.graphic_eq : Icons.volume_off),
                onSelected: () => settings.toggleSoundsOn(),
              ),
            ), */
                      /*     ValueListenableBuilder<bool>(
              valueListenable: settings.musicOn,
              builder: (context, musicOn, child) => _SettingsLine(
                'Music',
                Icon(musicOn ? Icons.music_note : Icons.music_off),
                onSelected: () => settings.toggleMusicOn(),
              ),
            ), */
                        _gap,
                      _FrequenzChangeLine('Frequenz der Wörter:'),
            /*          _SettingsLine(
                      'Fortschritt zurücksetzen',
                      const Icon(Icons.delete),
                      onSelected: () {
                      context.read<PlayerProgress>().reset();
                      final messenger = ScaffoldMessenger.of(context);
                      messenger.showSnackBar(
                      const SnackBar(
                      content: Text('Player progress has been reset.')),
                      );
                      },
                ), */
                _gap,
                ],
                ),)
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

class _NameChangeLine extends StatelessWidget {
  final String title;

  const _NameChangeLine(this.title);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showCustomNameDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
            Text(title,
            style: TextStyle(
              shadows: const <Shadow>[
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 2.0,
                  color: Colors.black,
                ),
              ],
              color: Colors.black,
              fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,
              fontFamily: "Qaz",
            ),),
              ]
            ),
            ValueListenableBuilder(
              valueListenable: settings.playerName,
              builder: (context, name, child) => Text(
                '‘$name’',
                style: TextStyle(
                  shadows: const <Shadow>[
                    Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 5.0,
                      color: Colors.black,
                    ),
                  ],
                  color: Colors.lightBlueAccent,
                  fontSize: MediaQuery
                      .of(context)
                      .size
                      .height * 0.07,
                  fontFamily: "Qaz",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _FrequenzChangeLine extends StatelessWidget {
  final String title;
  final List<String> frequenz = ['Alle Wörter','Hochfrequente Wörter', 'Niedrigfrequente Wörter'];

  _FrequenzChangeLine(this.title);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return InkResponse(
      highlightShape: BoxShape.rectangle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                children: [
                  Text(title,
                      style: TextStyle(
                        shadows: const <Shadow>[
                          Shadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 2.0,
                            color: Colors.black,
                          ),
                        ],
                        color: Colors.black,
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03,
                        fontFamily: "Qaz",
                      ),),
                ]
            ),
            ValueListenableBuilder(
              valueListenable: settings.frequency,
              builder: (context, value, child) =>
                  DropdownButton<String>(
                    value: value,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: TextStyle(
                      shadows: const <Shadow>[
                        Shadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          color: Colors.black,
                        ),
                      ],
                      color: Colors.lightBlueAccent,
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * 0.035,
                      fontFamily: "Qaz",
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      // This is called when the user selects an item.
                      context.read<SettingsController>().setFrequency(value!);
                    },
                    items: frequenz.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsLine extends StatelessWidget {
  final String title;

  final Widget icon;

  final VoidCallback? onSelected;

  const _SettingsLine(this.title, this.icon, {this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 30,
                )),
            const Spacer(),
            icon,
          ],
        ),
      ),
    );
  }
}


