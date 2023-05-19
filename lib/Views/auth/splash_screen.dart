import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/Views/auth/login_screen.dart';
import 'package:offline_classes/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Timer(Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => LoginScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height(context),
            width: width(context),
            decoration: kGradientBoxDecoration(
              0,
              purpleGradident(),
            ),
            child: Center(
              child: SizedBox(
                  width: width(context) * 0.76,
                  child: Image.asset('assets/images/mainLogo.png')),
            ),
          ),
        ],
      ),
    );
  }
}
