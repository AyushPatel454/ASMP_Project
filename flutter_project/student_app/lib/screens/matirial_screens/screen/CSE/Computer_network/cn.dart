import 'package:flutter/material.dart';

import '../Os/Books.dart';
import '../Os/assignments.dart';
import '../Os/notes.dart';

class CN extends StatefulWidget {
  const CN({Key? key}) : super(key: key);

  @override
  State<CN> createState() => _CNState();
}

class _CNState extends State<CN>  with TickerProviderStateMixin{
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
        title: const Text('Computer Network Matirial'),
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
