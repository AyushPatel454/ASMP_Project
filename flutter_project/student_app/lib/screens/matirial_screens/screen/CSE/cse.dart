import 'package:flutter/material.dart';
import 'package:student_app/screens/matirial_screens/screen/CSE/Computer_network/cn.dart';
import 'package:student_app/screens/matirial_screens/screen/CSE/Os/os.dart';

class Cse_page extends StatefulWidget {
  const Cse_page({Key? key}) : super(key: key);

  @override
  State<Cse_page> createState() => _Cse_pageState();
}

class _Cse_pageState extends State<Cse_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('computer Science Engineering'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[

            SizedBox(height: 20,),
            Text('Which Subject Matirial You Want ?' , style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CN()),
                );
              },
              child: Text('Computer Network'),
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
              onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OS()),
                );
              },
              child: Text('Operating System'),
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
              child: Text('Mobile App Devlopment'),
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
              child: Text('Web Devlopment'),
            ),
          ],
        ),
      ),
    );
  }
}

