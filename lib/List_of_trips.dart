import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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
  @override
  late Stream<QuerySnapshot> _stream;
  Status_Service _statusService = Status_Service();
  Favs_Service _favs_service = Favs_Service();
  Icon _myicon = Icon(FontAwesomeIcons.bookmark);
  Icon _meyicon2 = Icon(FontAwesomeIcons.solidBookmark);

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

  @override
  @override
  final currentuser = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 65,
              ),
              StreamBuilder<QuerySnapshot>(
                  initialData: null,
                  stream: _stream,
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
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
                              subtitle: Text(
                                  "Lütfen Tarih veya Lokasyon bilgilerini değiştirip tekrar deneyin"),
                              textColor: Color(0xFF3DA5D9),
                              title: Text(
                                  "Girdiğiniz bilgilere ait yolculuk bulamadık"),
                            ),
                          )
                        ],
                      );
                    }
                    if (asyncSnapshot.hasError) {
                      return Text("eror");
                    }

                    if (asyncSnapshot.hasData) {
                      return SizedBox(
                          height: 10000000,
                          width: 100000000,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
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
                                            color: Color(0xFF3DA5D9),
                                            width: 2)),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 8,
                                        ),
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                mypost["Profile_Photo"]),
                                            backgroundColor: Colors.blue,
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
                                              SizedBox(
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
                                          trailing: Icon(
                                            FontAwesomeIcons.message,
                                            color: Colors.blue,
                                          ),
                                        ),
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
                                              icon: Icon(Icons.info_outline)),
                                          subtitle: Text("Başlangıç"),
                                          iconColor: Colors.blue,
                                          leading: Icon(
                                              FontAwesomeIcons.locationArrow),
                                          title: Text(
                                            mypost["nerden"],
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        ListTile(
                                          subtitle: Text("Bitiş"),
                                          iconColor: Colors.blue,
                                          leading: Icon(
                                              FontAwesomeIcons.locationArrow),
                                          title: Text(
                                            mypost["nereye"],
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        ListTile(
                                          subtitle: Text("Ücret"),
                                          iconColor: Colors.blue,
                                          leading: Icon(
                                              FontAwesomeIcons.turkishLiraSign),
                                          title: Text(
                                            mypost["price"],
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        ListTile(
                                          subtitle: Text("Tarih"),
                                          iconColor: Colors.blue,
                                          leading:
                                              Icon(Icons.date_range_outlined),
                                          title: Text(
                                            mypost["date"],
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        ListTile(
                                          subtitle: Text("Saat"),
                                          iconColor: Colors.blue,
                                          leading: Icon(FontAwesomeIcons.clock),
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
                                                        print(contList[index]);
                                                      });

                                                      print("Eklendi");
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
                                                      print("Silindi");
                                                      setState(() {
                                                        contList[index] =
                                                            "unsaved";
                                                        print(contList[index]);
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
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          )),
    );
  }
}
