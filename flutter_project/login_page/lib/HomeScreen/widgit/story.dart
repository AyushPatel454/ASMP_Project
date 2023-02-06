import 'package:flutter/material.dart';
class soryapp extends StatelessWidget {
  const soryapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 67,
      height: 67,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF9B2282),Color(0xFFEEA863)],
        ),
      ),
      child: Container(
        width: 65,
        height: 65,

        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(

          shape: BoxShape.circle,
          boxShadow: [BoxShadow(
              color: Colors.grey

          )],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage('img/c.jpg'))
            ),
          ),
        ),
      ),

    );
  }
}
