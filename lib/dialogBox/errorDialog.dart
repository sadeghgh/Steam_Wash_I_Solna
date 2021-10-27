import 'package:flutter/material.dart';
import 'package:steam_wash_i_solna/auth_screen.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String message;
  ErrorAlertDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: [
        ElevatedButton(
            onPressed: () {
              Route newRoute =
                  MaterialPageRoute(builder: (context) => AuthScreen());
              Navigator.pushReplacement(context, newRoute);
            },
            child: Center(
              child: Text('Ok'),
            ))
      ],
    );
  }
}
