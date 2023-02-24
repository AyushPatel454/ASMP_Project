import 'package:flutter/material.dart';
import 'package:student_app/screens/matirial_screens/subjects_screen.dart';

class FieldCard extends StatefulWidget {
  final snap;
  const FieldCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<FieldCard> createState() => _FieldCardState();
}

class _FieldCardState extends State<FieldCard> {
  @override
  Widget build(BuildContext context) {
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
          MaterialPageRoute(builder: (context) => SubjectScreen(snap: widget.snap),),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(
                  widget.snap['imgUrl']),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              widget.snap['fieldName'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: Colors.grey,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
