import 'package:flutter/material.dart';

import '../screens/add_post_screen.dart';

const webScreenSize = 600;

const homeScreenItem = [
  Center(child: Text('feed')),
  Center(child: Text('Q/A')),
  AddPostScreen(),
  Center(child: Text('Upload new post')),
  Center(child: Text('profile')),
];