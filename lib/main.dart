import 'package:ecourt/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.amber, fontFamily: 'RobotoMono-Regular.ttf'),
      title: "My Court",
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen.withScreenFunction(
        duration: 2000,
        splash: 'assets/images/pngegg.png',
        splashIconSize: 100.0,
        animationDuration: const Duration(milliseconds: 1000),
        screenFunction: () async {
          return const LoginScreen();
        },
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.leftToRight,
      ),
      // home: Scaffold(
      // body: SplashScreen(),
      // ),
    );
  }
}
