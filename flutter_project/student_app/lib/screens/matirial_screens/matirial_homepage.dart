import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_app/screens/matirial_screens/screen/CSE/cse.dart';
import 'package:student_app/widgets/field_card.dart';

class Matirial extends StatefulWidget {
  const Matirial({Key? key}) : super(key: key);

  @override
  State<Matirial> createState() => _MatirialState();
}

class _MatirialState extends State<Matirial> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Material'),
      ),

      body:Center(
        child: Column(

          children: <Widget>[
            SizedBox(height: 30,),
            Text('Material',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.deepOrange,
              ),
            ),
            SizedBox(height: 10,),

            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'What branch Matirial You Want ?',
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],

              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 100),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),

            // SizedBox(height: 50,),
            //
            // ElevatedButton( child: Text('Computer Science And Engineering '),
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
            //       MaterialPageRoute(builder: (context) => Cse_page()),
            //     );
            //   },
            //
            // ),
            //
            // SizedBox(height: 30,),
            //
            // ElevatedButton(child: Text('Mechanical Engineering'),
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
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => Mech()),
            //     // );
            //   },
            // ),
            //
            // SizedBox(height: 30,),
            //
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
            //
            //
            //   ),
            //   onPressed:(){
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => elec()),
            //     // );
            //   },
            //   child: Text('Electrical Engineering'),
            // ),

            StreamBuilder(
              // StreamBuilder() --> read real time stuff
                stream: FirebaseFirestore.instance.collection('fields').snapshots(), // --> Orderby: for filtering. on based on date published. descending: true -> newest post shown top.
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
                    itemBuilder: (context, index) => FieldCard(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}


