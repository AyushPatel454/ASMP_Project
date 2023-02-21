import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/models/question.dart';
import 'package:student_app/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // --> Upload post
  Future<String> uploadPost(
      String description,
      Uint8List file,
      String uid,
      String username,
      String profImage,
      String userField,
      String userInstitue
      ) async {
    String res = "Some error occured";
    try {
      // upload in firestore & take url of image & store in variable.
      String photUrl = await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photUrl,
          profImage: profImage,
          likes: [],
          field: userField,
          institute: userInstitue
      );

      // --> Store data in Fire Store Database. (Post image not store. It will be store in Storage Database. -> storage_methods.dart file for post image store in storage database.)
      _firestore.collection('posts').doc(postId).set(post.toJson(),); // --> post.toJson -> Convert in JSON format & uplaod in firestore datbase

      res = "success";
    } catch(err) {
      res = err.toString();
    }

    return res;
  }

  // --> Upload question
  Future<String> uploadQuestion(
      String question,
      String questionType,
      // File file,
      // Uint8List file,
      String photoUrl,
      String uid,
      String username,
      String profImage,
      String userField,
      String userInstitue
      ) async {
    String res = "Some error occured";
    try {
      // upload in firestore & take url of image & store in variable.
      // String photoUrl = '';
      // if(file != null) {
      //   photoUrl = await StorageMethods().uploadImageToStorage('question', file, true);
      // }


      String questionId = const Uuid().v1();
      Question que = Question(
          question: question,
          questionType: questionType,
          uid: uid,
          username: username,
          questionId: questionId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          // likes: [],
          field: userField,
          institute: userInstitue
      );

      // --> Store data in Fire Store Database. (Post image not store. It will be store in Storage Database. -> storage_methods.dart file for post image store in storage database.)
      _firestore.collection('questions').doc(questionId).set(que.toJson(),); // --> post.toJson -> Convert in JSON format & uplaod in firestore datbase

      res = "success";
    } catch(err) {
      res = err.toString();
      print(err.toString());
    }

    return res;
  }

  // --> Update likes
  Future<void> likePost(String postId, String uid, List likes) async{
    try {
      // -> likes []: contain uid then remove when user click again on like.
      if(likes.contains(uid)) { // for dislike. // then remove like (uid) from likes field in firebase database.
        await _firestore.collection('posts').doc(postId).update({
          'likes' : FieldValue.arrayRemove([uid]),
        });
      }
      // -> likes []: does not contain uid then add user in list when user click on like.
      else { // for like. // then store uid in likes field (list) in firebase database.
        await _firestore.collection('posts').doc(postId).update({
          'likes' : FieldValue.arrayUnion([uid]),
        });
      }
    } catch(e) {
      print(e.toString());
    }
  }

  // store comment in firebase database.
  Future<void> postComment(String postId, String text, String uid, String name, String profilePic) async{
    try {
      if(text.isNotEmpty) {
        String commentId = const Uuid().v1(); // -> generate unique comment id.
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
          'profilePic' : profilePic,
          'name' : name,
          'uid' : uid,
          'text' : text,
          'commentId' : commentId,
          'datePublished' : DateTime.now(),
        });
      } else {
        // nothing happen
        print('Text is empty');
      }
    } catch(e) {
      print(e.toString());
    }
  }

}