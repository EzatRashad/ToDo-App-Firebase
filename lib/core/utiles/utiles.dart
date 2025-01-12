
import 'package:flutter/material.dart';



extension ToFarsiNumber on String {
  String toFarsi() {
    const Map<String, String> numbers = {
      '0': '۰',
      '1': '۱',
      '2': '۲',
      '3': '۳',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '۷',
      '8': '۸',
      '9': '۹',
    };

    return replaceAllMapped(
      RegExp('[0-9]'),
      (match) => numbers[this[match.start]]!,
    );
  }
}


extension EmptyPadding on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );
  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}

