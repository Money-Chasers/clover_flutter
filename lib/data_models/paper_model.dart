class PaperModel {
  String paperTitle;
  List<String> questionIds;
  List<String> paperTags;

  PaperModel(this.paperTitle, this.questionIds, this.paperTags);

  void addTags(String tag) {
    paperTags.add(tag);
  }

  void addQues(String id) {
    questionIds.add(id);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paperTitle'] = paperTitle;
    data['questionIds'] = questionIds;
    data['paperTags'] = paperTags;
    return data;
  }
}
