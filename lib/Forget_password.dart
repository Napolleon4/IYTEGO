// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login_Screen.dart';
import 'Services/Auth.dart';
import 'Signup.dart';

class Forget_password extends StatefulWidget {
  const Forget_password({Key? key}) : super(key: key);

  @override
  State<Forget_password> createState() => _Forget_passwordState();
}

class _Forget_passwordState extends State<Forget_password> {
  @override
  TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Auth _authservice = Auth();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Image.asset("images/Question.png"),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 40),
                  child: TextFormField(
                    controller: _email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen İYTE Mailinizi Giriniz';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: FaIcon(
                          Icons.mail,
                          color: Color(0xFF3DA5D9),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'İYTE Mailiniz',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(40, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    primary: Colors.white,
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  onPressed: (() => {
                        if (_formKey.currentState!.validate())
                          {
                            Future(() async {
                              await _authservice
                                  .resetPassword(
                                    _email.text.toString().trim(),
                                  )
                                  .then((value) => Get.snackbar(
                                      "Pease Check Your E-Mail",
                                      "We have send your password reset link",
                                      backgroundColor: Colors.white,
                                      snackPosition: SnackPosition.TOP,
                                      colorText: Colors.blue));
                              Get.to(() => Login_Scree(),
                                  transition: Transition.cupertino,
                                  duration: Duration(seconds: 1));
                            })
                          }
                      }),
                  child: Text(
                      "                      Gönder                     ",
                      style: GoogleFonts.montserrat(
                          color: Color(0xFF3DA5D9), fontSize: 20)),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(
                      Login_Scree(),
                      transition: Transition.cupertino,
                      duration: Duration(seconds: 1),
                    );
                  },
                  child: Text(
                    "Giriş Yap",
                    style: GoogleFonts.montserrat(fontSize: 17),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
