import 'package:flutter/material.dart';
class new_post extends StatefulWidget {
  const new_post({Key? key}) : super(key: key);

  @override
  State<new_post> createState() => _new_postState();
}

class _new_postState extends State<new_post> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('creating new post'),
      ),
    );
  }
}
