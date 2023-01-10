import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body:Container(
        padding:EdgeInsets.all(30),
        margin: EdgeInsets.symmetric(horizontal: 160,vertical: 200),
        color: Colors.cyanAccent[100],
        child: Text('hello'),
      ),
      
      
      
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Text('click'),
        backgroundColor: Colors.red[600],
      ),
    );
  }
}
