import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Favs.dart';

class Favs_Service {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentuser = FirebaseAuth.instance;

  Future<void> deleteFavs(String uid, String currentuserUid) {
    var ref = _firestore
        .collection("Status")
        .doc(uid)
        .collection("Favs")
        .doc(currentuserUid)
        .delete();

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
}
