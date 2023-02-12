import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance; // for get user id.

//  adding image to firebase storage
  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async{  // this function can use for store profile and post
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid); // ref() --->this method point to the our file in storage. // child() ---> represent folder. it can be exist or does not exist.
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL(); // it's fetch download URL to the file being uploaded here

    return downloadUrl;
  }
}