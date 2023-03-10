// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:get/get.dart';

import 'Login_Screen.dart';
import 'Step_image_name.dart';

class Last_step extends StatefulWidget {
  const Last_step({Key? key}) : super(key: key);

  @override
  State<Last_step> createState() => _Last_stepState();
}

class _Last_stepState extends State<Last_step> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        body: OverBoard(
          skipText: "Atla",
          nextText: "Sonraki",
          finishText: "Başlayalım",
          buttonColor: const Color(0xFF3DA5D9),
          showBullets: true,
          allowScroll: true,
          pages: pages,
          activeBulletColor: Colors.lightBlue,
          inactiveBulletColor: const Color(0xFF3DA5D9),
          finishCallback: () {
            Get.to(() => const Login_Scree());
          },
        ));
  }
}

List<PageModel> pages = [
  PageModel(
    color: Colors.white,
    imageAssetPath: 'images/On_boarding_1.png',
    title: 'Sana Uygun Yolculuğu Bul',
    bodyColor: const Color(0xFF3DA5D9),
    body: 'Yolcuk ara ve sana uygun olanı bul',
    titleColor: const Color(0xFF3DA5D9),
  ),
  PageModel(
    color: Colors.white,
    imageAssetPath: 'images/message1.png',
    title: 'Sürücüyle İleşime Geç',
    bodyColor: const Color(0xFF3DA5D9),
    body: 'Yolculuğunu paylaşacağın kişiyle iletişme geç',
    titleColor: const Color(0xFF3DA5D9),
  ),
  PageModel(
    color: Colors.white,
    imageAssetPath: 'images/On_boarding_3.png',
    title: 'Ödemeyi Unutma',
    bodyColor: const Color(0xFF3DA5D9),
    body: 'Yolculuk bitiminde ücretini ödemeyi unutma',
    titleColor: const Color(0xFF3DA5D9),
  ),
];
