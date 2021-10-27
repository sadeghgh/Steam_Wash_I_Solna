import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steam_wash_i_solna/functions.dart';
import 'package:steam_wash_i_solna/listPrice.dart';
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
            .orderBy('comm')
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
              backgroundColor: Colors.blueGrey[300],
              shadowColor: Colors.grey,
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
                crossAxisCount: 2,
                childAspectRatio: (1 / 2),
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
  myCard() {
    if (productServices.description == 'in och utvändigt') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Våt ångtvätt & torkning av :'),
          Text('•	Däck och fälgar (utan däckglans)'),
          Text('•	Fönster & speglar in och utvändig'),
          Text('•	Invändig rengöring med torr ånga'),
          Text('•	Dammsugning'),
          Text('•	Rengöring av dörrkanter med ånga')
        ],
      );
    } else if (productServices.description == 'Invändig') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Torr ångtvätt av :'),
          Text('•	Dörrkanterna med ånga'),
          Text('•	Fönster & speglar'),
          Text('•	Dammsugning'),
        ],
      );
    } else if (productServices.description == 'Motortvätt') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('•	Tvätt av  '),
          Text('•	 motorrum med torr ånga'),
          Text('•	Behandling av gummi & plastdetaljer'),
        ],
      );
    } else if (productServices.description == 'Premiumtvätt') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('In-/utvändig detaljerad tvätt'),
          Text('•	Rengöring av däck och fälgar  med däckglans'),
          Text('•	Fönster & speglar in och utvändig'),
          Text(
              '• Invändig rengöring med torr ånga(ej innertak) Sätena får en djuprengörande'),
          Text('•	Dammsugning'),
          Text(
              '• Rengöring av mattor AC rengöring Rengöring av dörrkanter med ånga')
        ],
      );
    } else if (productServices.description == 'Utvändig') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Våt ångtvätt & torkning av :'),
          Text('•	Fönster & speglar'),
          Text('•	Däck och fälgar (utan däckglans)'),
        ],
      );
    }
  }

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
            builder: (context) => ListPrice(name, desc, prices)));
      },
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  productServices.description,
                  style: TextStyle(
                      //fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )),
          Padding(padding: EdgeInsets.only(left: 10), child: myCard()),
          Padding(
              padding: EdgeInsets.all(25),
              child: Center(
                child: Text(
                  productServices.price + ' sek',
                  style: TextStyle(
                      //fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              )),
        ],
      ),
    ),
  );
}
