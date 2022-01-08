import 'package:clover_flutter/main.dart';
import 'package:clover_flutter/screens/main_screen/navigation_drawer/submit_questions_section/question_details_screen.dart';
import 'package:clover_flutter/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaperDetailsScreen extends StatefulWidget {
  const PaperDetailsScreen({Key? key}) : super(key: key);

  @override
  _PaperDetailsScreenState createState() => _PaperDetailsScreenState();
}

class _PaperDetailsScreenState extends State<PaperDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleFieldController = TextEditingController();
  final _nQuestionFieldController = TextEditingController();

  _handleFormSubmit(title, nQuestions) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuestionDetailsScreen(
                paperTitle: title, nQuestions: int.parse(nQuestions))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSvg('assets/images/questionPaper.svg'),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColorLight,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleFieldController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.fieldRequired;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: MyApp.of(context)!.getDarkMode()
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            border: const OutlineInputBorder(),
                            hintText: AppLocalizations.of(context)!.enterTitle,
                            prefixIcon: const Icon(Icons.title)),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nQuestionFieldController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.fieldRequired;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: MyApp.of(context)!.getDarkMode()
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            border: const OutlineInputBorder(),
                            hintText: AppLocalizations.of(context)!
                                .enterNumberOfQuestion,
                            prefixIcon: const Icon(Icons.format_list_numbered)),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(height: 20),
                      buildButton(
                          context, AppLocalizations.of(context)!.proceed, () {
                        if (_formKey.currentState!.validate()) {
                          _handleFormSubmit(_titleFieldController.text,
                              _nQuestionFieldController.text);
                        }
                      })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
