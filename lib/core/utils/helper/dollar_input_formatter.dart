import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat currencyFormatter = NumberFormat.decimalPattern('en_US');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Filter input untuk hanya menerima angka
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Jika input kosong, set nilai default ke 0
    if (newText.isEmpty) {
      return TextEditingValue(
        text: '0',
        selection: TextSelection.collapsed(offset: 1),
      );
    }

    // Parse input menjadi angka double
    double? newDouble = double.tryParse(newText);

    if (newDouble == null) {
      return oldValue; // Jika gagal parsing, kembalikan nilai lama
    }

    // Format angka dengan pemisah ribuan
    String formattedText = currencyFormatter.format(newDouble);

    // Hitung posisi kursor setelah pemformatan
    int selectionIndex =
        formattedText.length - (newValue.text.length - newValue.selection.end);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
