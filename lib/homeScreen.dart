import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:steam_wash_i_solna/descriptionPage.dart';
import 'package:steam_wash_i_solna/drawer.dart';
import 'package:steam_wash_i_solna/functions.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductNameCar> _items = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('car_model').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            for (var point in snapshot.data!.docs) {
              var productItem =
                  ProductNameCar(point['name_car'], point['image']);
              _items.add(productItem);
            }
          }

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
            ),
            drawer: SizedBox(
              child: Drawer(
                child: SafeArea(child: CustomDrawer()),
              ),
              width: w * 0.8,
            ),
            body: Padding(
              padding: EdgeInsets.all(10),
              child: GridView.count(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                children: List.generate(_items.length, (int position) {
                  return generateItem(_items[position], context);
                }),
              ),
            ),
          );
        });
  }
}

Card generateItem(ProductNameCar productNameCar, context) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30))),
    elevation: 6,
    child: InkWell(
      onTap: () {
        String name = productNameCar.name_car;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DescriptionPage(name)));
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              child: Image.network(productNameCar.image),
            ),
            Text(
              productNameCar.name_car,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    ),
  );
}
