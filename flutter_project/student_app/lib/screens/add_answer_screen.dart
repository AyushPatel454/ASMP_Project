import 'package:flutter/material.dart';

class UploadAnswer extends StatefulWidget {
  const UploadAnswer({Key? key}) : super(key: key);

  @override
  State<UploadAnswer> createState() => _UploadAnswerState();
}

class _UploadAnswerState extends State<UploadAnswer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
            color: Colors.blueAccent,
            iconSize: 35,
          ),
          title: Text('My App', style: TextStyle(color: Colors.blueAccent),),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.more_vert),
          //     onPressed: () {},
          //     color: Colors.blueAccent,
          //   ),
          // ],
        ),
        body: Center(
          child: Text('Hello, world!'),
        ),
      ),
    );
  }
}
