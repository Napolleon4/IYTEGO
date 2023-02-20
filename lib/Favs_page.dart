// ignore_for_file: non_constant_identifier_names, camel_case_types, must_be_immutable, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Main_Screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Services/Favs_Service.dart';
import 'Services/Status_Service.dart';

class Favs_page extends StatefulWidget {
  List favsList = [];
  Favs_page({
    Key? key,
    required this.favsList,
  }) : super(key: key);

  @override
  State<Favs_page> createState() => _List_of_tripsState();
}

class _List_of_tripsState extends State<Favs_page> {
  final Favs_Service _favs_service = Favs_Service();
  final Status_Service _status_service = Status_Service();
  final currentuser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.blue,
                size: 20,
              ),
              onPressed: () {
                Get.to(() => const Main_Screen());
              },
            ),
          ),
          body: SizedBox(
            width: 10000,
            height: 10000,
            child: ListView.builder(
                itemCount: widget.favsList.length,
                itemBuilder: (context, int index) {
                  if (widget.favsList.isEmpty) {
                    return const CircularProgressIndicator();
                  }
                  if (widget.favsList[index] != null) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 8.0),
                        child: Container(
                          height: 430,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: const Color(0xFF3DA5D9), width: 2)),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      widget.favsList[index]["Profile_Photo"],
                                    ),
                                    backgroundColor: Colors.blue,
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.favsList[index]["name"],
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        widget.favsList[index]["surname"],
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {},
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
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Text(
                                                  widget.favsList[index]
                                                      ["road_info"]),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Güzergah Bilgisi",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color: Colors.blue),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
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
                                    icon: const Icon(Icons.info_outline)),
                                subtitle: const Text("Başlangıç"),
                                iconColor: Colors.blue,
                                leading: const Icon(Icons.gps_not_fixed),
                                title: Text(
                                  widget.favsList[index]["nerden"],
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
                                  widget.favsList[index]["nereye"],
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
                                  widget.favsList[index]["price"],
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ListTile(
                                subtitle: const Text("Tarih"),
                                iconColor: Colors.blue,
                                leading: const Icon(Icons.date_range_outlined),
                                title: Text(
                                  widget.favsList[index]["date"],
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ListTile(
                                subtitle: const Text("Saat"),
                                iconColor: Colors.blue,
                                leading: const Icon(FontAwesomeIcons.clock),
                                title: Text(
                                  widget.favsList[index]["time"],
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: IconButton(
                                    onPressed: (widget.favsList[index]
                                                ["post_number"] !=
                                            0)
                                        ? () async {
                                            await _favs_service.deleteFavs(
                                                widget.favsList[index]["uid"]
                                                    .toString(),
                                                widget.favsList[index]["uid_2"]
                                                    .toString());
                                            setState(() {
                                              widget.favsList[index]
                                                  ["post_number"] = 0;
                                            });

                                            Get.snackbar(
                                                "Gönderi Kaydedilenlerden Kaldırıldı",
                                                "",
                                                backgroundColor: Colors.white,
                                                snackPosition:
                                                    SnackPosition.TOP,
                                                colorText: Colors.blue);
                                          }
                                        : () async {
                                            await _status_service.addFavs(
                                                widget.favsList[index]["name"],
                                                widget.favsList[index]
                                                    ["surname"],
                                                widget.favsList[index]["uid"],
                                                widget.favsList[index]["uid_2"],
                                                widget.favsList[index]["date"],
                                                widget.favsList[index]
                                                    ["nerden"],
                                                widget.favsList[index]
                                                    ["nereye"],
                                                widget.favsList[index]["time"],
                                                widget.favsList[index]["price"],
                                                widget.favsList[index]
                                                        ["post_number"]
                                                    .toString(),
                                                widget.favsList[index]
                                                    ["Profile_Photo"],
                                                widget.favsList[index]
                                                    ["road_info"]);

                                            setState(() {
                                              widget.favsList[index]
                                                  ["post_number"] = 1;
                                            });
                                            Get.snackbar("Gönderi Kaydedildi",
                                                "Kaydedilener Sekmesinden Görebilirsiniz",
                                                backgroundColor: Colors.white,
                                                snackPosition:
                                                    SnackPosition.TOP,
                                                colorText: Colors.blue);
                                          },
                                    icon: Icon((widget.favsList[index]
                                                ["post_number"] !=
                                            0)
                                        ? FontAwesomeIcons.solidBookmark
                                        : FontAwesomeIcons.bookmark)),
                              )
                            ],
                          ),
                        ));
                  } else {
                    return null;
                  }
                }),
          )),
    );
  }
}
