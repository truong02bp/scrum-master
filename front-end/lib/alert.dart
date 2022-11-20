import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSuccessAlert(String message, BuildContext context) {
  AwesomeDialog(
    context: context,
    animType: AnimType.TOPSLIDE,
    headerAnimationLoop: false,
    dialogType: DialogType.NO_HEADER,
    aligment: Alignment.topRight,
    autoDismiss: true,
    autoHide: Duration(seconds: 1, milliseconds: 300),
    useRootNavigator: false,
    desc: message,
    width: message.length < 80 ? 400 : 500,
    body: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 30,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(child: Text('$message'))
        ],
      ),
    ),
  ).show();
}

void showErrorAlert(String message, BuildContext context) {
  message = message.substring(message.indexOf(": ") + 1, message.length);
  AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.NO_HEADER,
      aligment: Alignment.topRight,
      showCloseIcon: true,
      autoDismiss: true,
      autoHide: Duration(seconds: 3),
      useRootNavigator: false,
      desc: message,
      width: message.length < 80 ? 400 : 500,
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Row(
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 30,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(child: Text('$message'))
          ],
        ),
      )).show();
}

class Validator {
  static bool isValidEmail(String email) {
    if (email.isEmpty) {
      return false;
    }
    if (!email.contains("@gmail.com")) {
      return false;
    }
    return true;
  }
}
