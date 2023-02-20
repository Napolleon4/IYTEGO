// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';

import 'Login_Screen.dart';
import 'Step_image_name.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  int activeStep = 0;
  final currentuser = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String name = "";
  String surname = "";
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset("images/Photo3.png"),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
              child: TextFormField(
                validator: (value) {
                  if (!value!.contains("@") || value.isEmpty) {
                    return 'Lütfen İYTE Mail adresinizi giriniz';
                  }
                  return null;
                },
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  icon: const FaIcon(
                    Icons.mail_outline,
                    color: Color(0xFF3DA5D9),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'İYTE Mailiniz',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Şifre Giriniz';
                  }
                  return null;
                },
                controller: _password,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  icon: const FaIcon(
                    Icons.lock,
                    color: Color(0xFF3DA5D9),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Şifre",
                ),
              ),
            ),
            IconStepper(
              activeStep: 0,
              activeStepColor: const Color(0xFF3DA5D9),
              icons: const [
                Icon(
                  Icons.people,
                ),
                Icon(Icons.image),
                Icon(Icons.flag)
              ],
              onStepReached: (index) async {
                if (_formKey.currentState!.validate()) {
                  Get.to(() => Step_image_name(
                        email: _email.text.toString().trim(),
                        password: _password.text.toString().trim(),
                      ));
                }
              },
            ),
            TextButton(
              onPressed: () {
                Get.to(
                  () => const Login_Scree(),
                  transition: Transition.cupertino,
                  duration: const Duration(seconds: 1),
                );
              },
              child: const Text(
                "Giriş Yap",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ]))),
    );
  }
}
