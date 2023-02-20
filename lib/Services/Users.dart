import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String name;
  String surname;
  String email;
  String phoTo_Url;
  String uid;

  Users({
    required this.name,
    required this.surname,
    required this.email,
    required this.uid,
    required this.phoTo_Url,
  });
  factory Users.fromSnapshot(DocumentSnapshot snapshot) {
    return Users(
      name: snapshot["Name"],
      surname: snapshot["Surname"],
      email: snapshot["email"],
      uid: snapshot["uid"],
      phoTo_Url: snapshot["Profile_Photo"],
    );
  }
}
