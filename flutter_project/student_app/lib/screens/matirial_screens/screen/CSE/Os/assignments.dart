import 'package:flutter/material.dart';
class Assignment extends StatefulWidget {
  const Assignment({Key? key}) : super(key: key);

  @override
  State<Assignment> createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Assignment 1'),
        Text('Assignment 2'),
        Text('Assignment 3'),
        Text('Assignment 4'),
      ],
    );
  }
}
