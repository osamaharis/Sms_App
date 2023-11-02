

import 'package:MySMS/SplashScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'Widget/CustomTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: CustomTheme().main_theme.copyWith(
              radioTheme: Theme.of(context).radioTheme,
              dividerColor: Colors.transparent,
              checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  splashRadius: 0),
            ),
        darkTheme: CustomTheme().main_theme,
        themeMode: ThemeMode.system,
        home: AnimatedSplashScreen(
            splash: Image.asset(
              "assets/sms.png",
              height: 100,
              width: 100,
            ),
            backgroundColor: Colors.white,
            splashTransition: SplashTransition.slideTransition,
            nextScreen: Home()));
  }
}
