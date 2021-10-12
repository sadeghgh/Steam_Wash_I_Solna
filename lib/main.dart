import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:steam_wash_i_solna/splashScreen.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Steam Wash I Solna',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
