class QuestionModel {
  String questionText;
  List<OptionModel> options;
  List<String> questionTags;

  QuestionModel(this.questionText, this.options, this.questionTags);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionText'] = questionText;
    data['options'] = options.map((e) => e.toJson()).toList(growable: false);
    data['questionTags'] = questionTags;
    return data;
  }
}

class OptionModel {
  String text;
  bool isCorrect;

  OptionModel(this.text, this.isCorrect);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['isCorrect'] = isCorrect;
    return data;
  }
}
