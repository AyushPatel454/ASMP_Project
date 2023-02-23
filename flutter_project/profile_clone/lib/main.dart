import 'package:flutter/material.dart';
import 'package:profile_clone/post_card.dart';
import 'package:profile_clone/profile_screen.dart';
import 'package:profile_clone/second_tab.dart';
import 'package:profile_clone/tab_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const ProfileScreen(),
      // home: MyHomePage(),
      // home: MyTabBarScreen(),
      home: PostCard(),
    );
  }

  post_card() {}
}

