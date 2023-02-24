import 'package:flutter/material.dart';
import 'package:student_app/screens/matirial_screens/screen/CSE/Computer_network/Books.dart';
import 'package:student_app/screens/matirial_screens/screen/CSE/Computer_network/assignments.dart';
import 'package:student_app/screens/matirial_screens/screen/CSE/Computer_network/notes.dart';

class BookAssignmentNotes extends StatefulWidget {
  final snap;
  const BookAssignmentNotes({Key? key, required this.snap}) : super(key: key);

  @override
  State<BookAssignmentNotes> createState() => _BookAssignmentNotesState();
}

class _BookAssignmentNotesState extends State<BookAssignmentNotes> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.snap['subjectName']}'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              child: Text('Books'),
            ),
            Tab(
              child: Text('Notes'),
            ),
            Tab(
              child: Text('Assignments'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Book(),
          Notes(),
          Assignment(),

        ],
      ),
    );
  }
}
