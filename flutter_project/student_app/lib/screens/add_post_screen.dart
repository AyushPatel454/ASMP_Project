import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file; // this can be nullable.
  TextEditingController _descriptionController = TextEditingController();
  // Display Linear Idicator --> For progress indicator.
  bool _isLoading =
      false; // -> For show progress indicator when user click Post button & image is uploading (storing in DB Stroage & Firestore DB).

  void postImage(String uid, String username, String profImage,
      String userfield, String userInstitue) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text,
          _file!,
          uid,
          username,
          profImage,
          userfield,
          userInstitue);

      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted!', context); // showing that the image is posted!!
        clearImage(); // remove select image from screen,
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(
            res, context); // showing that there is any error occured...!!
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            // --> There are many dialog box. Simple, alert and etc.
            title: const Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a phot'),
                onPressed: () async {
                  Navigator.of(context)
                      .pop(); // remove the widgets from the screen.
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from a gallery'),
                onPressed: () async {
                  Navigator.of(context)
                      .pop(); // remove the widgets from the screen.
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // remove the widgets from the screen.
                },
              ),
            ],
          );
        });
  }

  // --> After image successfully upload. remove from code memory _file. & show screen.
  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  // --> For Pdf Selection & methods
  File? _pdfFile;

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

  // --> After Pdf successfully upload. remove from code memory _file. & show screen.
  void clearPdf() {
    setState(() {
      _pdfFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context)
        .getUser; // --> Get current user details
    // return Center(
    //   child: IconButton(
    //     icon: const Icon(Icons.upload),
    //     onPressed: () {},
    //   ),
    // );

    return _file == null && _pdfFile == null
        // ? Center( // --> Showing upload options
        //     child: IconButton(
        //       icon: const Icon(Icons.upload), // upload icon
        //       onPressed: () => _selectImage(context),
        //     ),
        //   )
        ? Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon(Icons.image,size: 36,color: Colors.white,),
                InkWell(
                  onTap: () => _selectImage(context),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.46,
                    // color: Colors.blueAccent,
                    decoration: BoxDecoration(
                        // color: Colors.red,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1537498425277-c283d32ef9db?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1178&q=80'),
                            // colorFilter: new ColorFilter.mode(Colors.red.withOpacity(0.8),BlendMode.dstATop),
                            fit: BoxFit.fill),
                        border: Border.all(width: 5, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 66,
                          color: Colors.white,
                        ),
                        Text(
                          'Upload an Image ?',
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(4, 4),
                                  blurRadius: 8,
                                ),
                              ],
                              color: Colors.white),
                        ),
                      ],
                    ),
                    // child: const Text('1st Divider',style: TextStyle(fontSize: 36,fontWeight: FontWeight.w900),),
                  ),
                ),

                // --> For pdf upload

                InkWell(
                  onTap: _pickPDF,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.46,
                    // color: Colors.blueAccent,
                    decoration: BoxDecoration(
                        // color: Colors.blueAccent,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1973&q=80'),
                            // colorFilter: new ColorFilter.mode(Colors.red.withOpacity(0.8),BlendMode.dstATop),
                            fit: BoxFit.fill),
                        border: Border.all(width: 5, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_add_outlined,
                          size: 66,
                          color: Colors.red,
                        ),
                        Text(
                          'Upload any Material ?',
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(4, 4),
                                  blurRadius: 8,
                                ),
                              ],
                              color: Colors.white),
                        ),
                      ],
                    ),
                    // child: const Text('1st Divider',style: TextStyle(fontSize: 36,fontWeight: FontWeight.w900),),
                  ),
                )
              ],
            ),
          )
        : _file != null
            ? Scaffold(
                // after click on icon
                // --> Top bar of screen. -> appBar --> AppBar()
                appBar: AppBar(
                  backgroundColor: Colors.blue,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: clearImage,
                  ),
                  title: const Text('Post to'),
                  centerTitle:
                      false, // title ne center ma nai rakhe top per. e top per left side rakh se title ne.
                  actions: [
                    // right side per post nu text rakhva mate. // ene per click karva thi kaik thay ena mate action lidhu.
                    TextButton(
                      onPressed: () => postImage(
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

                // --> Body section
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      _isLoading
                          ? const LinearProgressIndicator()
                          : const Padding(
                              padding: EdgeInsets.only(top: 0),
                            ), // for showing progress bar at top.
                      const Divider(),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --> Image display
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              // height: 45,
                              // width: 45,
                              child: AspectRatio(
                                aspectRatio: 4 / 3,
                                // aspectRatio: 487 / 451,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: MemoryImage(
                                        _file!), // ! --> for we don't won't _file is null.
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.topCenter,
                                  )),
                                ),
                              ),
                            ),
                          ),
                          // --> Profile pthoto and text field display in Row.
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(user.photoUrl),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.75, // for responsive ness.
                                child: TextField(
                                  controller: _descriptionController,
                                  decoration: InputDecoration(
                                    hintText: 'Write a caption...',
                                    // border: InputBorder.none,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            Divider.createBorderSide(context),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    // focusedBorder: OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
                                    // enabledBorder: OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
                                    contentPadding: const EdgeInsets.all(8),
                                  ),
                                  maxLines: 8,
                                ),
                              ),
                            ],
                          ),

                          // const Divider(), // --> This is line. Grayesh line.
                        ],
                      )
                    ],
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.blue,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: clearPdf,
                  ),
                  title: const Text('Add Material'),
                  centerTitle: false,
                  actions: [
                    TextButton(
                      onPressed: () {},
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 400,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: PDFView(
                          filePath: _pdfFile!.path,
                          enableSwipe: true,
                          swipeHorizontal: true,
                          autoSpacing: false,
                          pageFling: false,
                          defaultPage: 0,
                        ),
                      )
                    ],
                  ),
                ),
              );
  }
}
