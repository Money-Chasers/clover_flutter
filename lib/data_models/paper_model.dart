class PaperModel {
  String paperTitle;
  List<QuestionModel> questionModels;
  List<int> duration;
  bool isPublic;

  PaperModel(
      this.paperTitle, this.questionModels, this.duration, this.isPublic);

  Map<String, dynamic> toJSON(List<String> questionIds) {
    Map<String, dynamic> map = {};
    map['paperTitle'] = paperTitle;
    map['questionIds'] = questionIds;
    map['duration'] = duration;
    map['isPublic'] = isPublic;

    return map;
  }
}

class QuestionModel {
  String questionText;
  List<OptionModel> options;

  QuestionModel(this.questionText, this.options);

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = {};
    map['questionText'] = questionText;
    map['questionIds'] = options.map((e) => e.toJSON()).toList(growable: false);

    return map;
  }
}

class OptionModel {
  String text;
  bool isCorrect;

  OptionModel(this.text, this.isCorrect);

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = {};
    map['text'] = text;
    map['isCorrect'] = isCorrect;

    return map;
  }
}
