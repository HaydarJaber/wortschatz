import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wortschatz/View/home_view.dart';
import 'package:wortschatz/viewmodels/terms_api.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter/material.dart';

class Terms extends StatefulWidget {
  const Terms({Key? key}): super(key: key);

  @override
  _TermsState createState() => _TermsState();

}

class _TermsState extends State<Terms> {
  final controller = PageController();
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool? newValue = false;
  bool showErrorMessage = false;

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Nutzungsbedingungen"),foregroundColor: Colors.black,),
        body:
        Form(
          key: _formKey,
          child: FutureBuilder(
            future: ReadJsonData(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var items = data.data as List<TermsAPI>;
                return Column(
                  children: <Widget>[
                    Expanded(
                        child: ListView.builder(
                            itemCount: items == null ? 0 : items.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 5,
                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                      ),
                                      Flexible(
                                          child: Container(
                                            padding: const EdgeInsets.only(bottom: 8),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 8, right: 8),
                                                  child: Text(
                                                    items[index].content.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              );}
                        )
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Ich akzeptiere die Nutzungsbedingungen'),
                          const SizedBox(width: 20.0),
                          Checkbox(
                              focusColor: Colors.lightBlue,
                              activeColor: Colors.green,
                              value: rememberMe,
                              onChanged: (newValue) {
                                setState(() => rememberMe = newValue!);
                              }
                          )
                        ]
                    ),
                    showErrorMessage ?
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(80.0)
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Die Nutzungsbedingungen müssen akzeptiert werden!')
                        )
                    )
                        : Container(),
                    SizedBox(height: 5.0),
                    ElevatedButton(
                        child: const Text('Weiter'),
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            if(rememberMe != true) {
                              setState(() => showErrorMessage = true);
                            }
                            else {
                              setState(() => showErrorMessage = false);
                              _storeOnboardInfo();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const HomeScreen()),
                              );
                            }
                          }
                        }
                    ),
                    SizedBox(height: 10.0),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
    );
  }

  Future<List<TermsAPI>> ReadJsonData() async {
    //read json file
    final jsondata = await rootBundle.rootBundle.loadString('assets/terms.json');
    //decode json data as list
    final list = json.decode(jsondata) as List<dynamic>;

    //map json and initialize using DataModel
    return list.map((e) => TermsAPI.fromJson(e)).toList();
  }
}
