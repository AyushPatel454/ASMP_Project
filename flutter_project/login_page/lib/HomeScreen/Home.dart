import 'package:flutter/material.dart';
import 'package:login_page/HomeScreen/widgit/Posts/Home_posts.dart';
import 'package:login_page/HomeScreen/widgit/Matirial/Matirial_home.dart';
import 'package:login_page/HomeScreen/widgit/Q_A/Q_A_home_screen.dart';
import 'package:login_page/HomeScreen/widgit/profile/profile_page_1.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {

  int _currentIndex = 0;
  List<Widget> body = const [
    post(),
    matirial(),
    que_ans(),
    profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
        Icon(Icons.star_border,
        size: 40,
        color: Colors.grey[600],
        ),
        title: Text('',
          style: TextStyle(),
        ),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.search,
          //   size: 35,
          //   ), onPressed:(){}),
          
          // IconButton(icon:Image.asset('assets/img') , onPressed: (){},)
        ],
      ),

      body:Center(
        child: body[_currentIndex],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex){
          setState(() {
            _currentIndex = newIndex;
          });
        },
        iconSize:40,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('img/home.png', width:40,),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Image.asset('img/matirial_icon2.png', width:40,),
              label: 'Matirial'
          ),
          BottomNavigationBarItem(
              icon: Image.asset('img/question-and-answer_icon.png', width: 40,),
              label: 'Q/A'
          ),
          BottomNavigationBarItem(
              icon: Image.asset('img/profile.png' , width: 40,),
              label: 'Profile'
          ),
        ],
      ),
    );
  }
}
