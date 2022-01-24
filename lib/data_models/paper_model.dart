class PaperModel {
  String paperTitle;
  List<QuestionModel> questionModels;
  List<String> paperTags;
  List<int> duration;
  bool isPublic;

  PaperModel(this.paperTitle, this.questionModels, this.paperTags,
      this.duration, this.isPublic);
}

class QuestionModel {
  String questionText;
  List<OptionModel> options;
  List<String> questionTags;

  QuestionModel(this.questionText, this.options, this.questionTags);
}

class OptionModel {
  String text;
  bool isCorrect;

  OptionModel(this.text, this.isCorrect);
}
