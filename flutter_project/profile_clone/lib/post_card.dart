import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

  get mobileBackgroundColor async => null;

  get vertical => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: Column(
        children: [
          Container(
            // color:mobileBackgroundColor,
            padding: EdgeInsets.only(left: 6,right: 6),
            margin: EdgeInsets.only(top: 10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --> User profile, username & icon.
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1677039460055-954e9054452b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=1000&q=60',
                      ),
                      radius: 25,
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John doe',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz,size: 30,),

                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Where can I take the Practice of DSA?",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black,fontSize: 20),),
                      Text("2 answers",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey,fontSize: 16),),
                    ],
                  ),
                ),

                const Divider(
                  height: 2,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.blue,
                )
              ]
            )
          ),
        ],
      ),
    );
  }

}

// padding({required EdgeInsets padding, required Column child}) {
// }