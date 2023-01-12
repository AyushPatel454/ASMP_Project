import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home : Home(),
));
class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
      ),
      body:Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        
        child: Column(
          children: <Widget>[
            Container(                  // row-1
              child: Row(
                children: <Widget>[

                  Text(
                    'Your Name :',
                    style: TextStyle(
                      color: Colors.cyan,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),

            Container(// row-2
              child: Divider(
                height: 30,
                color: Colors.red,

              ),
            ),

            Container(                  // row-1
              child: Row(
                children: <Widget>[

                  Text(
                    'Your Email :',
                    style: TextStyle(
                      color: Colors.cyan,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),

            Container(// row-2
              child: Divider(
                height: 30,
                color: Colors.red,

              ),
            )
          ],
        ),
      )


        
      

    );
  }
}