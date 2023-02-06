import 'package:flutter/material.dart';

class Bottombarwidget extends StatelessWidget {
  const Bottombarwidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        // showSelectedLabels: flase,
        showUnselectedLabels: false,
        iconSize:40,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),
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
              label: ''
          ),
        ],
      ),
    );
  }
}
