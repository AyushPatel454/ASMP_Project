import 'package:flutter/material.dart';
import 'package:student_app/screens/matirial_screens/screen/CSE/cse.dart';

class Matirial extends StatefulWidget {
  const Matirial({Key? key}) : super(key: key);

  @override
  State<Matirial> createState() => _MatirialState();
}

class _MatirialState extends State<Matirial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Material'),
      ),

      body:Center(
        child: Column(

          children: <Widget>[
            SizedBox(height: 30,),
            Text('Matirials',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 10,),

            Text('which Matirial You want ? ',
              style: TextStyle(
                fontSize: 20,

              ),
            ),
            SizedBox(height: 50,),

            ElevatedButton( child: Text('Computer Science And Engineering '),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cse_page()),
                );
              },

            ),

            SizedBox(height: 30,),

            ElevatedButton(child: Text('Mechanical Engineering'),
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
                //   MaterialPageRoute(builder: (context) => Mech()),
                // );
              },
            ),

            SizedBox(height: 30,),

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
                //   MaterialPageRoute(builder: (context) => elec()),
                // );
              },
              child: Text('Electrical Engineering'),
            ),

          ],
        ),
      ),
    );
  }
}


