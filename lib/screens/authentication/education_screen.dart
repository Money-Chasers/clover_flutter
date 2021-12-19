import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover_flutter/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final _firestoreInstance = FirebaseFirestore.instance;

  int _education = 0;

  _buildCard(text, index) {
    return (GestureDetector(
      onTap: () {
        setState(() {
          if (index == _education) {
            _education = 0;
          } else {
            _education = index;
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: index == _education
                ? Theme.of(context).primaryColorLight
                : Colors.white),
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
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Text(
                  "What's your class?",
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
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
                FractionallySizedBox(
                  widthFactor: 1,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: _education == 0
                            ? Colors.grey
                            : Theme.of(context).primaryColor,
                        splashFactory: _education == 0
                            ? NoSplash.splashFactory
                            : InkRipple.splashFactory,
                        shadowColor: _education == 0
                            ? Colors.transparent
                            : Theme.of(context).shadowColor,
                      ),
                      onPressed: () {
                        if (_education != 0) {
                          //Temporarily moving to main screen to check..
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => const MainScreen()));

                        }
                      },
                      child: Text(
                        "Proceed",
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
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
