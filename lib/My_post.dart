import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/src/routes/circular_reveal_clipper.dart';

import 'package:google_fonts/google_fonts.dart';

import 'Services/Status_Service.dart';

class My_post extends StatefulWidget {
  const My_post({Key? key}) : super(key: key);

  @override
  State<My_post> createState() => _My_postState();
}

class _My_postState extends State<My_post> {
  @override
  Status_Service _statusService = Status_Service();
  bool _isFlipped = false;
  final currentuser = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 65,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Status")
                  .where(
                    "uid",
                    isEqualTo: currentuser.currentUser!.uid,
                  )
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    value: 20,
                  ));
                }
                if (!asyncSnapshot.hasData ||
                    asyncSnapshot.data!.docs.isEmpty) {
                  return new Column(
                    children: [
                      Image.asset(
                        "images/Post.png",
                        height: 400,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 40),
                        child: ListTile(
                          titleTextStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          textColor: Color(0xFF3DA5D9),
                          title: Text("Henüz Yayinladiğin Bir Yolculuk Yok"),
                        ),
                      )
                    ],
                  );
                }

                if (asyncSnapshot.hasData) {
                  return SizedBox(
                      height: 10000,
                      width: 10000,
                      child: ListView.builder(
                        physics: ScrollPhysics(),
                        itemCount: asyncSnapshot.data!.size,
                        itemBuilder: (context, index) {
                          DocumentSnapshot mypost =
                              asyncSnapshot.data!.docs[index];
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10),
                              child: Container(
                                height: 430,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Color(0xFF3DA5D9), width: 2)),
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
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            mypost["surname"],
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        color: Colors.blue,
                                        onPressed: () {
                                          DocumentSnapshot snapshot =
                                              asyncSnapshot.data!.docs[index];
                                          _statusService
                                              .deleteStatus(snapshot.id);
                                        },
                                        icon: Icon(Icons.delete),
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
                                                    content: Text(
                                                        mypost["road_info"]),
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
                                      leading: Icon(Icons.gps_not_fixed),
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
                                      leading: Icon(Icons.place),
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
                                      leading: Icon(Icons.date_range_outlined),
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
