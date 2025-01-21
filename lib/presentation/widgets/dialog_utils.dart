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
            const CircularProgressIndicator(),
            10.pw,
            const Text("Loading.."),
          ],
        ),
      ),
    );
  }

  static void hideLoading(context) {
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
