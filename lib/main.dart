import 'package:demo_flutte/pages/home_page.dart';
import 'package:demo_flutte/pages/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },

      initialRoute: '/',
      routes: {
          '/': (context) => const SplashScreen(),   //DashboardBottomBar
        '/homeScreen': (context) => HomeScreen(),
      },
    );
  }
}
