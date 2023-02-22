import 'package:flutter/material.dart';
import 'package:student_app/screens/matirial_screens/screen/CSE/Os/Books.dart';
import 'package:student_app/screens/matirial_screens/screen/CSE/Os/assignments.dart';
import 'package:student_app/screens/matirial_screens/screen/CSE/Os/notes.dart';
class OS extends StatefulWidget {
  const OS({Key? key}) : super(key: key);

  @override
  State<OS> createState() => _OSState();
}

class _OSState extends State<OS>  with TickerProviderStateMixin{
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
        title: const Text('Operating System Matirial'),
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
