import 'package:flutter/material.dart';
import 'package:steam_wash_i_solna/returnPage.dart';

class EndPage extends StatefulWidget {
  String name, desc, prices, model, color, tag, lt, lg, dt, myCode, phone;
  EndPage(this.name, this.desc, this.prices, this.model, this.color, this.tag,
      this.lt, this.lg, this.dt, this.myCode, this.phone);
  @override
  _EndPageState createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> {
  String message = '', price = '', payment = '';
  late String currentUserUid;
  late String phone;

  void setCod() {
    double pric = double.parse(widget.prices);
    if (widget.myCode == '2') {
      double p = (pric / 100) * 30;
      pric = pric - p;
      price = pric.toString();

      message =
          'Grattis, du har inkluderats i rabatten för din femte användning och du behöver bara betala följande belopp';
    } else if (widget.myCode == '1') {
      double p = (pric / 100) * 20;
      pric = pric - p;
      price = pric.toString();

      message =
          'Eftersom detta är första gången du använder detta system ingår det i rabatten och du behöver bara betala följande belopp';
    } else {
      message =
          'Rabatten gäller för närvarande inte för dig och du måste betala följande belopp';
      price = widget.prices;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                clipper: MyClip(),
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.blueGrey, Colors.grey])),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Text(
                          message,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 10, right: 10),
                        child: Text(
                          price + ' sek',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Material(
                  color: Colors.blueGrey[300],
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  elevation: 5,
                  child: MaterialButton(
                    onPressed: () async {
                      payment = '0';
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReturnPage(
                                  widget.name,
                                  widget.desc,
                                  price,
                                  widget.model,
                                  widget.color,
                                  widget.tag,
                                  widget.lt,
                                  widget.lg,
                                  widget.dt,
                                  payment,
                                  widget.phone)));
                    },
                    minWidth: 250,
                    height: 45,
                    child: Text(
                      'Betalning på plats',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Material(
                  color: Colors.blueGrey[300],
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  elevation: 5,
                  child: MaterialButton(
                    onPressed: () async {
                      payment = '1';
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReturnPage(
                                  widget.name,
                                  widget.desc,
                                  price,
                                  widget.model,
                                  widget.color,
                                  widget.tag,
                                  widget.lt,
                                  widget.lg,
                                  widget.dt,
                                  payment,
                                  widget.phone)));
                    },
                    minWidth: 250,
                    height: 45,
                    child: Text(
                      'Betala med appen Swish',
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
}

class MyClip extends CustomClipper<Path> {
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
