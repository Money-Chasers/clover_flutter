import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

buildButton(text, callbackFunction) {
  return (FractionallySizedBox(
    widthFactor: 1,
    child: SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: callbackFunction,
        child: Text(
          text,
          style: GoogleFonts.prompt(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    ),
  ));
}
