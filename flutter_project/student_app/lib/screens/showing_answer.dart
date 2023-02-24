import 'package:flutter/material.dart';

class ShowingAnswer extends StatefulWidget {
  final snap;
  const ShowingAnswer({Key? key, required this.snap,}) : super(key: key);

  @override
  State<ShowingAnswer> createState() => _ShowingAnswerState();
}

class _ShowingAnswerState extends State<ShowingAnswer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.snap['username']}\'s Answer'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(left: 10, top: 30, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --> Showing profile photo & username, field name
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // --> Display profile image
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        widget.snap['profImage'],
                        // 'https://images.unsplash.com/photo-1676663902203-58f0b60b783e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
                      ),
                    ),

                    // --> Display user name. after profile photo
                    Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              // 'Username',
                              widget.snap['username'],
                              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                            ),
                            Text(
                              // 'CSE',
                              widget.snap['field'],
                              style: TextStyle(fontSize: 20,),
                            ),
                          ],
                        ),
                      ),

                    // --> 3 dot button
                    // IconButton(
                    //   icon: const Icon(Icons.more_vert),
                    //   iconSize: 30,
                    //   color: Colors.blueGrey,
                    //   onPressed: () {
                    //     showDialog(
                    //         context: context,
                    //         builder: (context) => Dialog(
                    //           child: ListView(
                    //               padding: const EdgeInsets.symmetric(
                    //                 vertical: 16,
                    //               ),
                    //               shrinkWrap: true,
                    //               children: [
                    //                 'Report',
                    //               ]
                    //                   .map(
                    //                     (e) => InkWell(
                    //                   onTap: () {},
                    //                   child: Container(
                    //                     padding: const EdgeInsets.symmetric(
                    //                       vertical: 12,
                    //                       horizontal: 16,
                    //                     ),
                    //                     child: Text(e),
                    //                   ),
                    //                 ),
                    //               )
                    //                   .toList()),
                    //         ));
                    //   },
                    // ),
                  ],
                ),
              ),

              // --> Divder line
              const Divider(height: 2,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),

              // --> Display Answer.
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: RichText(
                          text: TextSpan(
                            // text: 'This is my Answer.',
                            text: '${widget.snap['answer']}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,),
                          )),
                    ),
                  ],
                ),
              ),

              // --> Showing Question & Image if exist
              Container(
                margin: EdgeInsets.only(top: 6, bottom: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --> Showing question
                    // RichText(
                    //   text: TextSpan(
                    //     // text: 'This is my Question.',
                    //     text: '${widget.snap['question']}',
                    //     style: const TextStyle(
                    //         fontSize: 20,
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.w500),
                    //   ),
                    // ),

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
                color: Colors.grey,
              ),

              // --> Like, comment section
              Row(
                children: [
                  // like button
                  // LikeAnimation(
                  //   isAnimating: widget.snap['likes'].contains(user.uid),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon( // If user already liked than show like button in red fill.
                      Icons.thumb_up,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon( // If user already liked than show like button in red fill.
                      Icons.thumb_down_alt_outlined,
                      color: Colors.blue,
                    ),
                  ),
                  // --> comment button
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.comment_outlined,
                    ),
                  ),
                  // -> Bookmark button --> Right hand side
                ],
              ),

              // --> Divder line
              const Divider(height: 2,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
