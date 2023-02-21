import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/screens/add_answer_screen.dart';
import 'package:student_app/widgets/answer_card.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';

class ListOfAnswer extends StatefulWidget {
  final snap;
  const ListOfAnswer({Key? key, required this.snap}) : super(key: key);

  @override
  State<ListOfAnswer> createState() => _ListOfAnswerState();
}

class _ListOfAnswerState extends State<ListOfAnswer> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // --> Get current user data.
    final User user = Provider.of<UserProvider>(context).getUser;
    print('${widget.snap['postUrl']}\npostUrl!=null: ${widget.snap['postUrl'] != ""}');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Question'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(top: 10,left: 10,right: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --> Showing profile photo & username, field name
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --> Display profile image
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      widget.snap['profImage'],
                    ),
                  ),

                  // --> Display user name. after profile photo
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            // 'Username',
                            widget.snap['username'],
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            // 'CSE',
                            widget.snap['field'],
                            style: TextStyle(fontSize: 16,),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --> 3 dot button
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    iconSize: 30,
                    color: Colors.blueGrey,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: ListView(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shrinkWrap: true,
                                children: [
                                  'Report',
                                ]
                                    .map(
                                      (e) => InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      child: Text(e),
                                    ),
                                  ),
                                )
                                    .toList()),
                          ));
                    },
                  ),
                ],
              ),

              // --> Showing Question & Image if exist
              Container(
                margin: EdgeInsets.only(top: 6, bottom: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --> Showing question
                    RichText(
                        text: TextSpan(
                          // text: 'This is my Question.',
                          text: '${widget.snap['question']}',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                    ),

                    // --> If question has image then display image. Otherwise not display
                    Visibility(
                      visible: widget.snap['postUrl'] != "", // if is true then image visisble. Otherwise not visible any thing.
                      child: Image.network(
                        '${widget.snap['postUrl']}',
                        // widget.snap['postUrl'],
                        fit: BoxFit.cover,
                        // height: double.infinity,
                        width: double.infinity,
                        // height: 200,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // --> Divder line
              const Divider(height: 2,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Colors.blue,
              ),

              // --> Current user profile photo , & Answer Button
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // --> Current user photo
                    Container(
                      margin: EdgeInsets.only(top: 10,bottom: 10),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(user.photoUrl),
                      ),
                    ),

                    // --> Can you answer this question?
                    Text('${user.username}, can you answer this question?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                    // --> Answer Button
                    Container(
                      margin: EdgeInsets.only(top: 10,bottom: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => UploadAnswer(
                              snap: widget.snap,
                            ),),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.question_answer_outlined),
                              SizedBox(width: 8),
                              Text('Answer', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                            ],
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder> (
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(width: 1.5,color: Colors.blueAccent)
                              )
                            ),
                          ),
                        ),
                      ),
                    ),

                    // --> Other Answers
                  ],
                ),
              ),

              // --> Divder line
              const Divider(height: 2,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Colors.blue,
              ),

              // --> Display other answers.
              Column(
                children: [
                  Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: StreamBuilder(
                        // StreamBuilder() --> read real time stuff
                          stream: FirebaseFirestore.instance.collection('questions').doc(widget.snap['questionId']).collection('answers').orderBy('datePublished', descending: true).snapshots(), // --> Orderby: for filtering. on based on date published. descending: true -> newest post shown top.
                          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true, // --> Important for scrolling
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) => AnswerCard(
                                snap: snapshot.data!.docs[index].data(),
                              ),
                            );
                          }
                      )
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
