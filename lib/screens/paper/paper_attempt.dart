import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:clover_flutter/screens/paper/paper_display.dart';
import 'package:clover_flutter/service/paper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaperAttempt extends StatefulWidget {
  const PaperAttempt({Key? key}) : super(key: key);

  @override
  _PaperAttemptState createState() => _PaperAttemptState();
}

class _PaperAttemptState extends State<PaperAttempt> {

  var i = 0;
  @override
  Widget build(BuildContext context) {
    final PaperModel? paper =
        ModalRoute.of(context)!.settings.arguments as PaperModel?;

    //Paper().initializeQuestions(paper!.questionIds);

    List<QuestionModel> questions = List.from([QuestionModel("1", ["chemistry","easy","atoms"], "Electrons are _ charged.", ["negative"], ["positive","neutral","none"])]);
    questions.add(QuestionModel("2", ["chemistry","easy","atoms"], "Protons are _ charged.", ["positive"], ["negative","neutral","none"]));
    questions.add(QuestionModel("3", ["chemistry","easy","atoms"], "Neutrons are _ charged.", ["neutral"], ["negative","positive","none"]));

    List<String> solutions = [];


    _buildOptions(text) {
      return (GestureDetector(
        onTap: () {
          setState(() {
            if(i<questions.length-1){
              i = i+1;
              solutions.add(text);
            }else{
              Navigator.of(context)
                  .pushNamed("paper-result", arguments: solutions);
            }
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color:  Colors.white),
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: GoogleFonts.prompt(fontSize: 24),
          ),
        ),
      ));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaperDisplay()),
                          (route) => false);
                    },
                    icon: const Icon(Icons.arrow_back)),
                Text(
                  paper!.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 36.0,
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(questions[i].question),
                  _buildOptions(questions[i].correctAns[0]),
                  _buildOptions(questions[i].wrongAns[0]),
                  _buildOptions(questions[i].wrongAns[1]),
                  _buildOptions(questions[i].wrongAns[2]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
