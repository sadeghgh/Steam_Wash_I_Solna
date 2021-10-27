import 'package:flutter/material.dart';
import 'package:steam_wash_i_solna/endPage.dart';
import 'drawer.dart';

class LastPage extends StatefulWidget {
  var name, desc, prices, lat, lng, date, code, phone;
  LastPage(this.name, this.desc, this.prices, this.lat, this.lng, this.date,
      this.code, this.phone);
  @override
  _LastPageState createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  String _model = '', _color = '', _tag = '';
  late String myCode;
  var message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    comparisonCode();
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blueGrey, Colors.grey])),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
                  child: Text(
                    message,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
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
                          onChanged: (value) {
                            _model = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Ange din bilmodell',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                          onChanged: (value) {
                            _tag = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Ange färgen på din bil',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                          onChanged: (value) {
                            _color = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Ange din registreringsskylt',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Material(
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          elevation: 5,
                          child: MaterialButton(
                            onPressed: () async {
                              String lt = widget.lat.toString();
                              String lg = widget.lng.toString();
                              String dt = widget.date.toString();
                              if (_model == '') {
                                _model = '...';
                              } else {
                                _model = _model;
                              }
                              if (_color == '') {
                                _color = '...';
                              } else {
                                _color = _color;
                              }
                              if (_tag == '') {
                                _tag = '...';
                              } else {
                                _tag = _tag;
                              }

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EndPage(
                                          widget.name,
                                          widget.desc,
                                          widget.prices,
                                          _model.trim(),
                                          _color.trim(),
                                          _tag.trim(),
                                          lt,
                                          lg,
                                          dt,
                                          myCode,
                                          widget.phone)));
                            },
                            minWidth: 250,
                            height: 45,
                            child: Text(
                              'Skicka förfrågan',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
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

  void comparisonCode() {
    setState(() {
      if (widget.code == 'nul') {
        myCode = '0';
        message = 'Du har ingen rabattkod';
      } else if (widget.code == '1') {
        myCode = '1';
        message = 'Du har en rabatt som automatiskt tillämpas på dig';
      } else {
        myCode = '2';
        message = 'Du har en rabatt som automatiskt tillämpas på dig';
      }
      // print(myCode);
      // print(message);
    });
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 40);
    path.lineTo(size.width - 70, size.height);
    var endPoint = Offset(size.width - 50, size.height);
    var controllPoint = Offset(size.width - 60, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    var secEndPoint = Offset(size.width, size.height - 40);
    var secControllPoint = Offset(size.width - 30, size.height - 8);
    path.quadraticBezierTo(secControllPoint.dx, secControllPoint.dy,
        secEndPoint.dx, secEndPoint.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    // TODO: implement getClip
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
