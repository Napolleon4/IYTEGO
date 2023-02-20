// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login_Screen.dart';
import 'Signup.dart';

class Welcome_page extends StatefulWidget {
  const Welcome_page({Key? key}) : super(key: key);

  @override
  State<Welcome_page> createState() => _Welcome_pageState();
}

class _Welcome_pageState extends State<Welcome_page> {
  bool animte = false;
  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFF3DA5D9),
          body: AnimatedOpacity(
            duration: const Duration(milliseconds: 1600),
            opacity: animte ? 1 : 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
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
                        const SizedBox(
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
                      const SizedBox(
                        width: 60,
                      ),
                      Text(
                        "Yazı",
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: (() => {
                          Get.to(
                            () => const Login_Scree(),
                            transition: Transition.cupertino,
                            duration: const Duration(seconds: 1),
                          ),
                        }),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(40, 40),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: Text(
                        "                   Giriş Yap                   ",
                        style: GoogleFonts.montserrat(
                            color: const Color(0xFF3DA5D9), fontSize: 20)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(40, 40),
                      backgroundColor: const Color(0xFF3DA5D9),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    onPressed: (() => {
                          Get.to(
                            () => const Signup(),
                            transition: Transition.cupertino,
                            duration: const Duration(seconds: 1),
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
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      animte = true;
    });
  }
}
