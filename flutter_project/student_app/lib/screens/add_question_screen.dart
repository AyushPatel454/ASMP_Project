// import 'dart:html';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../resources/storage_methods.dart';
import '../utils/utils.dart';

class QuestionForm extends StatefulWidget {
  const QuestionForm({Key? key}) : super(key: key);

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  final List<String> _questionTypes = ['General', 'CSE', 'MECH','ELECTRICAL'];
  String? _selectedQuestionType;
  String? _questionText = '';
  // File? _selectedImage;
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

  void postQuestion(String uid, String username, String profImage,
      String userfield, String userInstitue) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String photoUrl = '';
      if(_selectedImage != null) {
        photoUrl = await StorageMethods().uploadImageToStorage('question', _selectedImage!, true);
      }
      String res = await FirestoreMethods().uploadQuestion(
          _questionText!, // -> Pass Question
          _selectedQuestionType.toString(), // -> Pass Question type: CSE, MECH, ELECTRICAL
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
        showSnackBar('Question Posted!', context); // showing that the image is posted!!
        clearImage(); // remove select image from screen,
        setState(() {
          _questionText = '';
        });
        // setState(() {
        //  _selectedQuestionType = '';
        // });
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(
            res, context); // showing that there is any error occured...!!
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
    _questionText;
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context)
        .getUser; // --> Get current user details

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upload your question here.'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --> Dropdown menu
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Question Type'),
                value: _selectedQuestionType,
                items: _questionTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  setState(() {
                    _selectedQuestionType = selectedValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a question type';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16.0),

              // --> Write Question here
              TextFormField(
                // controller: _questionController,
                decoration: InputDecoration(
                  labelText: 'Question',
                  hintText: 'Write your question here',
                  border: OutlineInputBorder(),
                ),
                minLines: 2,
                maxLines: null,
                onChanged: (text) {
                  setState(() {
                    _questionText = text;
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
                }, icon: Icon(Icons.clear), label: Text('Remove image'),),
              ],

              SizedBox(height: 16.0),

              // --> Submit question
              ElevatedButton(
                onPressed: () => postQuestion(
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
    );
  }
}
