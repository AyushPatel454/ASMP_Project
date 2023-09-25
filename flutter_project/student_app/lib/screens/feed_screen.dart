import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: primaryColor,
        //   centerTitle: false,
        //   // title: SvgPicture.asset(
        //   //   'assets/ic_instagram.svg',
        //   //   color: primaryColor,
        //   //   height: 32,
        //   // ),
        //   actions: [
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.messenger_outline,
        //       ),
        //     ),
        //   ],
        // ),

        body: StreamBuilder(
            // StreamBuilder() --> read real time stuff
            stream: FirebaseFirestore.instance.collection('posts').orderBy('datePublished', descending: true).snapshots(), // --> Orderby: for filtering. on based on date published. descending: true -> newest post shown top.
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              );
            }
            )
    );
  }
}
