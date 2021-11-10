import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:steam_wash_i_solna/auth_form.dart';
import 'package:steam_wash_i_solna/homeScreen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    String phoneNr,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        try {
          authResult = await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          setState(() {
            _isLoading = false;
            Route newRoute =
                MaterialPageRoute(builder: (context) => HomeScreen());
            Navigator.pushReplacement(context, newRoute);
          });
        } on FirebaseAuthException catch (e) {
          setState(() {
            _isLoading = false;
          });
        } catch (err) {
          print(err);

          setState(() {
            _isLoading = false;
          });
        }
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await FirebaseFirestore.instance
            .collection('user')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
          'uId': authResult.user!.uid,
          'phone': phoneNr,
          'code': '1',
          'counter': '0',
          'orders': '0',
          'time': DateTime.now()
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.white,
        ),
        child: AuthForm(
          _submitAuthForm,
          _isLoading,
        ),
      ),
    );
  }
}
