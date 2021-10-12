import 'package:flutter/material.dart';
import 'package:steam_wash_i_solna/login.dart';
import 'package:steam_wash_i_solna/register.dart';

class AutenticatinScreen extends StatefulWidget {
  @override
  _AutenticatinScreenState createState() => _AutenticatinScreenState();
}

class _AutenticatinScreenState extends State<AutenticatinScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          /* flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.redAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
            ),
            title: Text(
              'Steam Wash I Solna',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,*/
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                text: 'Logga in',
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                text: 'Registrera',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [Login(), Register()],
        ),
      ),
    );
  }
}
