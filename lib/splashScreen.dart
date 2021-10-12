import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steam_wash_i_solna/authenticationScreen.dart';
import 'package:steam_wash_i_solna/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/logo.jpg'), fit: BoxFit.cover)),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.lightBlueAccent),
        ),
      ),
    );
  }

  startTimer() {
    Timer(Duration(milliseconds: 10), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Route newRoute = MaterialPageRoute(builder: (context) => HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      } else {
        Route newRoute =
            MaterialPageRoute(builder: (context) => AutenticatinScreen());
        Navigator.pushReplacement(context, newRoute);
      }
    });
  }
}
