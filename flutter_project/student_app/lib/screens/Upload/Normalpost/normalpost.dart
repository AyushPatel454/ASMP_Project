import 'package:flutter/material.dart';

class NormalPost extends StatefulWidget {
  const NormalPost({Key? key}) : super(key: key);

  @override
  State<NormalPost> createState() => _NormalPostState();
}

class _NormalPostState extends State<NormalPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Normal Post'),
      ),
    );
  }
}
