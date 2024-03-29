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
import '../model/styles/responsive_screen.dart';
import 'package:wortschatz/viewmodels/settings/settings.dart';
import 'package:wortschatz/model/styles/palette.dart';


class Imprint extends StatefulWidget {
  const Imprint({Key? key}) : super(key: key);

  @override
  _ImprintState createState() => _ImprintState();
}

class _ImprintState extends State<Imprint> {
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
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                Text('Impressum',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1, shadows: const <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 1.0,
                    color: Colors.black,
                  ),
                ]), maxLines: 1, overflow: TextOverflow.ellipsis)
              ],
            ),
            Expanded(
                child: Form(
              key: _formKey,
              child: FutureBuilder(
                future: ReadJsonData(),
                builder: (context, data) {
                  if (data.hasError) {
                    return Center(child: Text("${data.error}"));
                  } else if (data.hasData) {
                    var items = data.data as List<ImprintAPI>;
                    return Column(
                      children: <Widget>[
                        Expanded(
                            child: ListView.builder(
                                itemCount: items == null ? 0 : items.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 5,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                          ),
                                          Flexible(
                                              child: Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, right: 8),
                                                  child: Text(
                                                    items[index]
                                                        .content
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                        const SizedBox(height: 10.0),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ))
          ]);
        } else {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                Text('Impressum',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, shadows: const <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 1.0,
                    color: Colors.black,
                  ),
                ]), maxLines: 1, overflow: TextOverflow.ellipsis)
              ],
            ),
            Expanded(
                child: Form(
                  key: _formKey,
                  child: FutureBuilder(
                    future: ReadJsonData(),
                    builder: (context, data) {
                      if (data.hasError) {
                        return Center(child: Text("${data.error}"));
                      } else if (data.hasData) {
                        var items = data.data as List<ImprintAPI>;
                        return Column(
                          children: <Widget>[
                            Expanded(
                                child: ListView.builder(
                                    itemCount: items == null ? 0 : items.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 5,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 6),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 2, vertical: 2),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              left: 8, right: 8),
                                                          child: AutoSizeText(
                                                            items[index]
                                                                .content
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    })),
                            const SizedBox(height: 10.0),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
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


