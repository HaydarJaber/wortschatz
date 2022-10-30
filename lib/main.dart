import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wortschatz/view/highscore_view.dart';
import 'package:wortschatz/model/dummy_data.dart';
import 'package:wortschatz/view/home_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wortschatz/view/splash_view.dart';
import 'package:wortschatz/view/terms_view.dart';

int? isviewed;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed  = await prefs.getInt("onBoard");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);
    return ChangeNotifierProvider.value(
      value: HighScoreItems(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wortschatz',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        initialRoute: isviewed != 0 ? "terms" : "splash",
        routes: {
          'splash': (context) => const SplashScreen(),
          'terms': (context) => const Terms(),
          'home': (context) => const HomeScreen(),
          'score': (context) => const HighScoreScreen(),
        },
      ),
    );
  }
}
