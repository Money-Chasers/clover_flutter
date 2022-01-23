import 'package:clover_flutter/components/drawer.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/sections/AddQuestionSection.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/sections/create_paper_section.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/sections/paper_details_section.dart';
import 'package:flutter/material.dart';

enum sectionModes { paperDetails, createPaper, addQuestion }

class SubmitQuestionsSection extends StatefulWidget {
  const SubmitQuestionsSection({Key? key}) : super(key: key);

  @override
  _SubmitQuestionsSectionState createState() => _SubmitQuestionsSectionState();
}

class _SubmitQuestionsSectionState extends State<SubmitQuestionsSection> {
  sectionModes _currentSectionMode = sectionModes.paperDetails;

  String _fetchTitleString(sectionModes sectionMode) {
    switch (sectionMode) {
      case (sectionModes.paperDetails):
        return 'Paper Details';
      case (sectionModes.createPaper):
        return 'Create Paper';
      case (sectionModes.addQuestion):
        return 'Add Question';
      default:
        return 'Paper Details';
    }
  }

  Widget _fetchSection(sectionModes sectionMode) {
    switch (sectionMode) {
      case (sectionModes.paperDetails):
        return const PaperDetailsSection();
      case (sectionModes.createPaper):
        return const CreatePaperSection();
      case (sectionModes.addQuestion):
        return const AddQuestionSection();
      default:
        return const PaperDetailsSection();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _fetchTitleString(_currentSectionMode),
        ),
      ),
      drawer: const MyDrawer(),
      body: _fetchSection(_currentSectionMode),
    );
  }
}
