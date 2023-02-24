import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({Key? key, required this.snap}) : super(key: key);


  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      child: Row(
        children: [
          // --> for comment posted user profile photo.
          CircleAvatar(
            backgroundImage: NetworkImage(
            widget.snap['profilePic']),
            radius: 18,
          ),

          // --> for username & comment.
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.snap['name']}',
                          style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '\t${widget.snap['text']}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),

                  // --> for date of comment.
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4,
                    ),
                    child: Text(
                      'CSE\n' + DateFormat.yMMMd().format( // --> showing date in format. like: Feb 6, 2023
                          widget.snap['datePublished'].toDate()
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --> Display Like option
          Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.favorite, size: 16,)
          ),
        ],
      ),
    );
  }
}