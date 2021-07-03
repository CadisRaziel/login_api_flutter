import 'package:flutter/material.dart';
import 'package:login_api/module/home_page/home_page.dart';
import 'package:login_api/module/login_page/login_page.dart';
import 'package:login_api/module/splash_screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login com api',
      theme: ThemeData(       
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/splash_Screen': (context) => SplashScreen(),
        '/home_Page': (context) => HomePage(),
        '/login_Page': (context) => LoginPage()
      },
    );
  }
}
