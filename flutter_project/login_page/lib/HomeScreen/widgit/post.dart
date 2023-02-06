import 'package:flutter/material.dart';
class postwidget extends StatelessWidget {
  const postwidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context,index){
          return Column(
            children: [
              Text('  creating post "worked in progress"  ' ),
            ],
            
          );
        },
        // separatorBuilder: separatorBuilder,
        itemCount: 1,
    );
  }
}
