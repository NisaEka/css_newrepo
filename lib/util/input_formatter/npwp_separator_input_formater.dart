import 'package:flutter/services.dart';

class NpwpSeparatorInputFormatter extends TextInputFormatter {
  static const separator = '.';
  static const separatorr = '-';

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');
    if ((oldValue.text.endsWith(separator) || oldValue.text.endsWith(separatorr)) && oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex = newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if (i == 1 || i == 4 || i == 7 || i == 11) {
          newString = separator + newString;
          if (newString.endsWith('.')) {
            newString = newString.replaceAll('.', '');
          }
        } else if (i == 8) {
          newString = separatorr + newString;
          if (newString.endsWith('-')) {
            newString = newString.replaceAll('-', '');
          }
        } else if (i >= 9) {
          newString = newString;
        }
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
