import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.red,
          title: Text('Top 3 Tabs'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                text: 'Tab 1',
              ),
              Tab(
                text: 'Tab 2',
              ),
              Tab(
                text: 'Tab 3',
              ),
            ],
            indicatorColor: Colors.red, // Set the background color
            labelColor: Colors.blue, // Set the text color
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Text('Tab 1 content'),
          ),
          Center(
            child: Text('Tab 2 content'),
          ),
          Center(
            child: Text('Tab 3 content'),
          ),
          Center(
            child: Text('Tab 4 content'),
          ),
        ],
      ),
    );
  }
}
