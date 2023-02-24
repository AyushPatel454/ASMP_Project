import 'package:flutter/material.dart';
class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('notes 1'),
        Text('notes 2'),
        Text('notes 3'),
        Text('notes 4'),
      ],
    );
  }
}
