import 'package:clover_flutter/components/common_widgets.dart';
import 'package:clover_flutter/components/drawer.dart';
import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/sections/create_paper_section.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/state_management/submit_paper_bloc.dart';
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

  @override
  void initState() {
    super.initState();

    // set from previous values if available.
    PaperModel _currentPaperModel = submitPaperBloc.current;
    _paperTitleController.text = _currentPaperModel.paperTitle;

    int hours = _currentPaperModel.duration[0];
    int minutes = _currentPaperModel.duration[1];
    _attemptDurationController.text =
        _convertDurationListToString(hours, minutes);
    _attemptDurationList[0] = hours;
    _attemptDurationList[1] = minutes;
    _isQuestionPublic = _currentPaperModel.isPublic;
  }

  void _handleSubmitButtonClick() {
    if (_formKey.currentState!.validate()) {
      submitPaperBloc.submitPaperEventSink.add({
        'type': submitPaperActions.updateTitle,
        'payload': _paperTitleController.text
      });
      submitPaperBloc.submitPaperEventSink.add({
        'type': submitPaperActions.updateDuration,
        'payload': _attemptDurationList
      });
      submitPaperBloc.submitPaperEventSink.add({
        'type': submitPaperActions.updateIsPublic,
        'payload': _isQuestionPublic
      });

      // Now navigate to the next page
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const CreatePaperSection()));
    }
  }

  String? _validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.fieldRequired;
    }
    return null;
  }

  String _convertDurationListToString(int hours, int minutes) {
    String _hoursString = '';
    if (hours > 0) {
      _hoursString = hours.toString() + " hours ";
    }
    String _minutesString = '';
    if (minutes > 0) {
      _minutesString = minutes.toString() + " minutes";
    }

    return _hoursString + _minutesString;
  }

  void _handlePickerConfirm(Picker picker, List<int> value) {
    int hours = value[0];
    int minutes = value[1];

    setState(() {
      _attemptDurationList[0] = hours;
      _attemptDurationList[1] = minutes;
      _attemptDurationController.text =
          _convertDurationListToString(hours, minutes);
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
                      validator: _validateTextField,
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
                      validator: _validateTextField,
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
                buildButton(context, 'Create', _handleSubmitButtonClick)
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
        stream: submitPaperBloc.submitPaperStream,
        initialData: submitPaperBloc.current,
        builder: (BuildContext context, AsyncSnapshot snap) {
          return _buildMainWidget(snap.data);
        },
      ),
    );
  }
}
