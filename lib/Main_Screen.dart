// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'dart:math';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Null_Favs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Add_trip.dart';
import 'Favs_page.dart';
import 'Login_Screen.dart';
import 'My_post.dart';
import 'Profile_Settings.dart';
import 'Search_page.dart';
import 'Services/Auth.dart';

class Main_Screen extends StatefulWidget {
  const Main_Screen({
    Key? key,
  }) : super(key: key);

  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  Random random = Random();
  int post_number = 0;
  int i = 0;
  int current_index = 0;
  final Auth _auth = Auth();
  final currentuser = FirebaseAuth.instance;
  var screens = [
    const Search_page(),
    const My_post(),
  ];

  late List tempList;
  final UniqueKey _key = UniqueKey();
  @override
  initState() {
    tempList = [null, null, null, null, null, null, null, null, null, null];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3DA5D9),
        onPressed: (() {
          setState(() {
            post_number = random.nextInt(1000000);
          });

          Get.to(
              () => Add_trip(
                    my_post_number: post_number,
                  ),
              transition: Transition.downToUp,
              duration: const Duration(seconds: 1));
        }),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          iconSize: 30,
          backgroundColor: const Color(0xFF3DA5D9),
          inactiveColor: Colors.white70,
          activeColor: Colors.white,
          gapLocation: GapLocation.center,
          icons: iconList,
          activeIndex: current_index,
          onTap: (index) {
            setState(() {
              current_index = index;
            });
          }),
      body: screens[current_index],
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            right: 50.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/_Logo.jpg',
                fit: BoxFit.contain,
                height: 85,
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 12),
          child: Builder(
            builder: (context) => GestureDetector(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .where("uid", isEqualTo: currentuser.currentUser!.uid)
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircleAvatar(
                          radius: 20, backgroundColor: Color(0xFF3DA5D9));
                    }
                    if (asyncSnapshot.hasData) {
                      DocumentSnapshot mypost2 = asyncSnapshot.data!.docs[0];
                      return CircleAvatar(
                          radius: 22,
                          backgroundImage:
                              NetworkImage(mypost2["Profile_Photo"]),
                          backgroundColor: const Color(0xFF3DA5D9));
                    }
                    if (!asyncSnapshot.hasData ||
                        asyncSnapshot.data!.docs.isEmpty) {
                      return const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFF3DA5D9),
                      );
                    } else {
                      return const CircleAvatar(
                          minRadius: 22, backgroundColor: Color(0xFF3DA5D9));
                    }
                  }),
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        // ignore: sort_child_properties_last
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .where(
                  "uid",
                  isEqualTo: currentuser.currentUser!.uid,
                )
                .snapshots(),
            initialData: null,
            builder: (context, AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (asyncSnapshot.hasData) {
                return SizedBox(
                  height: 1000,
                  width: 1000,
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: ((context, index) {
                        DocumentSnapshot mypost =
                            asyncSnapshot.data!.docs[index];
                        return SizedBox(
                          height: 800,
                          width: 800,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 40.0),
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(mypost["Profile_Photo"]),
                                  backgroundColor: Colors.white,
                                  radius: 65,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    mypost["Name"],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    mypost["Surname"],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              ListTile(
                                key: _key,
                                onTap: () async {
                                  await FirebaseFirestore.instance
                                      .collection("Status")
                                      .get()
                                      .then((querySnapshot) {
                                    querySnapshot.docs.forEach((result) {
                                      FirebaseFirestore.instance
                                          .collection("Status")
                                          .doc(result.id)
                                          .collection("Favs")
                                          .where("uid_2",
                                              isEqualTo:
                                                  currentuser.currentUser!.uid)
                                          .get()
                                          .then((querySnapshot2) {
                                        querySnapshot2.docs.forEach((result) {
                                          tempList[i] = result.data();
                                          i = i + 1;
                                        });
                                      });
                                    });
                                  });
                                  Get.snackbar(
                                      backgroundColor: Colors.white,
                                      colorText: Colors.blue,
                                      "Lütfen Bekleyiniz",
                                      "Yükleniyor....");
                                  Future.delayed(const Duration(seconds: 3),
                                      () {
                                    if (tempList[0] == null) {
                                      Get.to(() => const Null_Favs());
                                    } else {
                                      Get.to(
                                          () => Favs_page(favsList: tempList));
                                    }
                                  });
                                },
                                title: Text(
                                  "Kaydedilenler",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                textColor: Colors.white,
                                iconColor: Colors.white,
                                leading:
                                    const Icon(FontAwesomeIcons.solidBookmark),
                              ),
                              ListTile(
                                title: Text(
                                  "Hesap Ayarları",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                textColor: Colors.white,
                                iconColor: Colors.white,
                                leading: const Icon(Icons.settings),
                                onTap: () {
                                  Get.to(() => Profile_Settings(
                                        email: mypost["email"],
                                      ));
                                },
                              ),
                              ListTile(
                                onTap: (() {}),
                                title: Text(
                                  "Hakkımızda",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                textColor: Colors.white,
                                iconColor: Colors.white,
                                leading: const Icon(
                                  Icons.people,
                                ),
                              ),
                              ListTile(
                                onTap: (() {
                                  Get.to(() => const Login_Scree());

                                  setState(() {
                                    Future.delayed(const Duration(seconds: 1),
                                        () => _auth.Out());
                                  });
                                }),
                                title: Text(
                                  "Çıkış Yap",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                textColor: Colors.white,
                                iconColor: Colors.white,
                                leading: const Icon(Icons.logout),
                              ),
                            ],
                          ),
                        );
                      })),
                );
              }
              if (asyncSnapshot.hasError) {
                return const Center(child: Text("EROR"));
              } else {
                return const CircularProgressIndicator();
              }
            }),
        backgroundColor: const Color(0xFF3DA5D9),
      ),
    );
  }
}

final iconList = <IconData>[Icons.search, Icons.directions_car];
