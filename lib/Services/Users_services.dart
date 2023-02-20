import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Users.dart';

class Userservice {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final current = FirebaseAuth.instance;
  Future<void> addUser(
    String uid,
    String name,
    String surname,
    String email,
    String phoTo_Url,
  ) async {
    var ref = _firestore.collection("Users").doc(current.currentUser!.uid);

    var documentref = await ref.set({
      "uid": uid,
      "Name": name,
      "Surname": surname,
      "email": email,
      "Profile_Photo": phoTo_Url,
    });
    Users(
      uid: uid,
      name: name,
      surname: surname,
      email: email,
      phoTo_Url: phoTo_Url,
    );
  }

  Stream<QuerySnapshot> getuserStatus() {
    var ref = _firestore.collection("Users").snapshots();
    return ref;
  }
}
