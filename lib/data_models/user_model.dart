enum questionType {
  attempted, saved,
}

enum paperType {
  attempted, saved,
}

class UserModel {
  String name;
  String email;
  int education;
  List<dynamic> correspondingQuestions;
  List<dynamic> correspondingPapers;

  UserModel({required this.name, required this.email, required this.education, required this.correspondingQuestions, required this.correspondingPapers});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['education'] = education;
    return data;
  }
}

class AttemptedQuestionModel {
  String questionId;
  questionType type;
  bool wasCorrect;

  AttemptedQuestionModel({required this.questionId, required this.type, required this.wasCorrect});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['type'] = type;
    data['wasCorrect'] = wasCorrect;
    return data;
  }
}

class SavedQuestionModel {
  String questionId;
  questionType type;
  String collectionName;

  SavedQuestionModel({required this.questionId, required this.type, required this.collectionName});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['type'] = type;
    data['collectionName'] = collectionName;
    return data;
  }
}

class AttemptedPaperModel {
  String paperId;
  paperType type;
  bool score;

  AttemptedPaperModel({required this.paperId, required this.type, required this.score});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paperId'] = paperId;
    data['type'] = type;
    data['score'] = score;
    return data;
  }
}

class SavedPaperModel {
  String paperId;
  paperType type;
  String collectionName;

  SavedPaperModel({required this.paperId, required this.type, required this.collectionName});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paperId'] = paperId;
    data['type'] = type;
    data['collectionName'] = collectionName;
    return data;
  }
}