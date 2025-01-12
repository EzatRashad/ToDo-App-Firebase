import 'package:fire_todo/core/utiles/utiles.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            10.pw,
            Text("Loading.."),
          ],
        ),
      ),
    );
  }

  static void hide(context) {
    Navigator.of(context).pop();
  }

  static void showMessage(
    context,
    String message, {
    String? title,
    String? posActionName,
    String? negActionName,
    VoidCallback? posAction,
    VoidCallback? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.of(context).pop();

            posAction?.call();
          },
          child: Text(posActionName)));
    }
    if (negActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.of(context).pop();

            negAction?.call();
          },
          child: Text(negActionName)));
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        actions: actions,
        title: Text(title ?? ""),
        content: Text(message),
      ),
    );
  }
}
