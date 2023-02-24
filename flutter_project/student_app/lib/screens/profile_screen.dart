import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../resources/auth_methods.dart';
import '../utils/utils.dart';
import 'list_of_answer.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String? uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  var userQuestions = {};
  int postLen = 0;
  int question = 0;
  int answers = 0;
  // bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid) // widget.uid -> is passs uid in String
          .get();

      // --> Getting post length.
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid',
              isEqualTo: widget
                  .uid) // --> else: FirebaseAuth.instance.currentUser!.uid
          .get(); // take snap of current user posts.
      postLen = postSnap.docs.length;
      userData = userSnap.data()!;

      var questionsSnap = await FirebaseFirestore.instance
          .collection('questions')
          .doc(widget.uid) // widget.uid -> is passs uid in String
          .get();
      // --> Getting Question length.
      var queLenSnap = await FirebaseFirestore.instance
          .collection('questions')
          .where('uid',
              isEqualTo: widget
                  .uid) // --> else: FirebaseAuth.instance.currentUser!.uid
          .get(); // take snap of current user questions.
      question = queLenSnap.docs.length;
      // userQuestions = questionsSnap.data()!;
      // followers = userSnap.data()!['followers'].length;
      // following = userSnap.data()!['following'].length;
      // isFollowing = userSnap
      //     .data()!['followers']
      //     .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  // Add a GlobalKey to the StatefulWidget
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : DefaultTabController(
            length: 4,
            child: Scaffold(
              // --> Creating app bar. (In which username show & our app bar backgroround color is now black.)
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(userData['username']),
                centerTitle: false,
              ),

              // --> Creating body part in which all user details are show. ()
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16), // add padding .
                    child: Column(
                      children: [
                        // --> Create Row beacase we want to see user profile photo and her total number of post, followers & following in Samer row.
                        Row(
                          children: [
                            // --> Create rounded profile photo
                            CircleAvatar(
                              // backgroundColor: Colors.grey,
                              // -> Right now we take image link from google to display image
                              backgroundImage: NetworkImage(
                                userData['photoUrl'],
                              ),
                              radius: 40,
                            ),
                            // --> for total no of post, folowers, following
                            Expanded(
                              // for spacing
                              flex: 1, // display with spacing perfectly.
                              child: Column(
                                children: [
                                  // --> Display total numners of post, followers, following
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // for display collum wise total post, follower count, following count
                                      buildStateColumn(postLen,
                                          "posts"), // calling buildStateColume...
                                      buildStateColumn(
                                          question, "Quetions"), // calling...
                                      buildStateColumn(
                                          190, "Answers"), // calling...
                                    ],
                                  ),

                                  // --> your text button
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // FollowButton(backgroundColor: mobileBackgroundColor, borderColor: Colors.grey, text: 'Edit a profile', textColor: primaryColor, function: () {},),
                                      Container(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: FirebaseAuth.instance
                                                      .currentUser!.uid ==
                                                  widget.uid
                                              ? TextButton(
                                                  onPressed: () async {
                                                    await AuthMethods().signOut();
                                                    Navigator.of(context) // --> Now take user to login screen.
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                        const LoginScreen(),
                                                      ),
                                                    );
                                                  }, // nothing
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        border: Border.all(
                                                          color: Colors.black,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Sign out",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    width: 230,
                                                    height: 27,
                                                  ),
                                                )
                                              : TextButton(
                                                  onPressed: () {}, // nothing
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        border: Border.all(
                                                          color: Colors.black,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Ask Question",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    width: 230,
                                                    height: 27,
                                                  ),
                                                ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // -> Description
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            userData['username'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // --> Display Bio
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 1),
                          child: Text(
                            userData['field'] + '-' + userData['institue'],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 2,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.blue,
                  ),
                  TabBar(
                    tabs: [
                      Tab(text: 'Questions', icon: Icon(Icons.edit)),
                      Tab(
                        text: 'Answers',
                        icon: Icon(Icons.question_answer_outlined),
                      ),
                      Tab(
                        text: 'Posts',
                        icon: Icon(Icons.grid_view_outlined),
                      ),
                      Tab(text: 'Tab 4'),
                    ],
                    indicatorColor:
                        Colors.lightBlueAccent, // Set the background color
                    labelColor: Colors.blue, // Set the text color
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
                      child: TabBarView(
                        children: [
                          // Center(child: Text('Tab 1 Content')),

                          // --> Tab 1
                          FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('questions')
                                .where('uid', isEqualTo: widget.uid)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  DocumentSnapshot snap =
                                      (snapshot.data! as dynamic).docs[index];

                                  return Padding(
                                    padding: EdgeInsets.only(left: 4, right: 8),
                                    child: GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ListOfAnswer(snap: snap),
                                        ),
                                      ),
                                      child: Container(
                                        // width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(bottom: 8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.cyanAccent
                                                  .withOpacity(0.3),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // --> Display Question.
                                            Container(
                                              margin: EdgeInsets.only(top: 8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: RichText(
                                                        text: TextSpan(
                                                      text:
                                                          'Question: (${snap['questionType']})',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  ),
                                                  Container(
                                                    child: RichText(
                                                        text: TextSpan(
                                                      // text: 'This is my Question.',
                                                      text:
                                                          '${snap['question']}',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // --> Display total numbers of answers.
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  DefaultTextStyle(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                          // subtitle2 --> titleSmall
                                                          fontWeight:
                                                              FontWeight.w800,
                                                        ),
                                                    child: Text(
                                                      '1,231 Answers',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium, // bodyText2 --> bodyMedium
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // --> Ceate button for show answers.
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ListOfAnswer(
                                                      snap:
                                                          snap, // --> Pass current post data. (which is we get from firebase database.)
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons
                                                        .question_answer_outlined),
                                                    SizedBox(width: 8),
                                                    Text('See Answers'),
                                                  ],
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .blue, // Set the background color
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // ),
                                      ),
                                    ),
                                  );
                                },
                                shrinkWrap: true,
                                itemCount:
                                    (snapshot.data! as dynamic).docs.length,
                              );
                            },
                          ),
                          // --> Tab2
                          Center(child: Text('Tab 2 Content')),
                          // --> Tab2
                          FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('posts')
                                .where('uid', isEqualTo: widget.uid)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return GridView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      (snapshot.data! as dynamic).docs.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        3, // -> In one row 3 post are seen.
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 1.5,
                                    childAspectRatio: 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot snap =
                                        (snapshot.data! as dynamic).docs[index];

                                    return Container(
                                      child: Image(
                                        image: NetworkImage(snap['postUrl']),
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  });
                            },
                          ),
                          //     ],
                          //   ),
                          // ),
                          // Center(child: Text('Tab 3 Content')),
                          Center(child: Text('Tab 4 Content')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
    const Divider(
      height: 2,
      thickness: 1,
      indent: 0,
      endIndent: 0,
      color: Colors.blue,
    );
  }

  // --> Simple widget which is use for display total post, following, follwers.
  Column buildStateColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
