import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../screens/comment_screen_post.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import 'like_animation.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    getComments(); // for get total comments of post.
  }

  // --> For find total comments post.
  void getComments() async {
    try {
      // -> going to in comments collection.
      QuerySnapshot snap = await FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments').get();
      commentLen = snap.docs.length; // -> take total of docs in comments collection
    } catch(e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context)
        .getUser; // -> get user id. from UserProvider class
    return Container(
      // color: Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: 3,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                // --> Display profile image
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    widget.snap[
                        'profImage'], // take profile image url from Firestore Database docs --> Posts docs.
                  ),
                ),

                // --> Display user name. after profile photo
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.snap[
                                  'username'], // take username from Firestore Database docs --> Posts docs.
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.snap['field'],
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // --> 3 dot button
                IconButton(
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
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),

          // -> Description
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
            //     .copyWith(right: 0),
            // margin: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              '${widget.snap['description']}',
              style: TextStyle(
                color: Colors.black,
              ),
              // child: RichText(
              //   // this is like row widgets text
              //   text: TextSpan(
              //     style: const TextStyle(color: primaryColor),
              //     children: [
              //       TextSpan(
              //           text: ' ${snap['description']}',  // take description from Firestore Database docs --> Posts docs.
              //           style: TextStyle(color: Colors.black)
              //       ),
              //     ],
              //   ),
            ),
          ),

          // --> Image Section
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethods().likePost(
                  widget.snap['postId'], user.uid, widget.snap['likes']);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.35,
                  // width: double.infinity,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 16)
                            .copyWith(right: 0),
                    // margin: EdgeInsets.only(left: 8, right: 8),
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.snap[
                                'postUrl'], // take post image url from Firestore Database docs --> Posts docs.
                          ),
                          fit: BoxFit.fill,
                        ),
                        border: Border.all(width: 5, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),

                  // child: Image.network(
                  //   'https://images.unsplash.com/photo-1602522946658-9b9c3807213e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1174&q=80',
                  //   fit: BoxFit.cover,
                  // ),
                ),
                AnimatedOpacity(
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    child: const Icon(
                      Icons.thumb_up,
                      color: Colors.white,
                      size: 120,
                    ),
                    isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),

          // --> Like, comment section
          Row(
            children: [
              // like button
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                child: IconButton(
                  onPressed: () async {
                    await FirestoreMethods().likePost(
                        widget.snap['postId'], user.uid, widget.snap['likes']);
                  },
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon( // If user already liked than show like button in red fill.
                    Icons.thumb_up,
                    color: Colors.blue,
                  )
                      : const Icon(Icons.thumb_up_alt_outlined),
                ),
              ),
              // --> comment button
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      snap: widget.snap,
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.comment_outlined,
                ),
              ),
              // send button
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(
              //     Icons.send,
              //   ),
              // ),
              // -> Bookmark button --> Right hand side
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),

          // --> Number of likes, comment & Date posted.
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            // padding: const EdgeInsets.symmetric(
            //   horizontal: 0,
            // ),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -> Number of likes
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        // subtitle2 --> titleSmall
                        fontWeight: FontWeight.w800,
                      ),
                  child: Text(
                    '${widget.snap['likes'].length} likes',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium, // bodyText2 --> bodyMedium
                  ),
                ),

                // --> Show number of comments
                InkWell(
                  onTap: () {}, // redirect to comment screen.
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    child: Text(
                      'View all ${commentLen} comments',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                // --> Show date
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  child: Text(
                    // -> Formate date. --> yMMMd -> year Month Moth date
                    DateFormat.yMMMd().format(
                      widget.snap['datePublished']
                          .toDate(), // take datePublished from Firestore Database docs --> Posts docs. & format it in Month day, year. (uing dependency -> intl)
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // -> Divider
          Divider(height: 2,
            thickness: 2,
            indent: 0,
            endIndent: 0,
            color: Colors.blue,)
        ],
      ),
    );
  }
}
