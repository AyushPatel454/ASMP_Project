import 'package:flutter/material.dart';
class Mech extends StatefulWidget {
  const Mech({Key? key}) : super(key: key);

  @override
  State<Mech> createState() => _MechState();
}

class _MechState extends State<Mech> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mechanical Engineeing'),
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
              child: Text('Matirial Science and Engineering'),
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
              child: Text('Steam Power plant'),
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
              child: Text('fluid Engineering'),
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
              child: Text('mech subject_name'),
            ),
          ],
        ),
      ),
    );
  }
}
