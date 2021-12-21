import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:clover_flutter/service/paper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaperDisplay extends StatefulWidget {
  const PaperDisplay({Key? key}) : super(key: key);

  @override
  State<PaperDisplay> createState() => _PaperDisplayState();
}

class _PaperDisplayState extends State<PaperDisplay> {


  List<PaperModel> papers = List.from([PaperModel("1", "paper1", "10", "10", ["1","2","3"], ["chem"])]);

  void _toPaper(context, paper) {
    Navigator.of(context)
        .pushNamed("paper-attempt", arguments: paper);
  }


  @override
  Widget build(BuildContext context) {

    Paper _paper = Paper();
    _paper.initializePapersData(["organic"]);

    return Scaffold(
      appBar: AppBar(

        title: const Text("Papers",),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView(

                    // not getting data through _paper.paperDocs

                    children: papers.map((paper) {
                      return (GestureDetector(
                        onTap: () => _toPaper(context, paper),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Theme.of(context).primaryColorLight),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            paper.name,
                            style: GoogleFonts.prompt(fontSize: 24),
                          ),
                        ),
                      ));
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
