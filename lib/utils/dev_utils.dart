import 'dart:math';

import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

var faker = Faker();

PaperModel getFakePaperModel() {
  int nQuestionModels = 5;
  List<QuestionModel> questionModels = [];
  for (int i = 0; i < nQuestionModels; i++) {
    questionModels.add(getFakeQuestionModel());
  }

  return PaperModel(const Uuid().v1(), faker.lorem.words(2).join(' '),
      questionModels, [2, 0], true);
}

QuestionModel getFakeQuestionModel() {
  int nOptions = 4;
  List<OptionModel> options = [];
  for (int i = 0; i < nOptions; i++) {
    options.add(getFakeOptionModel());
  }

  return QuestionModel(
      const Uuid().v1(), faker.lorem.words(10).join(' ').toString(), options);
}

OptionModel getFakeOptionModel() {
  Random random = Random();
  return OptionModel(faker.lorem.words(5).join(' '), random.nextBool());
}
