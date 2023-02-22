import 'package:flutter/material.dart';

import '../Computer_network/assignments.dart';

class Book extends StatefulWidget {
  const Book({Key? key}) : super(key: key);

  @override
  State<Book> createState() => _BookState();
}
class _BookState extends State<Book> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          ListTile(
            leading: Icon(Icons.book,size: 45,),
            title: Text('Book 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Assignment()),
              );
            },

            subtitle: Text('Click to Oper'),
          ),
          ListTile(
            leading: Icon(Icons.book,size: 45,),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Assignment()),
              );
            },
            title: Text('Book 2'),
            subtitle: Text('Click to Open'),
            
          ),
          ListTile(
            leading: Icon(Icons.book,size: 45,),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Assignment()),
              );
            },
            title: Text('Book 3'),
            subtitle: Text('Click to Open'),
          ),
        ],
      ),
    );
  }
}
