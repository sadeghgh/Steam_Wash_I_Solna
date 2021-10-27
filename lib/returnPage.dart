import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steam_wash_i_solna/homeScreen.dart';
import 'package:flutter/services.dart';

class ReturnPage extends StatefulWidget {
  String name, desc, prices, model, color, tag, lt, lg, dt, payment, phone;
  ReturnPage(this.name, this.desc, this.prices, this.model, this.color,
      this.tag, this.lt, this.lg, this.dt, this.payment, this.phone);
  @override
  _ReturnPageState createState() => _ReturnPageState();
}

class _ReturnPageState extends State<ReturnPage> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String currentUserUid;
  late String cunt, order;
  late int iid;
  var message, phone;
  setTimer() {
    Duration duration = Duration(seconds: 3);
    Timer(duration, () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    paymentType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey[300],
        shadowColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Center(
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 10),
                    child: Text(
                      message,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Material(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  elevation: 5,
                  child: MaterialButton(
                    onPressed: () async {
                      sendRequest();
                    },
                    minWidth: 250,
                    height: 45,
                    child: Text(
                      'lämna information',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future sendRequest() async {
    currentUserUid = _auth.currentUser!.uid;
    DocumentReference firestoreRef = await FirebaseFirestore.instance
        .collection('user')
        .doc(currentUserUid)
        .collection('requestUser')
        .add({
      'author': currentUserUid,
      'name_car': widget.name,
      'discription_service': widget.desc,
      'price': widget.prices,
      "lat": widget.lt,
      "lng": widget.lg,
      'timedate': widget.dt,
      'model': widget.model,
      'color': widget.color,
      'car_tag': widget.tag,
      'payment_type': widget.payment,
      'doit': '0',
      'phone': widget.phone,
      'startTime': Timestamp.fromDate(DateTime.now()),
    });
    if (firestoreRef != null) {
      FirebaseFirestore.instance
          .collection('user')
          .doc(currentUserUid)
          .update({'code': 'nul'});

      Clipboard.setData(ClipboardData(text: "+46 76 084 06 40"));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Din begäran har skickats in'),
        action: SnackBarAction(
            label: 'ångra',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }),
        duration: const Duration(seconds: 5),
      ));
      setTimer();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Det finns ett problem. Försök igen'),
        duration: const Duration(seconds: 5),
      ));
    }
  }

  void paymentType() {
    setState(() {
      if (widget.payment == '0') {
        message = 'Betala beloppet hemma';
      } else {
        message =
            'Efter att ha tryckt på bekräftelseknappen lagras tjänsteleverantörens telefonnummer i din telefon och du kan betala beloppet via appen Swish.';
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
