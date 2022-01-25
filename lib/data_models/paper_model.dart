class PaperModel {
  String paperTitle;
  List<QuestionModel> questionModels;
  List<String> paperTags;
  List<int> duration;
  bool isPublic;

  PaperModel(this.paperTitle, this.questionModels, this.paperTags,
      this.duration, this.isPublic);

  Map<String, dynamic> toJSON(List<String> questionIds) {
    Map<String, dynamic> map = {};
    map['paperTitle'] = paperTitle;
    map['questionIds'] = questionIds;
    map['paperTags'] = paperTags;
    map['duration'] = duration;
    map['isPublic'] = isPublic;

    return map;
  }
}

class QuestionModel {
  String questionText;
  List<OptionModel> options;
  List<String> questionTags;

  QuestionModel(this.questionText, this.options, this.questionTags);

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = {};
    map['questionText'] = questionText;
    map['questionIds'] = options.map((e) => e.toJSON()).toList(growable: false);
    map['questionTags'] = questionTags;

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
