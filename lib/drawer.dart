import 'package:flutter/material.dart';
import 'package:steam_wash_i_solna/commenting.dart';
import 'package:steam_wash_i_solna/discount_code.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: null,
          accountName: null,
        ),
        ListTile(
          title: Text("Kommentarer om dessa tjänster"),
          leading: Icon(Icons.comment),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Commenting()));
          },
        ),
        ListTile(
          title: Text("Orderlista"),
          leading: Icon(Icons.reorder),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DiscountCode()));
          },
        ),
        ListTile(
          title: Text("Stöd"),
          leading: Icon(Icons.phone),
          onTap: () {
            _callMe();
          },
        ),
        ListTile(
          title: Text("fråga och svar"),
          leading: Icon(Icons.email),
          onTap: () {
            _sendMail();
          },
        ),
        /*ListTile(
          title: Text("Om oss"),
          leading: Icon(Icons.description),
          onTap: () {},
        ),*/
      ],
    );
  }

  _callMe() async {
    //Android
    const uri = 'tel:+46 76 084 06 40';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      const uri = 'tel:0046-76-084-06-40';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  _sendMail() async {
    // Android and iOS
    const uri = 'mailto:solna.steamwash@gmail.com';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
