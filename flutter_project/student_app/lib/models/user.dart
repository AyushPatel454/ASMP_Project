import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String institue;
  final String field;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.institue,
    required this.field,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
    "username" : username,
    "uid" : uid,
    "email" : email,
    "institue" : institue,
    "field" : field,
    "photoUrl" : photoUrl,
    "followers" : followers,
    "following" : following
  };

//  take document snapshot and return as user model
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String,dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      institue: snapshot['institue'],
      field: snapshot['field'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}