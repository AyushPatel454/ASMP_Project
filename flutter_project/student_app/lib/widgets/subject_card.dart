import 'package:flutter/material.dart';
import 'package:student_app/screens/matirial_screens/showing_materials.dart';

class SubjectCard extends StatefulWidget {
  final snap;
  String? fieldId = "";
  SubjectCard({Key? key, required this.snap, this.fieldId}) : super(key: key);

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  @override
  Widget build(BuildContext context) {
    // print("---> " + widget.snap.toString());
    print("---> Subject Card " + widget.fieldId.toString());
    // print("---> Subject Card " + widget.snap['fieldID']);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.15),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.transparent,
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookAssignmentNotes(
              snap: widget.snap,
              fieldId: widget.fieldId,
              subId: widget.snap['subjectID'],
            ),
          ),
        ),
        child: Container(
          // color: Colors.black.withOpacity(0.3),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(widget.snap['subjectImgUrl']
                  // 'https://img.freepik.com/free-vector/computer-technology-isometric-icon-server-room-digital-device-set-element-design-pc-laptop_39422-1026.jpg?size=626&ext=jpg&ga=GA1.2.2064448125.1675152419&semt=ais',
                  ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            // color: Colors.black.withOpacity(0.19),
            child: Center(
              child: Text(
                widget.snap['subjectName'],
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 5,
                      color: Colors.grey,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
