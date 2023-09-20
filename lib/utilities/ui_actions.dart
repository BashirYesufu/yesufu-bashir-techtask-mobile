import 'package:flutter/material.dart';

class UIActions {
  static void showError(BuildContext context, message){
    SnackBar snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}