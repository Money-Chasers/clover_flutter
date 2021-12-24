class QuestionModel {
  String questionText;
  List<String?> correctAns;
  List<String?> wrongAns;
  List<String?> questionTags;

  QuestionModel(
      this.questionTags, this.questionText, this.correctAns, this.wrongAns);

  void addTags(String tag) {
    questionTags.add(tag);
  }

  void addCorrect(String ans) {
    correctAns.add(ans);
  }

  void addWrong(String ans) {
    wrongAns.add(ans);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionText'] = questionText;
    data['correctAns'] = correctAns;
    data['wrongAns'] = wrongAns;
    data['questionTags'] = questionTags;
    return data;
  }
}
