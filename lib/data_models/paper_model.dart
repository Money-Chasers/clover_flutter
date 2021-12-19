
class PaperModel {
  String id;
  String name;
  String score;
  String education;
  List<QuestionModel?> questions;

  PaperModel(this.id, this.name, this.score, this.education, this.questions);

  void addQues(QuestionModel questionModel){
    questions.add(questionModel);
  }

}

class QuestionModel {
  String id;
  String question;
  List<String?> correctAns;
  List<String?> wrongAns;

  QuestionModel(this.id, this.question, this.correctAns, this.wrongAns);

  void addCorrect(String ans){
    correctAns.add(ans);
  }
  void addWrong(String ans){
    wrongAns.add(ans);
  }

}
