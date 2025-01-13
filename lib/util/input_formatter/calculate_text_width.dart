import 'package:flutter/material.dart';

Size calcTextSize(TextSpan text) {
  final TextPainter textPainter = TextPainter(
    text: text,
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.size;
}
