import 'package:flutter/material.dart';

class ErrorDialog {
  static void showErrDialog(BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(msg),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(ErrorDialog()),
                    child: const Text("OK"))
              ],
            ));
  }
}
