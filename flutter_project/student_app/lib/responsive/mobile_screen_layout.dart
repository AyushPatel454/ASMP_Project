import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/models/user.dart' as model;
import 'package:student_app/utils/global_variables.dart';
import '../providers/user_provider.dart';
import '../utils/colors.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page =
      0; // for whcih icon is selected right now. // 0 --> Home , 1 --> QA , 2 --> Create new post, 3 --> Material, 4 --> profile
  late PageController pageController; // adding page controller

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page); // for jumnp to page
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItem,
        physics:
            const NeverScrollableScrollPhysics(), // by default right - left scroll karie to alag page per jay sakta hat. But apne evu nai karva mangta etla mate --> NeverScrollableScrollPhysics() no user karyo.
        controller: pageController,
        onPageChanged: onPageChanged, // call onPageChanged()
      ),
      bottomNavigationBar: CupertinoTabBar(
        height: 58,
        backgroundColor: Colors.white38,
        border: Border(
          top: BorderSide(color: Colors.blue),
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? Colors.blue : secondaryColor,
            ),
            label: 'Home',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.question_answer,
              color: _page == 1 ? Colors.blue : secondaryColor,
            ),
            label: 'Q/A',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: _page == 2 ? Colors.blue : secondaryColor,
            ),
            label: 'Upload',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book_outlined,
              color: _page == 3 ? Colors.blue : secondaryColor,
            ),
            label: 'Material',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? Colors.blue : secondaryColor,
            ),
            label: 'Profile',
            backgroundColor: primaryColor,
          ),
        ],
        onTap:
            navigationTapped, // call naviagationTapped() --> for change _page value. so we can make that icon color white.
      ),
    );
  }
}
