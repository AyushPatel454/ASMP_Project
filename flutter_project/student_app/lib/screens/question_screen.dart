import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/question_card.dart';
import 'add_question_screen.dart';

class QuestionFeed extends StatefulWidget {
  const QuestionFeed({Key? key}) : super(key: key);

  @override
  State<QuestionFeed> createState() => _QuestionFeedState();
}

class _QuestionFeedState extends State<QuestionFeed>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Q/A'),
        bottom: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: Colors.lightBlueAccent,
          ),
          tabs: [
            Tab(
              child: Text(
                'Questions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Tab(
              child: Text(
                'Requests',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QuestionForm(),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 8),
                          Text('Ask your question?'),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blue, // Set the background color
                      ),
                    ),
                  ),
                  Center(
                    // child:  QuestionCard(),
                    // child: Scrollbar(
                    //   controller: _scrollController,
                    //   thumbVisibility: true,
                    //   child: ListView.builder(controller: _scrollController, shrinkWrap: true, itemCount: 4,itemBuilder: (context,index) => const QuestionCard()),
                    // ),

                    // --> Add scroll bar in card also
                    child: Scrollbar(
                        controller: _scrollController,
                        thumbVisibility: true,
                        child: StreamBuilder(
                            // StreamBuilder() --> read real time stuff
                            stream: FirebaseFirestore.instance
                                .collection('questions')
                                .orderBy('datePublished', descending: true)
                                .snapshots(), // --> Orderby: for filtering. on based on date published. descending: true -> newest post shown top.
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true, // --> Important for scrolling
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) => QuestionCard(
                                  snap: snapshot.data!.docs[index].data(),
                                  index: index,
                                ),
                              );
                            })),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Text('Tab 2 content'),
          ),
        ],
      ),
    );
  }
}
