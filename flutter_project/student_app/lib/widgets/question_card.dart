import 'package:flutter/material.dart';
import 'package:student_app/screens/list_of_answer.dart';

class QuestionCard extends StatefulWidget {
  final snap;
  const QuestionCard({Key? key, required this.snap}) : super(key: key);
  // const QuestionCard({Key? key}) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListOfAnswer(
          snap: widget.snap, // --> Pass current post data. (which is we get from firebase database.)
        ),
      ),
    ),
      child: Container(
        // width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
              //     .copyWith(right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --> Display profile image
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      widget.snap['profImage'],
                      // 'https://images.unsplash.com/photo-1676919396292-04d75e0e5681?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60'
                    ),
                  ),

                  // --> Display user name. after profile photo
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
            ),

            // --> Display Question.
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: RichText(
                        text: TextSpan(
                      text: 'Question: (${widget.snap['questionType']})',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                  Container(
                    child: RichText(
                        text: TextSpan(
                      // text: 'This is my Question.',
                      text: '${widget.snap['question']}',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ],
              ),
            ),

            // --> Display total numbers of answers.
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          // subtitle2 --> titleSmall
                          fontWeight: FontWeight.w800,
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
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListOfAnswer(
                      snap: widget.snap, // --> Pass current post data. (which is we get from firebase database.)
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.question_answer_outlined),
                    SizedBox(width: 8),
                    Text('See Answers'),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Set the background color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
