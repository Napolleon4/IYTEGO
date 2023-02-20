import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'List_of_trips.dart';
import 'Services/Calculate.dart';

class Search_page extends StatefulWidget {
  const Search_page({Key? key}) : super(key: key);

  @override
  State<Search_page> createState() => _Search_pageState();
}

class _Search_pageState extends State<Search_page> {
  @override
  final _formKey = GlobalKey<FormState>();
  TimeOfDay _time = TimeOfDay.now();
  TextEditingController _nerden = TextEditingController();
  TextEditingController _nereye = TextEditingController();
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();
  @override
  var _selectedTime;
  var _selectedDate;

  void onTimeChanged(newTime) {
    setState(() {
      _time = newTime;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFF3DA5D9), width: 2)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, color: Colors.blue),
                          Text(
                            "YOLCULUK BUL",
                            style: GoogleFonts.montserrat(
                                color: Color(0xFF3DA5D9), fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 40),
                        child: TypeAheadFormField(
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                return 'Lütfen  Lokasyon seçiniz';
                              }
                              return null;
                            },
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: _nerden,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: FaIcon(
                                    Icons.gps_not_fixed,
                                    color: Color(0xFF3DA5D9),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: UnderlineInputBorder(),
                                labelText: 'Nerden',
                              ),
                            ),
                            onSuggestionSelected: (suggestion) {
                              setState(() {
                                _nerden.text = suggestion;
                              });
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.locationArrow,
                                  color: Color(0xFF3DA5D9),
                                ),
                                title: Text(
                                  suggestion,
                                  selectionColor: Color(0xFF3DA5D9),
                                  style: GoogleFonts.montserrat(),
                                ),
                              );
                            },
                            suggestionsCallback: (suggestion) {
                              return _kOptions;
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 40),
                        child: TypeAheadFormField(
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                return 'Lütfen  Lokasyon seçiniz';
                              }
                              return null;
                            },
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: _nereye,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: FaIcon(
                                    Icons.place,
                                    color: Color(0xFF3DA5D9),
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
                                leading: Icon(
                                  FontAwesomeIcons.locationArrow,
                                  color: Color(0xFF3DA5D9),
                                ),
                                title: Text(
                                  suggestion,
                                  selectionColor: Color(0xFF3DA5D9),
                                  style: GoogleFonts.montserrat(),
                                ),
                              );
                            },
                            suggestionsCallback: (suggestion) {
                              return _kOptions;
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                              onPressed: () async {
                                _selectedDate = await showDatePicker(
                                  context: context,
                                  initialDatePickerMode: DatePickerMode.day,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2023),
                                  lastDate: DateTime(2026),
                                );
                                print(" Date Day: $_selectedDate");
                              },
                              icon: Icon(Icons.date_range),
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
                                print(" Time :  $_selectedTime");
                              },
                              icon: Icon(FontAwesomeIcons.clock, size: 20),
                              label: Text(
                                "Saat",
                                style: GoogleFonts.montserrat(),
                              )),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: (() => {
                              if (_formKey.currentState!.validate())
                                {
                                  if (_selectedDate == null)
                                    {
                                      Get.snackbar("Tarih Boş Bırakılamaz",
                                          "Lütfen Tarih Giriniz",
                                          backgroundColor: Colors.blue,
                                          snackPosition: SnackPosition.TOP,
                                          colorText: Colors.white)
                                    }
                                  else
                                    {
                                      Get.to(
                                          () => List_of_trips(
                                                date_:
                                                    Calculator.datetimetoString(
                                                        _selectedDate),
                                                nereye_: _nereye.text
                                                    .toString()
                                                    .trim(),
                                                nerden_: _nerden.text
                                                    .toString()
                                                    .trim(),
                                              ),
                                          transition: Transition.cupertino,
                                          duration: Duration(seconds: 1))
                                    }
                                }
                            }),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(40, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        child: Text(
                            "                        BUL                        ",
                            style: GoogleFonts.montserrat(
                                color: Colors.white, fontSize: 20)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> _kOptions = <String>[
  "İYTE",
  "Gülbahçe",
  "Urla",
  "F.Altay",
];
