import 'package:flutter/material.dart';

class ErrorDialog {
  static void showErrDialog(BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(
                msg,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              actions: [
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                    onPressed: () => Navigator.of(context).pop(ErrorDialog()),
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ));
  }
}
