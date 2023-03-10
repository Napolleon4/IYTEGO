// ignore_for_file: file_names, must_be_immutable, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/Calculate.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Main_Screen.dart';
import 'Services/Status_Service.dart';

class Add_trip extends StatefulWidget {
  int my_post_number;
  Add_trip({Key? key, required this.my_post_number}) : super(key: key);

  @override
  State<Add_trip> createState() => _Add_tripState();
}

class _Add_tripState extends State<Add_trip> {
  final TextEditingController _nerden = TextEditingController();
  TextEditingController yol = TextEditingController();
  final TextEditingController _nereye = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final currentuser = FirebaseAuth.instance;

  final TimeOfDay _time = TimeOfDay.now();

  final DatePickerController _controller = DatePickerController();

  final DateTime _selectedValue = DateTime.now();
  var _selectedTime;
  var _selectedDate;

  String _TIME = "";

  void onTimeChanged(newTime) {
    setState(() {
      _selectedTime = newTime;

      if (_selectedTime.minute <= 9) {
        _TIME = "${_selectedTime.hour}:0${_selectedTime.minute.toString()}";
      } else {
        _TIME = "${_selectedTime.hour}:${_selectedTime.minute}";
      }
    });
  }

  final Status_Service _status_service = Status_Service();
  final Calculator _calculator = Calculator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xFF3DA5D9),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Form(
          key: _formKey,
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
                            child: ListView(
                              children: [
                                const SizedBox(
                                  height: 150,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 40),
                                  child: TypeAheadFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Lütfen  Lokasyon seçiniz';
                                        }
                                        return null;
                                      },
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        controller: _nerden,
                                        decoration: const InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: FaIcon(
                                              Icons.add_location_alt,
                                              color: Color(0xFF3DA5D9),
                                              size: 32,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: UnderlineInputBorder(),
                                          labelText: 'Nereden',
                                        ),
                                      ),
                                      onSuggestionSelected: (suggestion) {
                                        _nerden.text = suggestion;
                                      },
                                      itemBuilder: (context, suggestion) {
                                        return ListTile(
                                          leading: const Icon(
                                            FontAwesomeIcons.locationArrow,
                                            color: Color(0xFF3DA5D9),
                                          ),
                                          title: Text(
                                            suggestion,
                                            selectionColor:
                                                const Color(0xFF3DA5D9),
                                            style: GoogleFonts.montserrat(),
                                          ),
                                        );
                                      },
                                      suggestionsCallback: (suggestion) {
                                        return _kOptions;
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 40),
                                  child: TypeAheadFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Lütfen  Lokasyon seçiniz';
                                        }
                                        return null;
                                      },
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        controller: _nereye,
                                        decoration: const InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: FaIcon(
                                              Icons.add_location_alt,
                                              color: Color(0xFF3DA5D9),
                                              size: 32,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: UnderlineInputBorder(),
                                          labelText: 'Nereye',
                                        ),
                                      ),
                                      onSuggestionSelected: (suggestion) {
                                        _nereye.text = suggestion;
                                      },
                                      itemBuilder: (context, suggestion) {
                                        return ListTile(
                                          leading: const Icon(
                                            FontAwesomeIcons.locationArrow,
                                            color: Color(0xFF3DA5D9),
                                          ),
                                          title: Text(
                                            suggestion,
                                            selectionColor:
                                                const Color(0xFF3DA5D9),
                                            style: GoogleFonts.montserrat(),
                                          ),
                                        );
                                      },
                                      suggestionsCallback: (suggestion) {
                                        return _kOptions;
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 40),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _price,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Lütfen Ücret Giriniz';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.turkishLiraSign,
                                          color: Color(0xFF3DA5D9),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: UnderlineInputBorder(),
                                      labelText: 'Ücret',
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton.icon(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: TextFormField(
                                                      controller: yol,
                                                      maxLines: 2,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  "Örn: Otabanı kullanıcam...")),
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Güzergah Bilgisi",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                color: Colors
                                                                    .blue),
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
                                        icon: const Icon(Icons.info_outline),
                                        label: Text(
                                          "Güzergah",
                                          style: GoogleFonts.montserrat(),
                                        )),
                                    TextButton.icon(
                                        onPressed: () async {
                                          _selectedDate = await showDatePicker(
                                            context: context,
                                            initialDatePickerMode:
                                                DatePickerMode.day,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2023),
                                            lastDate: DateTime(2026),
                                          );
                                        },
                                        icon: const Icon(Icons.date_range),
                                        label: Text("Tarih",
                                            style: GoogleFonts.montserrat())),
                                    TextButton.icon(
                                        onPressed: () async {
                                          _selectedTime =
                                              await Navigator.of(context).push(
                                            showPicker(
                                              context: context,
                                              value: _time,
                                              iosStylePicker: true,
                                              onChange: onTimeChanged,
                                            ),
                                          );
                                          print(" Time :  $_TIME");
                                        },
                                        icon: const Icon(FontAwesomeIcons.clock,
                                            size: 20),
                                        label: Text(
                                          "Saat",
                                          style: GoogleFonts.montserrat(),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 34.0),
                                  child: ElevatedButton(
                                    onPressed: (() async => {
                                          if (_formKey.currentState!.validate())
                                            {
                                              if (_selectedDate == null)
                                                {
                                                  Get.snackbar(
                                                      "Tarih Boş Bırakılamaz",
                                                      "Lütfen Tarih Giriniz",
                                                      backgroundColor:
                                                          Colors.blue,
                                                      snackPosition:
                                                          SnackPosition.TOP,
                                                      colorText: Colors.white)
                                                }
                                              else if (_selectedTime == null)
                                                {
                                                  Get.snackbar(
                                                      "Saat Boş Bırakılamaz",
                                                      "Lütfen Saat Giriniz",
                                                      backgroundColor:
                                                          Colors.blue,
                                                      snackPosition:
                                                          SnackPosition.TOP,
                                                      colorText: Colors.white)
                                                }
                                              else
                                                {
                                                  await _status_service
                                                      .addStatus(
                                                          DateTime.now()
                                                              .microsecondsSinceEpoch
                                                              .toString(),
                                                          mypost["Name"],
                                                          mypost["Surname"],
                                                          currentuser
                                                              .currentUser!.uid,
                                                          Calculator
                                                              .datetimetoString(
                                                                  _selectedDate),
                                                          _nerden.text
                                                              .toString()
                                                              .trim(),
                                                          _nereye.text
                                                              .toString()
                                                              .trim(),
                                                          _TIME,
                                                          _price.text
                                                              .toString()
                                                              .trim(),
                                                          widget.my_post_number
                                                              .toString(),
                                                          mypost[
                                                              "Profile_Photo"],
                                                          yol.text
                                                              .toString()
                                                              .tr)
                                                      .then((value) => Get.snackbar(
                                                          "Gönderiniz Başarıyla Yayınlandı",
                                                          "İyi Yolcuklar Dileriz",
                                                          backgroundColor:
                                                              Colors.blue,
                                                          snackPosition:
                                                              SnackPosition.TOP,
                                                          colorText:
                                                              Colors.white)),
                                                  Get.to(const Main_Screen(),
                                                      transition:
                                                          Transition.cupertino,
                                                      duration: const Duration(
                                                          seconds: 1))
                                                }
                                            }
                                        }),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(40, 40),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                    child: Text("YAYINLA",
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white, fontSize: 20)),
                                  ),
                                )
                              ],
                            ),
                          );
                        })),
                  );
                } else if (asyncSnapshot.hasError) {
                  return const CircularProgressIndicator();
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ));
  }
}

List<String> _kOptions = <String>[
  "İYTE",
  "Gülbahçe",
  "Urla",
  "F.Altay",
];
