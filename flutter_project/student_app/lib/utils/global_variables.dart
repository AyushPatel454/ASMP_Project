import 'package:flutter/material.dart';
import 'package:student_app/screens/Upload/qa/Quea_nns.dart';
import 'package:student_app/screens/Upload/uploadfile.dart';
import '../screens/matirial_screens/matirial_homepage.dart';

const webScreenSize = 600;

const homeScreenItem = [
  Center(child: Text('feed')),
  Q_A(),
  UPLOAD(),
  Matirial(),
  Center(child: Text('profile')),
];