import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/resources/storage_methods.dart';
import 'package:student_app/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser  = _auth.currentUser!;

    // -> Take current user toke id.
    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
    // -> Take snap of current user & return it.
    return model.User.fromSnap(snap);
  }

//  --> signup user
  Future<String> signUpUser({ // data type is future because all the call of firebase is asynchronous
    required String email,
    required String password,
    required String username,
    required String institue,
    required String field,
    required Uint8List file
  }) async{
    String res = "Some error occured";
    try {
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || institue.isNotEmpty || field.isNotEmpty) {
        //  register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        print(cred.user!.uid); // give user id // user! ---> user can be return as null. That's way put ! mark.

        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

        //  add user to our firestore database
        // --> 2nd method using Convert into JSON
        model.User user = model.User(
          username : username,
          uid : cred.user!.uid,
          email : email,
          institue: institue,
          field: field,
          followers : [],
          following : [],
          photoUrl : photoUrl,
        );
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);

        // --> 1st method.
        // await _firestore.collection('users').doc(cred.user!.uid).set({
        //   'username' : username,
        //   'uid' : cred.user!.uid,
        //   'email' : email,
        //   'institue' : institue,
        //   'field' : field,
        //   'followers' : [],
        //   'following' : [],
        //   'photoUrl' : photoUrl,
        // });

        // another way to do above // below method create random document id && above method is create user id as document id also
        // await _firestore.collection('users').add({
        //   'username' : username,
        //   'uid' : cred.user!.uid,
        //   'email' : email,
        //   'bio' : bio,
        //   'followers' : [],
        //   'following' : [],
        // });

        res = "success";
      }
    }
    // on FirebaseAuthException catch(err) { // for any authentication error. Like: invalid email, password size less than 6 character.
    //   if(err.code == 'invalid-email') {
    //     res = 'The email is badly formatted.';
    //   } else if(err.code == 'weak-password') {
    //     res = 'Password should be at least 6 characters.';
    //   }
    // }
    catch(err) {
      res = err.toString();
    }
    return res;
  }

  // --> logging in user
  Future<String> loginUser({
    required String email,
    required String password
  }) async{
    String res = "Some error occured";

    try {
      if(email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    }
    // on FirebaseAuthException catch(e) {    // for any authentication error. Like: user not found, wrong password.
    //   if(e.code == 'user-not-found') {
    //     // user not found custome message.
    //     res = "User Not Found!!";
    //   } else if(e.code == 'wrong-password') {
    //     // wrong password cutome message.
    //     res = "Wrong Password!!";
    //   }
    // }

    catch(err) {
      res = err.toString();
    }
    return res;
  }
}