import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  String name;
  String surname;
  String price;
  String nerden;
  String nereye;
  String date;
  String time;
  String statustime;
  String uid;
  String Profile_Photo;
  String road_info;
  var post_number;

  Status({
    required this.name,
    required this.surname,
    required this.price,
    required this.nerden,
    required this.nereye,
    required this.date,
    required this.time,
    required this.uid,
    required this.statustime,
    required this.post_number,
    required this.Profile_Photo,
    required this.road_info,
  });
  factory Status.fromSnapshot(DocumentSnapshot snapshot) {
    return Status(
      name: snapshot["name"],
      surname: snapshot["surname"],
      price: snapshot["price"],
      uid: snapshot["uid"],
      nerden: snapshot["nerden"],
      nereye: snapshot["nereye"],
      date: snapshot["date"],
      time: snapshot["time"],
      statustime: snapshot["statustime"],
      post_number: snapshot["post_number"],
      Profile_Photo: snapshot["Profile_Photo"],
      road_info: snapshot["road_info"],
    );
  }
}
