import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:steam_wash_i_solna/dateTime.dart';
import 'package:steam_wash_i_solna/drawer.dart';

class ListPrice extends StatefulWidget {
  String name, desc, prices;
  ListPrice(this.name, this.desc, this.prices);

  @override
  _ListPriceState createState() => _ListPriceState();
}

class _ListPriceState extends State<ListPrice> {
  bool dackGlass = false;
  bool djur = false;
  bool sat7 = false;
  bool sat5 = false;
  bool pers = false;
  bool rango = false;
  bool rengo = false;
  bool acre = false;
  bool ext = false;
  String pprice = '';
  String dackGlas = '';
  String dju = '';
  String sa7 = '';
  String sa5 = '';
  String per = '';
  String rang = '';
  String reng = '';
  String acr = '';
  String ex = '';
  int price = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
    pprice = widget.prices.toString();
    price = int.parse(widget.prices);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
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
        body: ListView(
          children: [
            Card(
              child: Row(
                children: [
                  Checkbox(
                      value: dackGlass,
                      onChanged: (bool? value) {
                        setState(() {
                          dackGlass = value!;
                          if (dackGlass == true) {
                            price = price + 79;
                            pprice = price.toString();
                          } else {
                            price = price - 79;
                            pprice = price.toString();
                          }
                        });
                      }),
                  Text('D??ckglans : '),
                  Text(dackGlas + ' sek')
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  Checkbox(
                      value: djur,
                      onChanged: (bool? value) {
                        setState(() {
                          djur = value!;
                          if (djur == true) {
                            price = price + 99;
                            pprice = price.toString();
                          } else {
                            price = price - 99;
                            pprice = price.toString();
                          }
                        });
                      }),
                  Text('Djurh??r : '),
                  Text(dju + ' sek')
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  Checkbox(
                      value: acre,
                      onChanged: (bool? value) {
                        setState(() {
                          acre = value!;
                          if (acre == true) {
                            price = price + 199;
                            pprice = price.toString();
                          } else {
                            price = price - 199;
                            pprice = price.toString();
                          }
                        });
                      }),
                  Text('AC reng??ring : '),
                  Text(acr + ' sek')
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  Checkbox(
                      value: ext,
                      onChanged: (bool? value) {
                        setState(() {
                          ext = value!;
                          if (ext == true) {
                            price = price + 199;
                            pprice = price.toString();
                          } else {
                            price = price - 199;
                            pprice = price.toString();
                          }
                        });
                      }),
                  Text('Extra smutsig : '),
                  Text(ex + ' sek')
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  Checkbox(
                      value: rengo,
                      onChanged: (bool? value) {
                        setState(() {
                          rengo = value!;
                          if (rengo == true) {
                            price = price + 199;
                            pprice = price.toString();
                          } else {
                            price = price - 199;
                            pprice = price.toString();
                          }
                        });
                      }),
                  Text('Reng??ring av mattor : '),
                  Text(reng + ' sek')
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  Checkbox(
                      value: rango,
                      onChanged: (bool? value) {
                        setState(() {
                          rango = value!;
                          if (rango == true) {
                            price = price + 399;
                            pprice = price.toString();
                          } else {
                            price = price - 399;
                            pprice = price.toString();
                          }
                        });
                      }),
                  Text('Reng??ring av innertak : '),
                  Text(rang + ' sek')
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  Checkbox(
                      value: pers,
                      onChanged: (bool? value) {
                        setState(() {
                          pers = value!;
                          if (pers == true) {
                            price = price + 199;
                            pprice = price.toString();
                          } else {
                            price = price - 199;
                            pprice = price.toString();
                          }
                        });
                      }),
                  Text('per s??te : '),
                  Text(per + ' sek')
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  Checkbox(
                      value: sat5,
                      onChanged: (bool? value) {
                        setState(() {
                          sat5 = value!;
                          if (sat5 == true) {
                            price = price + 699;
                            pprice = price.toString();
                          } else {
                            price = price - 699;
                            pprice = price.toString();
                          }
                        });
                      }),
                  Text('5 s??ten : '),
                  Text(sa5 + ' sek')
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  Checkbox(
                      value: sat7,
                      onChanged: (bool? value) {
                        setState(() {
                          sat7 = value!;
                          if (sat7 == true) {
                            price = price + 979;
                            pprice = price.toString();
                          } else {
                            price = price - 979;
                            pprice = price.toString();
                          }
                        });
                      }),
                  Text('7 s??ten : '),
                  Text(sa7 + ' sek')
                ],
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  pprice + ' sek',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Material(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  elevation: 5,
                  child: MaterialButton(
                    onPressed: () async {
                      String name = widget.name;
                      String desc = widget.desc;
                      String prices = pprice;
                      print(prices);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DateTimePicker(name, desc, prices)));
                    },
                    minWidth: 250,
                    height: 45,
                    child: Text(
                      'N??sta',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            )
          ].toList(),
        ));
  }

  getDate() {
    FirebaseFirestore.instance
        .collection('options')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          dackGlas = doc['D??ckglans'];
          dju = doc['Djurh??r'];
          acr = doc['AC reng??ring'];
          ex = doc['Extra smutsig'];
          reng = doc['Reng??ring av mattor'];
          rang = doc['Reng??ring av innertak'];
          per = doc['per s??te'];
          sa5 = doc['5 s??ten'];
          sa7 = doc['7 s??ten'];
        });
      });
    });
  }
}
