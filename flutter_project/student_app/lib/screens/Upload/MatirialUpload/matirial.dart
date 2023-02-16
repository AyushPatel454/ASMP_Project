import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class MatirialUpload extends StatefulWidget {
  const MatirialUpload({Key? key}) : super(key: key);

  @override
  State<MatirialUpload> createState() => _MatirialUploadState();
}

class _MatirialUploadState extends State<MatirialUpload> {
  late File _imageFile;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Matirial'),
      ),

      // body: ListView(
      //   children: [
      //     IconButton(
      //         onPressed: () async => await _pickImageFromGallery(),
      //         icon: Icon(Icons.photo_camera),
      //     ),
      //     this._imageFile == null ? Placeholder() : Image.file(this._imageFile),
      //   ],
      // ),




    );

  }

  // Future<Null> _pickImageFromGallery() async {
  //   final XFile? imageFile =
  //   await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() => this._imageFile = imageFile);
  // }
}
