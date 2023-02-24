import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../resources/storage_methods.dart';
import '../utils/utils.dart';

class UploadAnswer extends StatefulWidget {
  final snap;
  const UploadAnswer({Key? key,required this.snap}) : super(key: key);

  @override
  State<UploadAnswer> createState() => _UploadAnswerState();
}

class _UploadAnswerState extends State<UploadAnswer> {
  final _answerController = TextEditingController();
  String? _answerText = '';
  Uint8List? _selectedImage;

  bool _isLoading = false;
  // TextEditingController _questionController = TextEditingController();

  // final _formKey = GlobalKey<FormState>();

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    // final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    Uint8List pickedFile = await pickImage(ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        // _selectedImage = File(pickedFile.path);
        _selectedImage = pickedFile;
      });
    }
  }

  void postAnswer(String uid, String username, String profImage,
      String userfield, String userInstitue) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String photoUrl = '';
      if(_selectedImage != null) {
        photoUrl = await StorageMethods().uploadImageToStorage('answers', _selectedImage!, true);
      }
      String res = await FirestoreMethods().uploadAnswer(
        widget.snap['questionId'], // --> Pass question Id
          _answerText!, // -> Pass Answer
          // _selectedImage! as Uint8List, // -> Pass Selected Image
          photoUrl, // -> Pass Selected Image
          uid,
          username,
          profImage,
          userfield,
          userInstitue);

      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        print(res);
        showSnackBar('Answer Posted!!', context); // showing that the image is posted!!
        clearImage(); // remove select image from screen,
        setState(() {
          _answerText = '';
        });
        // setState(() {
        //  _selectedQuestionType = '';
        // });
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context); // showing that there is any error occured...!!
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
      print(e.toString());
    }
  }

  // --> After image successfully upload. remove from code memory _file. & show screen.
  void clearImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _answerController.dispose();
    _answerText;
  }

  @override
  Widget build(BuildContext context) {
    // --> Get current user data.
    final User user = Provider.of<UserProvider>(context).getUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Answer',
      home: Scaffold(
        // --> App Bar
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // --> Remove bottom shadow

          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
            color: Colors.blueAccent,
            iconSize: 35,
          ),

          title: Text('Answer', style: TextStyle(color: Colors.blueAccent),),

          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 8,bottom: 8),
              margin: EdgeInsets.only(right: 10),

              // --> Post Answer Button
              child: ElevatedButton(
                onPressed: () => postAnswer(
                  user.uid,
                  user.username,
                  user.photoUrl,
                  user.field, // pass field of user
                  user.institue, // pass student institute
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Set the background color
                  shadowColor: Colors.green ,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(100, 30),
                ),
                child: _isLoading ? const CircularProgressIndicator() : Text('Answer', style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
              ),
            ),
          ],
        ),

        body: Padding(
          padding: EdgeInsets.only(left: 8,top: 8,right: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --> Showing profile photo & username, field name
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --> Display profile image
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        user.photoUrl,
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
                              user.username,
                              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                            ),
                            Text(
                              user.field,
                              style: TextStyle(fontSize: 20,),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),

                // --> Showing Question & Image if exist
                Container(
                  margin: EdgeInsets.only(top: 6, bottom: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --> Showing question
                      RichText(
                        text: TextSpan(
                          // text: 'This is my Question.',
                          text: '${widget.snap['question']}',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),

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
                  color: Colors.blue,
                ),

                SizedBox(height: 10,),

                // --> Write your answer here.
                TextFormField(
                  controller: _answerController,
                  decoration: InputDecoration(
                    labelText: 'Answer',
                    hintText: 'Write your Answer here',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  minLines: 1,
                  maxLines: null,
                  onChanged: (text) {
                    setState(() {
                      _answerText = text;
                    });
                  },
                ),

                SizedBox(height: 16.0),

                // --> Select image
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.image),
                  label: Text('Select Image'),
                ),
                if (_selectedImage != null) ...[
                  SizedBox(height: 16.0),
                  // Image.file(_selectedImage!),
                  Image.memory(_selectedImage!),
                  ElevatedButton.icon(onPressed: () {
                    setState(() {
                      _selectedImage = null;
                    });
                  }, icon: Icon(Icons.clear), label: Text('Remove image'),),],

                  SizedBox(height: 16.0),

                  // --> Submit answer
                  ElevatedButton(
                    onPressed: () => postAnswer(
                      user.uid,
                      user.username,
                      user.photoUrl,
                      user.field, // pass field of user
                      user.institue, // pass student institute
                    ),
                    child: _isLoading ? const LinearProgressIndicator() : Text('Submit'),
                  ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
