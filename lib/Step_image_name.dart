// ignore_for_file: unnecessary_null_comparison, file_names, must_be_immutable, camel_case_types, non_constant_identifier_names

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'Services/Auth.dart';
import 'Services/Users_services.dart';
import 'Signup.dart';
import 'package:image_picker/image_picker.dart';

class Step_image_name extends StatefulWidget {
  String email;
  String password;
  Step_image_name({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<Step_image_name> createState() => _Step_image_nameState();
}

class _Step_image_nameState extends State<Step_image_name> {
  File? _image;
  final currentuser = FirebaseAuth.instance;
  final Auth _auth = Auth();
  final Userservice _userservice = Userservice();
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _surname = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String _Person_PP = "Not Attend";
  String imageUrl = "not attend";

  Future uploadToStoarge(File imageFile) async {
    String path = "${widget.email}-Photo";
    TaskSnapshot uploadTask = await FirebaseStorage.instance
        .ref()
        .child("Photos")
        .child(path)
        .putFile(imageFile);
    imageUrl = await uploadTask.ref.getDownloadURL();
    return imageUrl;
  }

  void getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 40);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        return;
      }
    });

    if (pickedFile != null) {
      _Person_PP = await uploadToStoarge(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    int activeStep = 0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 180),
              Padding(
                padding: const EdgeInsets.only(bottom: 52),
                child: Stack(children: [
                  CircleAvatar(
                    maxRadius: 65,
                    backgroundImage:
                        (_image == null) ? null : FileImage(_image!),
                  ),
                  Positioned(
                    width: 130,
                    height: 130,
                    child: IconButton(
                        iconSize: 40,
                        color: Colors.white,
                        onPressed: () {
                          getImage();
                        },
                        icon: const Icon(
                          FontAwesomeIcons.plus,
                        )),
                  ),
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                child: TextFormField(
                  controller: _name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen İsminizi Girinz';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    icon: const FaIcon(
                      Icons.person,
                      color: Color(0xFF3DA5D9),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'İsminiz',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                child: TextFormField(
                  controller: _surname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen Soy İsminizi Girinz';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    icon: const FaIcon(
                      Icons.person,
                      color: Color(0xFF3DA5D9),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Soy İsminiz",
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              IconStepper(
                  activeStep: activeStep + 1,
                  activeStepColor: const Color(0xFF3DA5D9),
                  onStepReached: (index) {
                    setState(() {
                      activeStep = index;
                      if (activeStep == 0) {
                        Get.to(
                          () => const Signup(),
                          transition: Transition.cupertino,
                          duration: const Duration(seconds: 1),
                        );
                      }
                      if (activeStep == 1) {
                        return;
                      }
                      if (_formKey.currentState!.validate()) {
                        if (activeStep == 2) {
                          _auth
                              .signUp(widget.email, widget.password)
                              .then((value) => _auth.sendEmailVerif())
                              .then((value) => _userservice.addUser(
                                  currentuser.currentUser!.uid,
                                  _name.text.toString().trim(),
                                  _surname.text.toString().trim(),
                                  widget.email,
                                  _Person_PP));
                        }
                      }
                    });
                  },
                  icons: [
                    const Icon(
                      Icons.supervised_user_circle,
                    ),
                    const Icon(FontAwesomeIcons.image),
                    const Icon(Icons.flag),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
