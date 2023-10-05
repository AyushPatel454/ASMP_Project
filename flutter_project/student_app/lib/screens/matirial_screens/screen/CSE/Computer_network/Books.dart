import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Book extends StatefulWidget {
  String? fieldId = "";
  String? subId = "";
  Book({Key? key, this.fieldId, this.subId}) : super(key: key);

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("--------> FieldId " + widget.fieldId.toString());
    print("--------> SubjectId " + widget.subId.toString());
    return Card(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('fields')
              .doc(widget.fieldId)
              .collection('Subjects')
              .doc(widget.subId)
              .collection('Book')
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
                      key: _pdfViewerKey,
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
}













































// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class Book extends StatefulWidget {
//   String? fieldId = "";
//   String? subId = "";
//   Book({Key? key, this.fieldId, this.subId}) : super(key: key);

//   @override
//   State<Book> createState() => _BookState();
// }

// class _BookState extends State<Book> {
//   final ScrollController _scrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     print("--------> FieldId " + widget.fieldId.toString());
//     print("--------> SubjectId " + widget.subId.toString());
//     return Card(
//       child: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('fields')
//               .doc(widget.fieldId)
//               .collection('Subjects')
//               .doc(widget.subId)
//               .collection('Book')
//               .snapshots(),
//           builder: (context,
//               AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               // Handle the case where there is no data in the snapshot.
//               return const Center(
//                 child: Text("No data available"),
//               );
//             }
//             // print("====> Snapshot: " + snapshot.data.toString());
//             // print("====>: " + snapshot.data!.docs[0]['materialUrl']);
//             return Container(
//               height: 400,
//               child: ListView.builder(
//                   controller: _scrollController,
//                   shrinkWrap: true, // --> Important for scrolling
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       child: PDFView(
//                         filePath: snapshot.data!.docs[index]['materialUrl'],
//                         enableSwipe: true,
//                         swipeHorizontal: true,
//                       ),
//                     );
//                   }
//                   // itemBuilder: (context, index) =>
//                   //     Text("${snapshot.data!.docs[index]['materialUrl']}"),
//                   ),
//             );
//           }),
//     );
//   }
// }
