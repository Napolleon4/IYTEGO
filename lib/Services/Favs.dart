import 'package:cloud_firestore/cloud_firestore.dart';

class Favs {
  String name;
  String surname;
  String price;
  String nerden;
  String nereye;
  String date;
  String time;
  String post_number;
  String uid;
  String uid_2;
  String Profile_Photo;
  String road_info;
  Favs({
    required this.name,
    required this.surname,
    required this.price,
    required this.nerden,
    required this.nereye,
    required this.date,
    required this.time,
    required this.uid,
    required this.uid_2,
    required this.post_number,
    required this.Profile_Photo,
    required this.road_info,
  });
  factory Favs.fromSnapshot(DocumentSnapshot snapshot) {
    return Favs(
      name: snapshot["name"],
      surname: snapshot["surname"],
      price: snapshot["price"],
      uid: snapshot["uid"],
      uid_2: snapshot["uid_2"],
      nerden: snapshot["nerden"],
      nereye: snapshot["nereye"],
      date: snapshot["date"],
      time: snapshot["time"],
      post_number: snapshot["post_number"],
      Profile_Photo: snapshot["Profile_Photo"],
      road_info: snapshot["road_info"],
    );
  }
}
