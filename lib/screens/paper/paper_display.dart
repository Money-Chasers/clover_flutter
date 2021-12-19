import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaperDisplay extends StatefulWidget {
  const PaperDisplay({Key? key}) : super(key: key);

  @override
  State<PaperDisplay> createState() => _PaperDisplayState();
}

class _PaperDisplayState extends State<PaperDisplay> {
  _buildCard(text, index) {
    return (GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).primaryColorLight),
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          style: GoogleFonts.prompt(fontSize: 24),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView(

                    children: [
                      _buildCard('Class 1', 1),
                      _buildCard('Class 2', 2),
                      _buildCard('Class 3', 3),
                      _buildCard('Class 4', 4),
                      _buildCard('Class 5', 5),
                      _buildCard('Class 6', 6),
                      _buildCard('Class 7', 7),
                      _buildCard('Class 8', 8),
                      _buildCard('Class 9', 9),
                      _buildCard('Class 10', 10),
                      _buildCard('Class 11', 11),
                      _buildCard('Class 12', 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
