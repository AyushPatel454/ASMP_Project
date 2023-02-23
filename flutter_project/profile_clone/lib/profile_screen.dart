import 'package:flutter/material.dart';
import 'package:profile_clone/tab_example.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // --> Creating app bar. (In which username show & our app bar backgroround color is now black.)
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('John Doe'),
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
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        // -> Right now we take image link from google to display image
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1677039460055-954e9054452b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=1000&q=60',
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // for display collum wise total post, follower count, following count
                                buildStateColumn(
                                    20, "posts"), // calling buildStateColume...
                                buildStateColumn(150, "Quetions"), // calling...
                                buildStateColumn(190, "Answers"), // calling...
                              ],
                            ),

                            // --> your text button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // FollowButton(backgroundColor: mobileBackgroundColor, borderColor: Colors.grey, text: 'Edit a profile', textColor: primaryColor, function: () {},),
                                Container(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: TextButton(
                                      onPressed: () {}, // nothing
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Edit profile",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        width: 250,
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
                      'john doe',
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
                      'Some description',
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
                Tab(text: 'Tab 1',icon: Icon(Icons.question_mark)),
                Tab(text: 'Tab 2',icon: Icon(Icons.question_answer_outlined),),
                Tab(text: 'Tab 3'),
                Tab(text: 'Tab 4'),
              ],
              indicatorColor: Colors.lightBlueAccent, // Set the background color
              labelColor: Colors.blue, // Set the text color
            ),

            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('Tab 1 Content')),
                  Center(child: Text('Tab 2 Content')),
                  Center(child: Text('Tab 3 Content')),
                  Center(child: Text('Tab 4 Content')),
                ],
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
