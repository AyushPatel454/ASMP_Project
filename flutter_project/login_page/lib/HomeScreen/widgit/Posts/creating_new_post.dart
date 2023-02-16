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
      appBar: AppBar(
        title: Text('Upload'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[

            SizedBox(height: 50,),
            Text('Which Type Matirial You Want to Upload ?' , style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),

            SizedBox(height: 80,),
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
                //   MaterialPageRoute(builder: (context) => CN()),
                // );
              },
              child: Text('Simple Post'),
            ),

            SizedBox(height: 50,),

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
              child: Text('Upload Matirial'),
            ),


          ],
        ),
      ),
    );
  }
}
