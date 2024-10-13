import 'package:flutter/services.dart';

class DigitsOnlyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Hapus leading zero
    newText = newText.replaceFirst(RegExp(r'^0+'), '');

    // Jika kosong, set ke 0
    if (newText.isEmpty) {
      newText = '0';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
