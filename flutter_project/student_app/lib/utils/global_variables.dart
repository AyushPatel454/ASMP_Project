import 'package:flutter/material.dart';
import 'package:student_app/screens/Material/Matirial_home.dart';

import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/question_screen.dart';

const webScreenSize = 600;

const homeScreenItem = [
  FeedScreen(),
  QuestionFeed(),
  AddPostScreen(),
  // Center(child: Text('Material')),
  MaterialHome(),
  Center(child: Text('profile')),
];

const questionAnswerItem = [

];