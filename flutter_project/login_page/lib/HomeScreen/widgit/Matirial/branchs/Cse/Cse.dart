import 'package:flutter/material.dart';
class Cse extends StatefulWidget {
  const Cse({Key? key}) : super(key: key);

  @override
  State<Cse> createState() => _CseState();
}

class _CseState extends State<Cse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shadowColor: Colors.green,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(300, 36),
            ),
            onPressed: () {} ,
            child: Text('Computer Network'),
          ),
        ],
      ),
    );
  }
}
