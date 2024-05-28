import 'package:flutter/material.dart';

Size calcTextSize(TextSpan text) {
  final TextPainter textPainter = TextPainter(
    text: text,
    textDirection: TextDirection.ltr,
    // textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
  )..layout();
  return textPainter.size;
}
