import 'package:flutter/material.dart';

Widget buildTextField(String hint, TextEditingController controller,
    FormFieldValidator<String> validator,
    {bool obscureText = false}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    validator: validator,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: Colors.black54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    ),
  );
}

Widget buildLabel(String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

final buttonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.greenAccent,
  foregroundColor: Colors.black,
  minimumSize: const Size.fromHeight(50),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);
