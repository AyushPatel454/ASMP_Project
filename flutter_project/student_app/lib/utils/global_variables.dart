import 'package:flutter/material.dart';

import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/matirial_screens/matirial_homepage.dart';
import '../screens/question_screen.dart';

const webScreenSize = 600;

const homeScreenItem = [
  FeedScreen(),
  QuestionFeed(),
  AddPostScreen(),
  // Center(child: Text('Material')),
  Matirial(),
  Center(child: Text('profile')),
];

const questionAnswerItem = [

];