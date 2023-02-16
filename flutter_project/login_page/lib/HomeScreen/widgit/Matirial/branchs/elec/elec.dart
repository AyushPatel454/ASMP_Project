import 'package:flutter/material.dart';

class elec extends StatefulWidget {
  const elec({Key? key}) : super(key: key);

  @override
  State<elec> createState() => _elecState();
}

class _elecState extends State<elec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Electrical Engineering'),
      ),
      body: Center(
      child: Column(
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
            onPressed:(){
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ),
              //);
            },
            child: Text('Microprocessor'),
          ),
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
            child: Text('Ac Current'),
          ),
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
            child: Text('Dc Current'),
          ),
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
            child: Text('electrical subject_name'),
          ),
        ],
      ),
    ),
    );
  }
}
