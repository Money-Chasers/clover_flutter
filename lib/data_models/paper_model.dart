class PaperModel {
  String id;
  String name;
  String score;
  String education;
  List<String?> questionIds;
  List<String> tags;

  PaperModel(this.id, this.name, this.score, this.education, this.questionIds, this.tags);

  void addTags(String tag){
    tags.add(tag);
  }

  void addQues(String id){
    questionIds.add(id);
  }

}

class QuestionModel {
  String id;
  String question;
  List<String?> correctAns;
  List<String?> wrongAns;
  List<String?> tags;

  QuestionModel(this.id, this.tags, this.question, this.correctAns, this.wrongAns);

  void addTags(String tag){
    tags.add(tag);
  }

  void addCorrect(String ans){
    correctAns.add(ans);
  }
  void addWrong(String ans){
    wrongAns.add(ans);
  }

}
