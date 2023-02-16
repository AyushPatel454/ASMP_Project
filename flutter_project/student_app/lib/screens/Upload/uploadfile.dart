import 'package:flutter/material.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class UPLOAD extends StatefulWidget {
  const UPLOAD({Key? key}) : super(key: key);

  @override
  State<UPLOAD> createState() => _UPLOADState();
}

class _UPLOADState extends State<UPLOAD> {
  @override
  Widget build(BuildContext context) {
    var submitTextStyle = TextStyle(
        fontSize: 28,
        letterSpacing: 5,
        color: Colors.white,
        fontWeight: FontWeight.w300);
    return Scaffold(
      appBar: AppBar(
        title: Text('UPLOAD'),
      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),

            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'What You Want to Upload ?',
                  textStyle: const TextStyle(
                    fontSize: 25.0,
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



            SizedBox(height: 50,),
            Flat3dButton.text(
              onPressed: () => print('clicked'),
              text: 'Normal Post',
              color: Colors.cyan,

            ),

            SizedBox(height: 50,),

            Flat3dButton.text(
              onPressed: () => print('clicked'),
              text: 'Upload Matirial',

              color: Colors.deepOrange,
            ),


          ],
        ),
      ),
    );
  }
}
