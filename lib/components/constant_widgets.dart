import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

buildButton(context, text, callbackFunction) {
  return FractionallySizedBox(
    widthFactor: 1,
    child: SizedBox(
      height: 50,
      child: ElevatedButton(
          onPressed: callbackFunction,
          child: Text(text, style: Theme.of(context).textTheme.button)),
    ),
  );
}

buildSnackBarMessage(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
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
    child: Text(text, style: Theme.of(context).textTheme.subtitle1),
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
