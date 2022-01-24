import 'package:clover_flutter/components/common_widgets.dart';
import 'package:clover_flutter/components/drawer.dart';
import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/sections/create_paper_section.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/state_management/question_paper_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_picker/Picker.dart';

class PaperDetailsSection extends StatefulWidget {
  const PaperDetailsSection({Key? key}) : super(key: key);

  @override
  _PaperDetailsSectionState createState() => _PaperDetailsSectionState();
}

class _PaperDetailsSectionState extends State<PaperDetailsSection> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _paperTitleController = TextEditingController();
  final TextEditingController _attemptDurationController =
      TextEditingController();
  final _attemptDurationList = [0, 0];
  bool _isQuestionPublic = true;

  void _handleButtonClick() {
    if (_formKey.currentState!.validate()) {
      PaperModel paperModel = questionPaperService.current;
      paperModel.paperTitle = _paperTitleController.text;
      paperModel.duration = _attemptDurationList;
      paperModel.isPublic = _isQuestionPublic;
      questionPaperService.update(paperModel);

      // Now navigate to the next page
      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePaperSection()));
    }
  }

  void _handlePickerConfirm(Picker picker, List<int> value) {
    String _hoursString = '';
    if (value[0] > 0) {
      _hoursString = value[0].toString() + " hours ";
    }
    String _minutesString = '';
    if (value[1] > 0) {
      _minutesString = value[1].toString() + " minutes";
    }
    setState(() {
      _attemptDurationList[0] = value[0];
      _attemptDurationList[1] = value[1];
      _attemptDurationController.text = _hoursString + _minutesString;
    });
  }

  void _handlePickerClick() {
    Picker(
      adapter: NumberPickerAdapter(
        data: <NumberPickerColumn>[
          const NumberPickerColumn(begin: 0, end: 2),
          const NumberPickerColumn(begin: 0, end: 60, jump: 1),
        ],
      ),
      builderHeader: (BuildContext context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text('Hours'),
            Text('Minutes'),
          ],
        );
      },
      confirmText: 'Confirm',
      cancelText: 'Cancel',
      cancelTextStyle: const TextStyle(color: Colors.red),
      selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
      onConfirm: _handlePickerConfirm,
    ).showDialog(context);
  }

  void _handleVisibilitySwitchClick(bool value) {
    setState(() {
      _isQuestionPublic = value;
    });
  }

  Widget _buildMainWidget(PaperModel paperModel) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextFormField(
                      controller: _paperTitleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.fieldRequired;
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Paper title'),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      readOnly: true,
                      controller: _attemptDurationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.fieldRequired;
                        }
                        return null;
                      },
                      onTap: _handlePickerClick,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Attempt duration'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Public'),
                        Switch(
                          value: _isQuestionPublic,
                          onChanged: _handleVisibilitySwitchClick,
                        ),
                      ],
                    )
                  ],
                ),
                buildButton(context, 'Create', _handleButtonClick)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.paperDetails),
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder(
        stream: questionPaperService.stream$,
        builder: (BuildContext context, AsyncSnapshot snap) {
          return _buildMainWidget(snap.data);
        },
      ),
    );
  }
}
