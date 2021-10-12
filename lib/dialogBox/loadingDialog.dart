import 'package:flutter/material.dart';
import 'package:steam_wash_i_solna/widgets/loadingWidget.dart';

class LoadingAlertDialog extends StatelessWidget {
  final String message;
  LoadingAlertDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          SizedBox(
            height: 10,
          ),
          Text('Authentication, please wait...'),
        ],
      ),
    );
  }
}
