import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _buildCards(text) {
    return (Container(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: const Color(0xffd4d4d4),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(width: 1)),
        child: Text(
          text,
          style: GoogleFonts.prompt(textStyle: const TextStyle(fontSize: 20)),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Try these!",
              style: GoogleFonts.oswald(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCards('JEE ADVANCED 2021'),
                  _buildCards('JEE ADVANCED 2020'),
                  _buildCards('JEE ADVANCED 2019'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
