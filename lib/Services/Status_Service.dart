// ignore_for_file: file_names, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Services/Favs.dart';

import 'Status.dart';

class Status_Service {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentuser = FirebaseAuth.instance;
  Future<void> addStatus(
    String statustime,
    String name,
    String surname,
    String uid,
    String date,
    String nerden,
    String nereye,
    String time,
    String price,
    String post_number,
    String Profile_Photo,
    String road_info,
  ) async {
    var ref = _firestore.collection("Status").doc(currentuser.currentUser!.uid);

    var documentref = await ref.set({
      "statustime": statustime,
      "name": name,
      "surname": surname,
      "uid": uid,
      "date": date,
      "nerden": nerden,
      "nereye": nereye,
      "price": price,
      "time": time,
      "post_number": post_number,
      "Profile_Photo": Profile_Photo,
      "road_info": road_info,
    });
    Status(
      statustime: statustime,
      name: name,
      surname: surname,
      uid: uid,
      date: date,
      price: price,
      nerden: nerden,
      nereye: nereye,
      time: time,
      post_number: post_number,
      Profile_Photo: Profile_Photo,
      road_info: road_info,
    );
  }

  void getdocs_() {
    FirebaseFirestore.instance
        .collection("Status")
        .get()
        .then((value) => value.docs.forEach((results) {
              FirebaseFirestore.instance
                  .collection("Status")
                  .doc(results.id)
                  .collection("Favs")
                  .where("uid", isEqualTo: currentuser.currentUser!.uid);
            }));
  }

  Future<void> deleteStatus(String docId) {
    var ref = _firestore.collection("Status").doc(docId).delete();
    return ref;
  }

  Future<void> addFavs(
    String name,
    String surname,
    String uid,
    String uid_2,
    String date,
    String nerden,
    String nereye,
    String time,
    String price,
    String post_number,
    String Profile_Photo,
    String road_info,
  ) async {
    var ref = _firestore
        .collection("Status")
        .doc(uid)
        .collection("Favs")
        .doc(currentuser.currentUser!.uid);

    var documentref = await ref.set({
      "name": name,
      "surname": surname,
      "uid": uid,
      "uid_2": uid_2,
      "date": date,
      "nerden": nerden,
      "nereye": nereye,
      "price": price,
      "time": time,
      "post_number": post_number,
      "Profile_Photo": Profile_Photo,
      "road_info": road_info,
    });
    Favs(
      name: name,
      surname: surname,
      uid: uid,
      uid_2: uid_2,
      date: date,
      price: price,
      nerden: nerden,
      nereye: nereye,
      time: time,
      post_number: post_number,
      Profile_Photo: Profile_Photo,
      road_info: road_info,
    );
  }

  Future<void> updatePhoto(String photoUrl) async {
    await _firestore
        .collection("Users")
        .doc(currentuser.currentUser!.uid)
        .update({"Profile_Photo": photoUrl});
  }

  Future updateSurname(String surname) async {
    await _firestore
        .collection("Users")
        .doc(currentuser.currentUser!.uid)
        .update({"Surname": surname});
  }

  Future updatename(String name) async {
    await _firestore
        .collection("Users")
        .doc(currentuser.currentUser!.uid)
        .update({"Name": name});
  }
}
