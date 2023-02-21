import 'package:flutter/material.dart';

class AnswerCard extends StatefulWidget {
  const AnswerCard({Key? key}) : super(key: key);

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                'https://images.unsplash.com/photo-1676663902203-58f0b60b783e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
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
                      'Username',
                      // widget.snap['username'],
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'CSE',
                      // widget.snap['field'],
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
      ],
    );
  }
}
