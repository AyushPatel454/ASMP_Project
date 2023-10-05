import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_app/screens/matirial_screens/screen/CSE/Computer_network/cn.dart';
import 'package:student_app/widgets/subject_card.dart';

import '../../widgets/field_card.dart';

class SubjectScreen extends StatefulWidget {
  final snap;
  const SubjectScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.snap['fieldName']}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Select The Subject ?',
                    textStyle: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 2,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),

              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Scrollbar(
                  controller: _scrollController,
                  child: StreamBuilder(
                      // StreamBuilder() --> read real time stuff
                      stream: FirebaseFirestore.instance
                          .collection('fields')
                          .doc(widget.snap['fieldID'])
                          .collection('Subjects')
                          .snapshots(), // --> Orderby: for filtering. on based on date published. descending: true -> newest post shown top.
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
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
                          itemBuilder: (context, index) => SubjectCard(
                            snap: snapshot.data!.docs[index].data(),
                            fieldId: widget.snap['fieldID'],
                          ),
                        );
                      }),
                ),
              ),
              // CN(),

              // SizedBox(height: 30,),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.black,
              //     foregroundColor: Colors.white,
              //     shadowColor: Colors.green,
              //     elevation: 5,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     minimumSize: Size(300, 36),
              //   ),
              //   onPressed:(){
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => CN()),
              //     );
              //   },
              //   child: Text('Computer Network'),
              // ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.black,
              //     foregroundColor: Colors.white,
              //     shadowColor: Colors.green,
              //     elevation: 5,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     minimumSize: Size(300, 36),
              //   ),
              //   onPressed:(){
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => OS()),
              //     );
              //   },
              //   child: Text('Operating System'),
              // ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.black,
              //     foregroundColor: Colors.white,
              //     shadowColor: Colors.green,
              //     elevation: 5,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     minimumSize: Size(300, 36),
              //   ),
              //   onPressed: () {} ,
              //   child: Text('Mobile App Devlopment'),
              // ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.black,
              //     foregroundColor: Colors.white,
              //     shadowColor: Colors.green,
              //     elevation: 5,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     minimumSize: Size(300, 36),
              //   ),
              //   onPressed: () {} ,
              //   child: Text('Web Devlopment'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
