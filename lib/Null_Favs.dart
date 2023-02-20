import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Main_Screen.dart';

class Null_Favs extends StatefulWidget {
  const Null_Favs({super.key});

  @override
  State<Null_Favs> createState() => _Null_FavsState();
}

class _Null_FavsState extends State<Null_Favs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.blue,
          ),
          onPressed: () {
            Get.to(() => Main_Screen());
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Image.asset(
              "images/Booking.png",
              height: 400,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 40),
              child: ListTile(
                titleTextStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, fontSize: 15),
                textColor: Color(0xFF3DA5D9),
                title: Text("Henüz Kaydettiğin Bir Yolculuk Yok"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
