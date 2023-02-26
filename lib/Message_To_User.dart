import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Main_Screen.dart';
import 'package:flutter_application_1/Messages_Page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'message_textfield.dart';
import 'single_message.dart';

class Message_To_User extends StatefulWidget {
  String name;
  String surname;
  String uid;
  String photo;

  Message_To_User(
      {super.key,
      required this.name,
      required this.surname,
      required this.uid,
      required this.photo});

  @override
  State<Message_To_User> createState() => _Message_To_UserState();
}

class _Message_To_UserState extends State<Message_To_User> {
  @override
  final currentuser = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(currentuser.currentUser!.uid)
                    .collection('messages')
                    .doc(widget.uid)
                    .collection('chats')
                    .orderBy("date", descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length < 1) {
                      return Center(
                        child: Text("Say Hi"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isMe = snapshot.data.docs[index]['senderId'] ==
                              currentuser.currentUser!.uid;

                          DocumentSnapshot messageId =
                              snapshot.data.docs[index];
                          return InkWell(
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      content: Text(
                                        "Mesaj silinsin mi ?",
                                        style: GoogleFonts.montserrat(
                                            color: Colors.grey),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "İptal",
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              if (isMe == true) {
                                                FirebaseFirestore.instance
                                                    .collection("Users")
                                                    .doc(currentuser
                                                        .currentUser!.uid)
                                                    .collection('messages')
                                                    .doc(widget.uid)
                                                    .collection('chats')
                                                    .doc(messageId.id)
                                                    .delete()
                                                    .then((value) =>
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .doc(widget.uid)
                                                            .collection(
                                                                'messages')
                                                            .doc(currentuser
                                                                .currentUser!
                                                                .uid)
                                                            .collection('chats')
                                                            .doc(messageId.id)
                                                            .delete()
                                                            .then((value) =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop()));
                                              } else {
                                                FirebaseFirestore.instance
                                                    .collection("Users")
                                                    .doc(currentuser
                                                        .currentUser!.uid)
                                                    .collection('messages')
                                                    .doc(widget.uid)
                                                    .collection('chats')
                                                    .doc(messageId.id)
                                                    .delete()
                                                    .then((value) =>
                                                        Navigator.of(context)
                                                            .pop());
                                              }
                                            },
                                            child: (isMe == true)
                                                ? Text(
                                                    "Herkesten Sil",
                                                  )
                                                : Text(
                                                    "Benden Sil",
                                                  )),
                                      ],
                                    );
                                  });
                            },
                            child: SingleMessage(
                                message: snapshot.data.docs[index]['message'],
                                isMe: isMe),
                          );
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          )),
          MessageTextField(currentuser.currentUser!.uid, widget.uid,
              widget.name, widget.surname, widget.photo),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFD3DA5D9),
        titleSpacing: 55,
        leadingWidth: 90,
        elevation: 0,
        actions: [
          SizedBox(
            width: 8,
          )
        ],
        title: Row(
          children: [
            Text(widget.name),
            SizedBox(
              width: 8,
            ),
            Text(widget.surname),
          ],
        ),
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.to(() => Messages_Page(),
                      transition: Transition.cupertino,
                      duration: Duration(seconds: 1));
                },
                icon: Icon(Icons.arrow_back_rounded)),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: CircleAvatar(
                          radius: 150,
                          backgroundImage: NetworkImage(widget.photo),
                        ),
                      );
                    });
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.photo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
