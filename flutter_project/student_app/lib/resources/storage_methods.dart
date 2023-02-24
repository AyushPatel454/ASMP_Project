import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance; // for get user id.

//  adding image to firebase storage
  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async{  // this function can use for store profile and post
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid); // ref() --->this method point to the our file in storage. // child() ---> represent folder. it can be exist or does not exist.

    if(isPost) {
      String id = const Uuid().v1(); // generate unique id for post. // -> It can't same with user id.
      ref = ref.child(id); // name of post be a unique id. // --> create user unique id folder & store user image in that.
    }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL(); // it's fetch download URL to the file being uploaded here

    return downloadUrl;
  }

  //  adding pdf to firebase storage
  Future<String> uploadMaterialToStorage(String material, String type, File file, bool isPost) async{  // this function can use for store profile and post
    Reference ref = _storage.ref().child(material).child(type).child(_auth.currentUser!.uid); // ref() --->this method point to the our file in storage. // child() ---> represent folder. it can be exist or does not exist.

    if(isPost) {
      String id = const Uuid().v1(); // generate unique id for post. // -> It can't same with user id.
      ref = ref.child(id); // name of post be a unique id. // --> create user unique id folder & store user image in that.
    }

    // upload pdf file to firebase storage
    TaskSnapshot taskSnapshot = await ref.putFile(file);

    String downloadUrl = await taskSnapshot.ref.getDownloadURL(); // it's fetch download URL to the file being uploaded here

    // return the url of pdf file uploaded location.
    return downloadUrl;
  }
}
