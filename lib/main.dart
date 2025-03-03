import 'package:animations/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen/bread_screen.dart';
import 'home_screen/card_animation_2_screen.dart';
import 'home_screen/card_animation_screen.dart';
import 'splash_screen/not_fount_screen.dart';
import 'splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        useMaterial3: true,
      ),
      onGenerateRoute: generateRoute,
    );
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.name:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case HomeScreen.name:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case CardAnimationScreen.name:
        return MaterialPageRoute(
          builder: (context) => CardAnimationScreen(),
        );
      case CardAnimation2Screen.name:
        return MaterialPageRoute(
          builder: (context) => CardAnimation2Screen(),
        );
      case BreadScreen.name:
        return MaterialPageRoute(
          builder: (context) => BreadScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => NotFountScreen(),
        );
    }
  }
}
