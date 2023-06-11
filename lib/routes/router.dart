import 'package:flutter/material.dart';
import 'package:starterapp/pages/error/%20no_internet_page.dart';
import 'package:starterapp/pages/landing_page.dart';
import 'package:starterapp/pages/splash_screen.dart';
import 'package:starterapp/pages/undefinited_screen.dart';
import 'package:starterapp/routes/routes_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutesConstants.splashScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const SplashScreen(),
      );
    case RoutesConstants.landingRoute:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const LandingPage(),
      );
    case RoutesConstants.noInternetRoute:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const NoInternetPage(),
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => UndefinitedScreen(name: settings.name),
      );
  }
}
