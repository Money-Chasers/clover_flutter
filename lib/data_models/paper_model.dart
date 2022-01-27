class PaperModel {
  String paperId;
  String paperTitle;
  List<QuestionModel> questionModels;
  List<int> duration;
  bool isPublic;

  PaperModel(this.paperId, this.paperTitle, this.questionModels, this.duration,
      this.isPublic);

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = {};
    map['paperId'] = paperId;
    map['paperTitle'] = paperTitle;

    List<String> questionIds =
        questionModels.map((e) => e.questionId).toList(growable: false);
    map['questionIds'] = questionIds;

    map['duration'] = duration;
    map['isPublic'] = isPublic;

    return map;
  }
}

class QuestionModel {
  String questionId;
  String questionText;
  List<OptionModel> options;

  QuestionModel(this.questionId, this.questionText, this.options);

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = {};
    map['questionId'] = questionId;
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
