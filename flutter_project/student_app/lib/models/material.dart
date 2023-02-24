import 'package:cloud_firestore/cloud_firestore.dart';

class MaterialTwo {
  final String title;
  final String materialId;
  final String materialType;
  final String materialSubject;
  final String materialField;
  final String materialUrl;

  final String uid;
  final String username;
  final String profImage;
  final String userField;
  final String userInstitute;

  final datePublished;
  final likes;


  const MaterialTwo({
    required this.title,
    required this.materialId,
    required this.materialType,
    required this.materialSubject,
    required this.materialField,
    required this.materialUrl,
    required this.uid,
    required this.username,
    required this.profImage,
    required this.userField,
    required this.userInstitute,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
    "title" : title,
    "materialId" : materialId,
    "materialType" : materialType,
    "materialSubject" : materialSubject,
    "materialField" : materialField,
    "materialUrl" : materialUrl,
    "uid" : uid,
    "username" : username,
    "profImage" : profImage,
    "userField" : userField,
    "userInstitute" : userField,
    "datePublished" : datePublished,
    "likes" : likes,
  };

//  take document snapshot and return as user model
  static MaterialTwo fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String,dynamic>;

    return MaterialTwo(
        title: snapshot['title'],
        materialId: snapshot['materialId'],
        materialType: snapshot['materialType'],
        materialSubject: snapshot['materialSubject'],
        materialField: snapshot['materialField'],
        materialUrl : snapshot['materialUrl'],
        uid: snapshot['uid'],
        username: snapshot['username'],
        profImage: snapshot['profImage'],
      userField: snapshot['userField'],
      userInstitute: snapshot['userInstitute'],
        datePublished: snapshot['datePublished'],
        likes: snapshot['likes'],
    );
  }
}