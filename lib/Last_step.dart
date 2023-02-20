import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:im_stepper/stepper.dart';
import 'dart:ui' as ui;

import 'Login_Screen.dart';
import 'Step_image_name.dart';

class Last_step extends StatefulWidget {
  const Last_step({Key? key}) : super(key: key);

  @override
  State<Last_step> createState() => _Last_stepState();
}

class _Last_stepState extends State<Last_step> {
  @override
  String email = "";
  String password = "";
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    int step = 0;
    return Scaffold(
        key: _globalKey,
        body: OverBoard(
          skipText: "Önceki Adım",
          nextText: "Sonraki",
          finishText: "Başlayalım",
          buttonColor: Color(0xFF3DA5D9),
          showBullets: true,
          allowScroll: true,
          pages: pages,
          activeBulletColor: Colors.lightBlue,
          inactiveBulletColor: Color(0xFF3DA5D9),
          finishCallback: () {
            setState(() {
              Get.to(() => Login_Scree());
            });
          },
          skipCallback: () {
            Get.to(
              () => Step_image_name(
                password: password,
                email: email,
              ),
              transition: Transition.cupertino,
              duration: Duration(seconds: 1),
            );
          },
        ));
  }
}

List<PageModel> pages = [
  PageModel(
    color: Colors.white,
    imageAssetPath: 'images/On_boarding_1.png',
    title: 'Sana Uygun Yolculuğu Bul',
    bodyColor: Color(0xFF3DA5D9),
    body: 'Yolcuk ara ve sana uygun olanı bul',
    titleColor: Color(0xFF3DA5D9),
  ),
  PageModel(
    color: Colors.white,
    imageAssetPath: 'images/message1.png',
    title: 'Sürücüyle İleşime Geç',
    bodyColor: Color(0xFF3DA5D9),
    body: 'Yolculuğunu paylaşacağın kişiyle iletişme geç',
    titleColor: Color(0xFF3DA5D9),
  ),
  PageModel(
    color: Colors.white,
    imageAssetPath: 'images/On_boarding_3.png',
    title: 'Ödemeyi Unutma',
    bodyColor: Color(0xFF3DA5D9),
    body: 'Yolculuk bitiminde ücretini ödemeyi unutma',
    titleColor: Color(0xFF3DA5D9),
  ),
];
