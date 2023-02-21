import 'package:flutter/material.dart';

import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/question_screen.dart';

const webScreenSize = 600;

const homeScreenItem = [
  FeedScreen(),
  QuestionFeed(),
  AddPostScreen(),
  Center(child: Text('Material')),
  Center(child: Text('profile')),
];

const questionAnswerItem = [

];