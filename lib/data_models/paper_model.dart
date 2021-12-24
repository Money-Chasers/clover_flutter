class PaperModel {
  String paperTitle;
  String score;
  List<String?> questionIds;
  List<String> paperTags;

  PaperModel(this.paperTitle, this.score, this.questionIds, this.paperTags);

  void addTags(String tag) {
    paperTags.add(tag);
  }

  void addQues(String id) {
    questionIds.add(id);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paperTitle'] = paperTitle;
    data['score'] = score;
    data['questionIds'] = questionIds;
    data['paperTags'] = paperTags;
    return data;
  }
}
