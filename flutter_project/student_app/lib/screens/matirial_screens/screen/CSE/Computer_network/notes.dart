import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Notes extends StatefulWidget {
  String? fieldId = "";
  String? subId = "";
  Notes({Key? key, this.fieldId, this.subId}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("--------> FieldId Notes " + widget.fieldId.toString());
    print("--------> SubjectId Notes " + widget.subId.toString());
    return Card(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('fields')
              .doc(widget.fieldId)
              .collection('Subjects')
              .doc(widget.subId)
              .collection('Notes')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              // Handle the case where there is no data in the snapshot.
              return const Center(
                child: Text("No data available"),
              );
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 400, // Set a fixed height for the Card
                  child: Card(
                    child: SfPdfViewer.network(
                      '${snapshot.data!.docs[index]['materialUrl']}',
                      key: GlobalKey<
                          SfPdfViewerState>(), // Create a new key for each PDF viewer
                      // key: _pdfViewerKey,
                    ),
                    // child: PDFView(
                    //   filePath: snapshot.data!.docs[index]['materialUrl'],
                    //   enableSwipe: true,
                    //   swipeHorizontal: true,
                    // ),
                  ),
                );
              },
            );
          }),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: [
  //       Text('notes 1'),
  //       Text('notes 2'),
  //       Text('notes 3'),
  //       Text('notes 4'),
  //     ],
  //   );
  // }
}
