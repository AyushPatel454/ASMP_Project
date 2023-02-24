import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String question;
  final String questionType;
  final String uid;
  final String username;
  final String questionId;
  final datePublished;
  final String postUrl;
  final String profImage;
  // final likes;
  final String field;
  final String institute;

  const Question({
    required this.question,
    required this.questionType,
    required this.uid,
    required this.username,
    required this.questionId,
    required this.datePublished,
    this.postUrl = '',
    required this.profImage,
    // required this.likes,
    required this.field,
    required this.institute
  });

  Map<String, dynamic> toJson() => {
    "question" : question,
    "questionType" : questionType,
    "uid" : uid,
    "username" : username,
    "questionId" : questionId,
    "datePublished" : datePublished,
    "profImage" : profImage,
    // "likes" : likes,
    "postUrl" : postUrl,
    "field" : field,
    "institute" : institute,
  };

//  take document snapshot and return as user model
  static Question fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String,dynamic>;

    return Question(
        username: snapshot['username'],
        uid: snapshot['uid'],
        question: snapshot['question'],
        questionType: snapshot['questionType'],
        questionId: snapshot['questionId'],
        datePublished: snapshot['datePublished'],
        profImage: snapshot['profImage'],
        // likes: snapshot['likes'],
        postUrl: snapshot['postUrl'],
        field: snapshot['field'],
        institute: snapshot['institute']
    );
  }
}