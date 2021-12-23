import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

buildButton(text, callbackFunction) {
  return FractionallySizedBox(
    widthFactor: 1,
    child: SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: callbackFunction,
        child: Text(text,
            style:
                GoogleFonts.prompt(textStyle: const TextStyle(fontSize: 18))),
      ),
    ),
  );
}

buildSvg(svgPath) {
  return Container(
    width: 300,
    height: 300,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(150), color: Colors.white),
    child: SvgPicture.asset(svgPath, fit: BoxFit.scaleDown),
  );
}

buildSettingsSectionHeader(context, text) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Text(
      text,
      style: GoogleFonts.prompt(
        textStyle: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
    ),
  );
}

buildSettingsCard(leftSide, rightSide, callbackFunction) {
  return GestureDetector(
    child: Container(
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xffd4d4d4)))),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [leftSide, rightSide],
      ),
    ),
    onTap: callbackFunction,
  );
}
