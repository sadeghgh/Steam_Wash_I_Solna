import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

class Commenting extends StatefulWidget {
  @override
  _CommentingState createState() => _CommentingState();
}

class _CommentingState extends State<Commenting> {
  var _comment;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String currentUserUid;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  setTimer() {
    Duration duration = Duration(seconds: 3);
    Timer(duration, () {
      Navigator.pop(context);
    });
  }

  Future sendComment(var com) async {
    currentUserUid = _auth.currentUser!.uid;

    DocumentReference firestoreRef = await FirebaseFirestore.instance
        .collection('user')
        .doc(currentUserUid)
        .collection('comment')
        .add({'author': currentUserUid, 'comment': com});
    if (firestoreRef != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Ditt meddelande har skickats'),
        action: SnackBarAction(
            label: 'ångra',
            onPressed: () {
              Navigator.pop(context);
            }),
        duration: const Duration(seconds: 5),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Ett fel uppstod! Var god försök igen'),
        action: SnackBarAction(label: 'ångra', onPressed: () {}),
        duration: const Duration(seconds: 5),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
      ),
      drawer: SizedBox(
        child: Drawer(
          child: SafeArea(child: CustomDrawer()),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Text(
                "Du kan skriva din åsikt om våra tjänster",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 5,
                        onChanged: (value) {
                          _comment = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Material(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          elevation: 5,
                          child: MaterialButton(
                            onPressed: () async {
                              sendComment(_comment);
                            },
                            minWidth: 250,
                            height: 45,
                            child: Text(
                              'Skicka din kommentar',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),

                      //  SizedBox(height: 16,),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
