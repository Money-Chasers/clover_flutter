// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:clover_flutter/data_models/paper_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class PaperPush extends StatefulWidget {
//   const PaperPush({Key? key}) : super(key: key);
//
//   @override
//   _PaperPushState createState() => _PaperPushState();
// }
//
// class _PaperPushState extends State<PaperPush> {
//   @override
//   Widget build(BuildContext context) {
//     final _paperNameController = TextEditingController();
//     final _noOfQuesController = TextEditingController();
//     final _wrongAnsController = TextEditingController();
//     final _correctAnsController = TextEditingController();
//     final _questionController = TextEditingController();
//
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.pushNamedAndRemoveUntil(
//                       context, "practice-screen", (route) => false);
//                 },
//                 icon: const Icon(Icons.arrow_back),
//               ),
//             ],
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _paperNameController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "This field is required!";
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(),
//                   hintText: "Paper Name",
//                   prefixIcon: Icon(Icons.document_scanner),
//                 ),
//                 style: GoogleFonts.prompt(
//                   textStyle: const TextStyle(
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                 child: TextFormField(
//                   controller: _noOfQuesController,
//                   decoration: const InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(),
//                     hintText: "No of Questions",
//                     prefixIcon: Icon(Icons.document_scanner),
//                   ),
//                   style: GoogleFonts.prompt(
//                     textStyle: const TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                 child: TextFormField(
//                   controller: _questionController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "This field is required!";
//                     }
//                     return null;
//                   },
//                   decoration: const InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(),
//                     hintText: "Question 01",
//                     prefixIcon: Icon(Icons.document_scanner),
//                   ),
//                   style: GoogleFonts.prompt(
//                     textStyle: const TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                 child: TextFormField(
//                   controller: _correctAnsController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "This field is required!";
//                     }
//                     return null;
//                   },
//                   decoration: const InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(),
//                     hintText: "Correct Answer",
//                     prefixIcon: Icon(Icons.document_scanner),
//                   ),
//                   style: GoogleFonts.prompt(
//                     textStyle: const TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                 child: TextFormField(
//                   controller: _wrongAnsController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "This field is required!";
//                     }
//                     return null;
//                   },
//                   decoration: const InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(),
//                     hintText: "Wrong Answers",
//                     prefixIcon: Icon(Icons.document_scanner),
//                   ),
//                   style: GoogleFonts.prompt(
//                     textStyle: const TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               FractionallySizedBox(
//                 widthFactor: 1,
//                 child: SizedBox(
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       _uploadPaper(
//                           _paperNameController.text,
//                           [
//                             QuestionModel(
//                                 "q01",
//                                 ["chemistry"],
//                                 _questionController.text,
//                                 [_correctAnsController.text],
//                                 _wrongAnsController.text.split(" "))
//                           ].toList());
//                     },
//                     child: Text(
//                       "Upload",
//                       style: GoogleFonts.prompt(
//                         textStyle: const TextStyle(
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   void _uploadPaper(String name, List<QuestionModel> questions) {
//     //Id needs to be saved after generating but this is for test case
//     //PaperModel paper = PaperModel("1",name,"10","12",["q01"],["chemistry"]);
//     //QuestionModel q01 = QuestionModel("q01",["chemistry"],question_01,[correctAns],wrongAns);
//
//     var firebaseInstance = FirebaseFirestore.instance;
//     var paperCollection = firebaseInstance.collection("papers");
//     var questionCollection = firebaseInstance.collection("questions");
//     List<String> ids = [];
//     int i = 0;
//
//     //currently the logic is not clean as a list of question would be passed here.
//     // ui needs to be design so that a list of questions can be recorded
//
//     // while (i <= questions.length) {
//     //   if (i < questions.length) {
//     //     questionCollection
//     //         .add(QuestionModel(
//     //                 questions[i].id,
//     //                 questions[i].questionTags,
//     //                 questions[i].question,
//     //                 questions[i].correctAns,
//     //                 questions[i].wrongAns)
//     //             .toJson())
//     //         .then((docRef) => {ids.add(docRef.id)});
//     //     i++;
//     //   } else {
//     questionCollection
//         .add(QuestionModel(
//         questions[i].paperId,
//         questions[i].questionTags,
//         questions[i].questionText,
//         questions[i].correctAns,
//         questions[i].wrongAns)
//         .toJson())
//         .then((docRef) => {
//     paperCollection.add(
//     PaperModel("1", name, "10", "12", [docRef.id], ["chemistry"]).toJson())
//     });
//
//
//     //}
//   }
// }
//
