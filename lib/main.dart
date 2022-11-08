import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wortschatz/view/categories_view.dart';
import 'package:wortschatz/view/highscore_view.dart';
import 'package:wortschatz/model/dummy_data.dart';
import 'package:wortschatz/view/home_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wortschatz/view/splash_view.dart';
import 'package:wortschatz/view/terms_view.dart';
import 'package:wortschatz/viewmodels/player_progress/player_progress.dart';
import 'package:wortschatz/viewmodels/router/app_router.dart';
import 'package:wortschatz/viewmodels/settings/settings.dart';

import 'model/player_progress/local_storage_player_progress_persistence.dart';
import 'model/player_progress/player_progress_persistence.dart';
import 'model/settings/local_storage_settings_persistence.dart';
import 'model/settings/settings_persistence.dart';
import 'model/styles/palette.dart';

int? isviewed;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed  = await prefs.getInt("onBoard");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
      settingsPersistence: LocalStorageSettingsPersistence(),
      playerProgressPersistence: LocalStoragePlayerProgressPersistence(),
      appRouter: AppRouter()
  ));
}

class MyApp extends StatelessWidget {
  final PlayerProgressPersistence playerProgressPersistence;
  final SettingsPersistence settingsPersistence;
  final AppRouter appRouter;
  const MyApp({Key? key, required this.appRouter, required this.playerProgressPersistence, required this.settingsPersistence}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: HighScoreItems()
          ),
          ChangeNotifierProvider(
            create: (context) {
              var progress = PlayerProgress(playerProgressPersistence);
              progress.getLatestFromStore();
              return progress;
            },
          ),
          Provider(
            create: (context) => Palette(),
          ),
          Provider<SettingsController>(
            lazy: false,
            create: (context) => SettingsController(
              persistence: settingsPersistence,
            )..loadStateFromPersistence(),
          ),
        ],
    child: Builder(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wortschatz',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        initialRoute: isviewed != 0 ? "terms" : "splash",
        onGenerateRoute: appRouter.onGenerateRoute,
        routes: {
          //'categories': (context) => const Categories(),
          'splash': (context) => const SplashScreen(),
          'terms': (context) => const Terms(),
          'home': (context) => const HomeScreen(),
          'score': (context) => const HighScoreScreen(),
        },
      );
    }),
    );
  }
}
