
class PaperModel {
  String id;
  String name;
  String score;
  String education;
  List<String?> questionIds;
  List<String> paperTags;

  PaperModel(this.id, this.name, this.score, this.education, this.questionIds, this.paperTags);

  void addTags(String tag){
    paperTags.add(tag);
  }

  void addQues(String id){
    questionIds.add(id);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['score'] = score;
    data['education'] = education;
    data['questionIds'] = questionIds;
    data['paperTags'] = paperTags;
    return data;
  }

}

class QuestionModel {
  String id;
  String question;
  List<String?> correctAns;
  List<String?> wrongAns;
  List<String?> questionTags;

  QuestionModel(this.id, this.questionTags, this.question, this.correctAns, this.wrongAns);

  void addTags(String tag){
    questionTags.add(tag);
  }

  void addCorrect(String ans){
    correctAns.add(ans);
  }
  void addWrong(String ans){
    wrongAns.add(ans);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['correctAns'] = correctAns;
    data['wrongAns'] = wrongAns;
    data['questionTags'] = questionTags;
    return data;
  }

}
