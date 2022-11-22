import 'package:flutter/material.dart';
import 'package:wortschatz/View/home_view.dart';
import 'package:wortschatz/model/constants/routes.dart';
import 'package:wortschatz/view/categories_view.dart';
import 'package:wortschatz/view/start_view.dart';
import 'package:wortschatz/viewmodels/router/custom_page_route.dart';
import 'package:wortschatz/view/settings_view.dart';


import '../../main.dart';
import '../../view/highscore_view.dart';

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
      case Routes.rank:
        return CustomPageRoute(child: const HighScoreScreen(), settings: settings);
      default:
        return null;
    }
  }
}