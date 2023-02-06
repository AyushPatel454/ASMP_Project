import 'package:flutter/material.dart';
import 'package:login_page/HomeScreen/widgit/bottombarwidget.dart';
import 'package:login_page/HomeScreen/widgit/post.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.camera_alt_rounded,
        size: 40,
        color: Colors.grey[600],
        ),
        title: Text('Ask Me',
          style: TextStyle(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search,
            size: 35,
            ), onPressed:(){}),
          
          // IconButton(icon:Image.asset('assets/img') , onPressed: (){},)
        ],
      ),
      bottomNavigationBar: Bottombarwidget(),

      body: postwidget(),
    );
  }
}
