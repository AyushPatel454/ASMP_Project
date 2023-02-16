
import 'package:flutter/material.dart';
import 'package:login_page/HomeScreen/widgit/Posts/creating_new_post.dart';
class post extends StatelessWidget {
  const post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new_post()),
          );
        },
        tooltip: 'New Post',
        child: Icon(Icons.add),

      ),
      body: Center(
        child: Container(
          child: Text('this is home page for post '),

        ),
      ),



    );





  }
}
