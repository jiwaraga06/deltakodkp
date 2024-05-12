import 'package:deltakodkp/source/pages/index.dart';
import 'package:deltakodkp/source/router/string.dart';
import 'package:flutter/material.dart';

class RouterNavigation {
  SlideTransition bottomToTop(context, animation, secondaryAnimation, child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(position: animation.drive(tween), child: child);
  }

  SlideTransition topToBottom(context, animation, secondaryAnimation, child) {
    const begin = Offset(0.0, -1.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(position: animation.drive(tween), child: child);
  }

  SlideTransition rightToLeft(context, animation, secondaryAnimation, child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }

  SlideTransition leftToRight(context, animation, secondaryAnimation, child) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const SplashScreen(),
          transitionsBuilder: bottomToTop,
        );
      case loginScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
          transitionsBuilder: bottomToTop,
        );
      case dashboardScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const DashboardScreen(),
          transitionsBuilder: bottomToTop,
        );
      // input
      //wo
      case woScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const WoScreen(),
          transitionsBuilder: rightToLeft,
        );
      case detailWoScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const DetailWoScreen(),
          transitionsBuilder: rightToLeft,
          settings: settings,
        );
      case inputWoScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const InputWoScreen(),
          transitionsBuilder: rightToLeft,
        );
      // consumable
      case consumableScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const ConsumableScreen(),
          transitionsBuilder: rightToLeft,
        );
      case detailConsumableScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const DetailConsumableScreen(),
          transitionsBuilder: rightToLeft,
          settings: settings,
        );
      case inputConsumableScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const InputConsumableScreen(),
          transitionsBuilder: rightToLeft,
        );
// inventory
      case inputInventoryScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const InputInvetoryScreen(),
          transitionsBuilder: rightToLeft,
        );
      default:
        return null;
    }
  }
}
