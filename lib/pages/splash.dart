import 'dart:async';
import 'package:demo_flutte/pages/singin_page.dart';
import 'package:demo_flutte/utils/color_const.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool? login;
  bool? onboarded;


  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2), (){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignIn()));

    }
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          color: Colors.white,
          width: width,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [

              Text("Welcome To",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.blackColor
                  )),
              Text("Demo Apps",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                      color: ColorConstants.blueColor
                  )),

            ],
          )),
    );
  }
}
