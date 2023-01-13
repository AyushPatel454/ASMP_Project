import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home : Home(),
));

class Home extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Log In'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/a.jpg'),
                radius: 40,
              ),
            ),
            Divider(height: 90,color: Colors.grey[800],),
            Text('NAME',style: TextStyle(color: Colors.grey,letterSpacing: 2)),
            SizedBox(height: 10),
            Text('YAKSH',style: TextStyle(color: Colors.amber,letterSpacing: 2,fontSize:25,fontWeight: FontWeight.bold)),
            SizedBox(height: 30,),
            Text('Current ninja level',style: TextStyle(color: Colors.grey,letterSpacing: 2)),
            SizedBox(height: 10),
            Text('5',style: TextStyle(color: Colors.amber,letterSpacing: 2,fontSize:25,fontWeight: FontWeight.bold)),
            SizedBox(height: 30),

            Row(
              children: <Widget>[
                Icon(Icons.email,color: Colors.grey[400],),
                SizedBox(width: 10),
                Text('panchalyaksh512@gmail.com',style: TextStyle(color:Colors.grey[400],fontSize: 18,letterSpacing: 1.0),),
              ],
            )
          ],
        ),
      ),




    );
  }
}