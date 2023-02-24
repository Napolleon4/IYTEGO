// ignore_for_file: must_be_immutable, camel_case_types, non_constant_identifier_names, must_call_super, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Message_To_User.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Services/Favs_Service.dart';
import 'Services/Status_Service.dart';

class List_of_trips extends StatefulWidget {
  String nerden_;
  String nereye_;
  String date_;

  List_of_trips(
      {Key? key,
      required this.nerden_,
      required this.nereye_,
      required this.date_})
      : super(key: key);

  @override
  State<List_of_trips> createState() => _List_of_tripsState();
}

class _List_of_tripsState extends State<List_of_trips> {
  late Stream<QuerySnapshot> _stream;
  final Status_Service _statusService = Status_Service();
  final Favs_Service _favs_service = Favs_Service();

  late List contList = List<String>.generate(1000, (counter) => "unsaved");
  @override
  void initState() {
    _stream = FirebaseFirestore.instance
        .collection("Status")
        .where("date", isEqualTo: widget.date_)
        .where("nereye", isEqualTo: widget.nereye_)
        .snapshots();
    contList;
    super.didChangeDependencies();
  }

  final currentuser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.blue),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 65,
              ),
              StreamBuilder<QuerySnapshot>(
                  initialData: null,
                  stream: _stream,
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!asyncSnapshot.hasData ||
                        asyncSnapshot.data!.docs.isEmpty) {
                      return Column(
                        children: [
                          Image.asset(
                            "images/Undraw_1.png",
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ListTile(
                              titleTextStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              subtitleTextStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              subtitle: const Text(
                                  "Lütfen Tarih veya Lokasyon bilgilerini değiştirip tekrar deneyin"),
                              textColor: const Color(0xFF3DA5D9),
                              title: const Text(
                                  "Girdiğiniz bilgilere ait yolculuk bulamadık"),
                            ),
                          )
                        ],
                      );
                    }
                    if (asyncSnapshot.hasError) {
                      return const Text("eror");
                    }

                    if (asyncSnapshot.hasData) {
                      return SizedBox(
                          height: 10000000,
                          width: 100000000,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const ScrollPhysics(),
                            itemCount: asyncSnapshot.data!.size,
                            itemBuilder: (
                              context,
                              index,
                            ) {
                              DocumentSnapshot mypost =
                                  asyncSnapshot.data!.docs[index];

                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 8.0),
                                  child: Container(
                                    height: 430,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: const Color(0xFF3DA5D9),
                                            width: 2)),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        ListTile(
                                            leading: InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        content: CircleAvatar(
                                                          radius: 150,
                                                          backgroundImage:
                                                              NetworkImage(mypost[
                                                                  "Profile_Photo"]),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    mypost["Profile_Photo"]),
                                                backgroundColor: Colors.blue,
                                              ),
                                            ),
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  mypost["name"],
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  mypost["surname"],
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                                Get.to(
                                                    () => Message_To_User(
                                                        name: mypost["name"],
                                                        surname:
                                                            mypost["surname"],
                                                        uid: mypost["uid"],
                                                        photo: mypost[
                                                            "Profile_Photo"]),
                                                    transition:
                                                        Transition.cupertino,
                                                    duration:
                                                        Duration(seconds: 1));
                                              },
                                              icon: const Icon(
                                                FontAwesomeIcons.message,
                                                color: Colors.blue,
                                              ),
                                            )),
                                        ListTile(
                                          trailing: IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        content: Text(mypost[
                                                            "road_info"]),
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Güzergah Bilgisi",
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      color: Colors
                                                                          .blue),
                                                            ),
                                                          ],
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                "Tamam",
                                                                style: GoogleFonts
                                                                    .montserrat(),
                                                              ))
                                                        ],
                                                      );
                                                    });
                                              },
                                              icon: const Icon(
                                                  Icons.info_outline)),
                                          subtitle: const Text("Başlangıç"),
                                          iconColor: Colors.blue,
                                          leading:
                                              const Icon(Icons.gps_not_fixed),
                                          title: Text(
                                            mypost["nerden"],
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        ListTile(
                                          subtitle: const Text("Bitiş"),
                                          iconColor: Colors.blue,
                                          leading: const Icon(Icons.place),
                                          title: Text(
                                            mypost["nereye"],
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        ListTile(
                                          subtitle: const Text("Ücret"),
                                          iconColor: Colors.blue,
                                          leading: const Icon(
                                              FontAwesomeIcons.turkishLiraSign),
                                          title: Text(
                                            mypost["price"],
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        ListTile(
                                          subtitle: const Text("Tarih"),
                                          iconColor: Colors.blue,
                                          leading: const Icon(
                                              Icons.date_range_outlined),
                                          title: Text(
                                            mypost["date"],
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        ListTile(
                                          subtitle: const Text("Saat"),
                                          iconColor: Colors.blue,
                                          leading: const Icon(
                                              FontAwesomeIcons.clock),
                                          title: Text(
                                            mypost["time"],
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: IconButton(
                                              onPressed: (contList[index] ==
                                                      "unsaved")
                                                  ? () async {
                                                      _statusService.addFavs(
                                                          mypost["name"],
                                                          mypost["surname"],
                                                          mypost["uid"],
                                                          currentuser
                                                              .currentUser!.uid,
                                                          mypost["date"],
                                                          mypost["nerden"],
                                                          mypost["nereye"],
                                                          mypost["time"],
                                                          mypost["price"],
                                                          mypost["post_number"]
                                                              .toString(),
                                                          mypost[
                                                              "Profile_Photo"],
                                                          mypost["road_info"]);

                                                      Get.snackbar(
                                                          "Gönderi Kaydedildi",
                                                          "",
                                                          backgroundColor:
                                                              Colors.white,
                                                          snackPosition:
                                                              SnackPosition.TOP,
                                                          colorText:
                                                              Colors.blue);
                                                      setState(() {
                                                        contList[index] =
                                                            "saved";
                                                      });
                                                    }
                                                  : () async {
                                                      await _favs_service
                                                          .deleteFavs(
                                                              mypost["uid"],
                                                              currentuser
                                                                  .currentUser!
                                                                  .uid);
                                                      Get.snackbar(
                                                          "Gönderi Kaydedildilenlerden Kaldırıldı",
                                                          "",
                                                          backgroundColor:
                                                              Colors.white,
                                                          snackPosition:
                                                              SnackPosition.TOP,
                                                          colorText:
                                                              Colors.blue);
                                                      setState(() {
                                                        contList[index] =
                                                            "unsaved";
                                                      });
                                                    },
                                              icon: Icon((contList[index] ==
                                                      "unsaved")
                                                  ? FontAwesomeIcons.bookmark
                                                  : FontAwesomeIcons
                                                      .solidBookmark)),
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                          ));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          )),
    );
  }
}
