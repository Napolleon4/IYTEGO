import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login_Screen.dart';
import 'Signup.dart';

class Welcome_page extends StatefulWidget {
  const Welcome_page({Key? key}) : super(key: key);

  @override
  State<Welcome_page> createState() => _Welcome_pageState();
}

class _Welcome_pageState extends State<Welcome_page> {
  @override
  bool animte = false;
  void initState() {
    startAnimation();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFF3DA5D9),
          body: AnimatedOpacity(
            duration: Duration(milliseconds: 1600),
            opacity: animte ? 1 : 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "images/iytegoLogoBeyaz.png",
                          alignment: Alignment.topLeft,
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Image.asset(
                      "images/arabadaInsanlar.png",
                      height: 230,
                      width: 400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                        ),
                        Text(
                          "Slogan",
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        "Yazı",
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: (() => {
                          Get.to(
                            () => Login_Scree(),
                            transition: Transition.cupertino,
                            duration: Duration(seconds: 1),
                          ),
                        }),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(40, 40),
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: Text(
                        "                   Giriş Yap                   ",
                        style: GoogleFonts.montserrat(
                            color: Color(0xFF3DA5D9), fontSize: 20)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(40, 40),
                      primary: Color(0xFF3DA5D9),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    onPressed: (() => {
                          Get.to(
                            () => Signup(),
                            transition: Transition.cupertino,
                            duration: Duration(seconds: 1),
                          ),
                        }),
                    child: Text(
                        "                    Kayıt Ol                    ",
                        style: GoogleFonts.montserrat(
                            color: Colors.white, fontSize: 20)),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      animte = true;
    });
  }
}
