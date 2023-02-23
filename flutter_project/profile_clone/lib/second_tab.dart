import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTabBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My TabBar Screen'),
        ),
        body: Column(
          children: [
            Container(
              height: 100,
              color: Colors.blue,
              child: Center(child: Text('Some Elements')),
            ),
            TabBar(
              tabs: [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
              ],
              indicatorColor: Colors.red, // Set the background color
              labelColor: Colors.blue, // Set the text color
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('Tab 1 Content')),
                  Center(child: Text('Tab 2 Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
