import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steam_wash_i_solna/functions.dart';
import 'package:steam_wash_i_solna/map_page.dart';
import 'package:steam_wash_i_solna/drawer.dart';

class DescriptionPage extends StatefulWidget {
  String name;
  DescriptionPage(this.name);

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  List<ProductServices> _items = [];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('selectionServices')
            .where('name', isEqualTo: widget.name)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            for (var point in snapshot.data!.docs) {
              var productItem = ProductServices(point['name'],
                  point['description'], point['comm'], point['price']);
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

Card generateItem(ProductServices productServices, context) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30))),
    elevation: 6,
    child: InkWell(
      onTap: () {
        String name = productServices.name;
        String desc = productServices.description;
        String prices = productServices.price;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MapPage(name, desc, prices)));
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  productServices.description,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  productServices.comm,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Från ' + productServices.price + '  00 kr',
                  style: TextStyle(fontSize: 30, color: Colors.black87),
                )),
          ],
        ),
      ),
    ),
  );
}
