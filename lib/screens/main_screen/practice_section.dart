
import 'package:clover_flutter/screens/paper/paper_push.dart';
import 'package:flutter/material.dart';

class PracticeSection extends StatelessWidget {
  const PracticeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF471823),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const PaperPush()),
                  (e) => false);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
