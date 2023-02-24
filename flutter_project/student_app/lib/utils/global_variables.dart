import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/matirial_screens/matirial_homepage.dart';
import '../screens/profile_screen.dart';
import '../screens/question_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItem = [
  const FeedScreen(),
  const QuestionFeed(),
  const AddPostScreen(),
  // Center(child: Text('Material')),
  const Matirial(),
  // Center(child: Text('profile')),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
];

const questionAnswerItem = [

];