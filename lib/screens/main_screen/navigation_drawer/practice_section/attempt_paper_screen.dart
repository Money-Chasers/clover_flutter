import 'package:flutter/material.dart';

class AttemptPaperScreen extends StatefulWidget {
  final questionIds;
  const AttemptPaperScreen({Key? key, required this.questionIds}) : super(key: key);

  @override
  _AttemptPaperScreenState createState() => _AttemptPaperScreenState();
}

class _AttemptPaperScreenState extends State<AttemptPaperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attempt Paper'),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
