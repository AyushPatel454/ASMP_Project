import 'package:flutter/material.dart';
class CN extends StatefulWidget {
  const CN({Key? key}) : super(key: key);

  @override
  State<CN> createState() => _CNState();
}

class _CNState extends State<CN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Computer Network'),
      ),


    );
  }
}
