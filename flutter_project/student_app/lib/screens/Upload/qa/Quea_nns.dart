import 'package:flutter/material.dart';

class Q_A extends StatefulWidget {
  const Q_A({Key? key}) : super(key: key);

  @override
  State<Q_A> createState() => _Q_AState();
}

class _Q_AState extends State<Q_A> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions And Answers'),
      ),
    );
  }
}
