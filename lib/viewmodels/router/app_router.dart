import 'package:flutter/material.dart';
import 'package:wortschatz/View/home_view.dart';
import 'package:wortschatz/model/constants/routes.dart';
import 'package:wortschatz/view/categories_view.dart';
import 'package:wortschatz/view/manual_view.dart';
import 'package:wortschatz/view/progressCategory_view.dart';
import 'package:wortschatz/view/start_view.dart';
import 'package:wortschatz/viewmodels/router/custom_page_route.dart';
import 'package:wortschatz/view/settings_view.dart';


import '../../main.dart';
import '../../view/Infopage_view.dart';
import '../../view/highscore_view.dart';
import '../../view/imprint_view.dart';
import '../../view/progress_view.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
            builder: (_) => const HomeScreen()
        );
      case Routes.categories:
        return CustomPageRoute(child: const Categories(), settings: settings);
      case Routes.newGame:
        return CustomPageRoute(
            child: StartScreen(category: settings.arguments.toString()),
            settings: settings);
    //  case Routes.game:
     //   return PageRouteBuilder(
      //    pageBuilder: (context, animation1, animation2) =>
      //        Game(category: settings.arguments.toString()),
     //     transitionDuration: const Duration(milliseconds: 100),
      //    reverseTransitionDuration: Duration.zero,
     //   );
      case Routes.settings:
        return CustomPageRoute(child: const Settings(), settings: settings);
   //   case Routes.terms:
      //  return MaterialPageRoute(
         // builder: (_) => const Terms(),
      //  );
      case Routes.progressCATEGORY:
        return CustomPageRoute(child: const ProgressCategory(), settings: settings);
      case Routes.rank:
        return CustomPageRoute(child: const HighScoreScreen(), settings: settings);
      case Routes.progress:
        return CustomPageRoute(child: const ProgressScreen(), settings: settings);
      case Routes.manual:
        return CustomPageRoute(child: const Manual(), settings: settings);
      case Routes.imprint:
        return CustomPageRoute(child: const Imprint(), settings: settings);
      case Routes.infopage:
        return CustomPageRoute(child: Infopage(getProgress: settings.arguments as Map), settings: settings);
      default:
        return null;
    }
  }
}