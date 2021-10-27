import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

class DiscountCode extends StatefulWidget {
  @override
  _DiscountCodeState createState() => _DiscountCodeState();
}

class _DiscountCodeState extends State<DiscountCode> {
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user')
          .doc(currentUserUid)
          .collection('requestUser')
          .orderBy(
            'startTime',
            descending: true,
          )
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.blueGrey[300],
              shadowColor: Colors.grey,
            ),
            body: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      elevation: 6,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        tileColor: data['doit'] == '0'
                            ? Colors.white
                            : Colors.blueGrey,
                        title: Column(
                          children: [
                            Row(children: [Text(data['discription_service'])]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: [
                              Text(data['timedate']),
                            ])
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data['price'] + ' sek'),
                            IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(currentUserUid)
                                    .collection('requestUser')
                                    .doc(document.id)
                                    .delete();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Din begäran har raderats'),
                                  duration: const Duration(seconds: 5),
                                ));
                              },
                              icon: data['doit'] == '0'
                                  ? Icon(Icons.delete)
                                  : Icon(null),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )));
      },
    );
  }
}
