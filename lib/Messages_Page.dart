import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Message_To_User.dart';
import 'package:flutter_application_1/single_message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Main_Screen.dart';

class Messages_Page extends StatefulWidget {
  const Messages_Page({super.key});

  @override
  State<Messages_Page> createState() => _Messages_PageState();
}

class _Messages_PageState extends State<Messages_Page> {
  @override
  final currentuser = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(currentuser.currentUser!.uid)
              .collection('messages')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot mypost = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: ListTile(
                        trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.trash,
                              color: Colors.blue,
                              size: 20,
                            )),
                        onTap: () {
                          Get.to(
                              () => Message_To_User(
                                  name: mypost["name"],
                                  surname: mypost["surname"],
                                  uid: mypost["friend_uid"],
                                  photo: mypost["photo"]),
                              transition: Transition.cupertino,
                              duration: Duration(seconds: 1));
                        },
                        leading: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    content: CircleAvatar(
                                      radius: 150,
                                      backgroundImage:
                                          NetworkImage(mypost["photo"]),
                                    ),
                                  );
                                });
                          },
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(mypost["photo"]),
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(
                              mypost["name"],
                              style: GoogleFonts.montserrat(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              mypost["surname"],
                              style: GoogleFonts.montserrat(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        subtitle: Text(mypost["last_msg"],
                            style: GoogleFonts.montserrat(fontSize: 20)),
                      ),
                    );
                  });
            } else {
              return Text("");
            }
          }),
      appBar: AppBar(
        titleSpacing: 90,
        title: Text(
          "Mesajlarım",
          style: GoogleFonts.montserrat(
              color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.to(Main_Screen(),
                  transition: Transition.cupertino,
                  duration: Duration(seconds: 1));
            },
            icon: Icon(Icons.arrow_back_rounded)),
      ),
    );
  }
}
