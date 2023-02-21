import 'package:cloud_firestore/cloud_firestore.dart';

class Answer {
  final String questionId;
  final String answer;
  final String uid;
  final String username;
  final String answerId;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;
  final String field;
  final String institute;

  const Answer({
    required this.questionId,
    required this.answer,
    required this.uid,
    required this.username,
    required this.answerId,
    required this.datePublished,
    this.postUrl = '',
    required this.profImage,
    required this.likes,
    required this.field,
    required this.institute
  });

  Map<String, dynamic> toJson() => {
    "questionId" : questionId,
    "answer" : answer,
    "uid" : uid,
    "username" : username,
    "answerId" : answerId,
    "datePublished" : datePublished,
    "profImage" : profImage,
    "likes" : likes,
    "postUrl" : postUrl,
    "field" : field,
    "institute" : institute,
  };

//  take document snapshot and return as user model
  static Answer fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String,dynamic>;

    return Answer(
        questionId: snapshot['questionId'],
        username: snapshot['username'],
        uid: snapshot['uid'],
        answer: snapshot['answer'],
        answerId: snapshot['answerId'],
        datePublished: snapshot['datePublished'],
        profImage: snapshot['profImage'],
        likes: snapshot['likes'],
        postUrl: snapshot['postUrl'],
        field: snapshot['field'],
        institute: snapshot['institute']
    );
  }
}