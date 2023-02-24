import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../resources/storage_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class MaterialUpload extends StatefulWidget {
  const MaterialUpload({Key? key}) : super(key: key);

  @override
  _MaterialUploadState createState() => _MaterialUploadState();
}

class _MaterialUploadState extends State<MaterialUpload> {
  File? _pdfFile;
  String? title;
  String? fieldValue;
  String? subjectValue;
  String? materialTypeValue;

  String? fieldId;
  String? subjectId;

  List<String> fields = [];
  List<String> subjects = [];
  List<String> materialTypes = ['Book','Notes','Assignments'];

  bool _isLoading =
  false; // -> For show progress indicator when user click Upload button & Pdf is uploading (storing in DB Stroage & Firestore DB).

  // --> InitState() --> When this page is call then direct open File manger for select pdf file && Fields are fetch from fileds collection in firebase.
  @override
  void initState() {
    super.initState();
    _pickPDF();
    fetchFields();
  }

  // --> After Pdf successfully upload. remove from code memory _file. & show screen.
  void clearPdf() {
    setState(() {
      _pdfFile = null;
    });
  }

  // --> File pick from mobile storage
  void _pickPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    }
  }

  // --> Fetch Field's from fields collection in firebase.
  Future<void> fetchFields() async {
    final QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('fields').get();

    final List<DocumentSnapshot> documents = querySnapshot.docs;
    for (var document in documents) {
      final departmentName = document['fieldName'];
      fields.add(departmentName);
    }

    setState(() {
      // fieldValue = fields[0];
    });
  }

  // --> Fetch Selected Field's -> Subjects
  Future<void> fetchSubjects() async {
    final QuerySnapshot selectFieldSnapshot = await FirebaseFirestore.instance
        .collection('fields')
        .where('fieldName', isEqualTo: fieldValue)
        .get();

    final List<DocumentSnapshot> fieldDocument = selectFieldSnapshot.docs;
    for (var fieldDoc in fieldDocument) {
      String fId = fieldDoc['fieldID'];
      final QuerySnapshot subjectSnapshot =
      await fieldDoc.reference.collection('Subjects').get();

      final List<DocumentSnapshot> subjectDocuments = subjectSnapshot.docs;
      for (var document in subjectDocuments) {
        final subjectName = document['subjectName'];
        subjects.add(subjectName);
      }

      setState(() {
        // subjectValue = subjects[0];
        fieldId = fId; // stroing field id for fetch / update data in perticular document
      });
    }
  }

  // -> Fetch Subjec Id
  Future<void> findSubId() async {
    final QuerySnapshot selectFieldSnapshot = await FirebaseFirestore.instance
        .collection('fields')
        .doc(fieldId)
        .collection('Subjects')
        .where('subjectName', isEqualTo: subjectValue)
        .get();

    final List<DocumentSnapshot> fieldDocument = selectFieldSnapshot.docs;
    for (var fieldDoc in fieldDocument) {
      String sId = fieldDoc['subjectID'];

      setState(() {
        // subjectValue = subjects[0];
        subjectId = sId; // stroing field id for fetch / update data in perticular document
      });
    }
  }

  // --> Upload to Firebase storage & firebase database.
  void postPdf(String uid, String username, String profImage,
      String userfield, String userInstitue) async {
    setState(() {
      _isLoading = true;
    });
    try {
      // --> Upload in Firestore & get url of this file
      String fileUrl = await StorageMethods().uploadMaterialToStorage('materials', materialTypeValue!, _pdfFile!, true);
      print("File Url: "+fileUrl);

      String res = await FirestoreMethods().uploadPdf(
          fieldId!,
          subjectId!,
          title!,
          materialTypeValue!,
          fieldValue!,
          subjectValue!,
          fileUrl,
          uid,
          username,
          profImage,
          userfield,
          userInstitue);

      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted Material', context); // showing that the image is posted!!
        Navigator.pop(context);
        clearPdf(); // remove select pdf from screen,
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(
            res, context); // showing that there is any error occured...!!
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context)
        .getUser;

    if (fields.isEmpty) {
      return CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
           // -> Go to back screen
          onPressed: () {
            clearPdf();
            Navigator.pop(context);
          },
        ),
        title: const Text('Add Material'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () => postPdf(
              user.uid,
              user.username,
              user.photoUrl,
              user.field, // pass field of user
              user.institue, // pass student institute
            ),
            child: const Text(
              'Post',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Pdf view
              Container(
                color: Colors.grey,
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  height: 390,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: PDFView(
                    filePath: _pdfFile!.path,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: false,
                    defaultPage: 0,
                  ),
                ),
              ),

              // --> Remove Pdf
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _pdfFile = null;
                  });

                  Navigator.pop(context);
                },
                icon: Icon(Icons.clear), label: Text('Remove Selection'),
              ),

              // --> Title of pdf. Take input
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  // controller: _questionController,
                  decoration: InputDecoration(
                    labelText: 'Title of file',
                    hintText: 'Write only 2-3 words so user can understand.',
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  maxLines: 1,
                  onChanged: (text) {
                    setState(() {
                      title = text;
                    });
                  },
                ),
              ),

              // --> Select Field
              if(title!=null)
              DropdownButton<String>(
                hint: Text('Select Field'),
                value: fieldValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    fieldValue = newValue!;
                    subjectValue = null;
                    materialTypeValue = null;
                    subjects = [];
                    // fetchSubjects();
                  });
                  fetchSubjects();
                },
                items: fields.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                isExpanded: true,
                dropdownColor: Colors.white38.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                iconEnabledColor: Colors.blue,
              ),

              // --> Selected Field Subject
              if(fieldValue != null)
                DropdownButton<String>(
                  hint: Text('Select Subject'),
                  value: subjectValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      subjectValue = newValue!;
                      findSubId();
                    });
                  },
                  items: subjects.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  isExpanded: true,
                  dropdownColor: Colors.white38.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                  iconEnabledColor: Colors.blue,
                ),

              // --> Selected Material Type
              if(subjectValue != null)
                DropdownButton<String>(
                  hint: Text('Select type of material'),
                  value: materialTypeValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      materialTypeValue = newValue!;
                    });
                  },
                  items: materialTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  isExpanded: true,
                  dropdownColor: Colors.white38.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                  iconEnabledColor: Colors.blue,
                ),


              // if material != null then upload button shown
              if(materialTypeValue != null)
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => postPdf(
                      user.uid,
                      user.username,
                      user.photoUrl,
                      user.field, // pass field of user
                      user.institue, // pass student institute
                    ),
                    child: _isLoading ? LinearProgressIndicator() :  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_upload), // Add the icon here
                        SizedBox(width: 5), // Add some space between the icon and text
                        Text('Upload'), // Add the text here
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
