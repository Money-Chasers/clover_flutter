import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  _buildCards(String text) {
    return (Container(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed("paper-display",arguments: [text].toList());
        },
        child: Container(
          width: 150,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: const Color(0xffd4d4d4),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(width: 1)),
          child: Center(
            child: Text(
              text,
              style:
              GoogleFonts.prompt(textStyle: const TextStyle(fontSize: 20)),
            ),
          ),
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
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCards('Chemistry'),
                  _buildCards('Physics'),
                  _buildCards('Maths'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


