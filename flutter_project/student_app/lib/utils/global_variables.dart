import 'package:flutter/material.dart';
import '../screens/add_post_screen.dart';
import '../screens/matirial_screens/matirial_homepage.dart';

const webScreenSize = 600;

const homeScreenItem = [
  Center(child: Text('feed')),
  Center(child: Text('Q/A')),
  AddPostScreen(),
  Matirial(),
  Center(child: Text('profile')),
];