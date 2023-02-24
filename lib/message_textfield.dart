import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;
  final String name;
  final String surname;
  final String photo;

  MessageTextField(
      this.currentId, this.friendId, this.name, this.surname, this.photo);

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  TextEditingController _controller = TextEditingController();
  final currentuser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsetsDirectional.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                suffixIcon: StreamBuilder<QuerySnapshot>(
                  initialData: null,
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .where("uid", isEqualTo: currentuser.currentUser!.uid)
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> snapshotforuser) {
                    if (snapshotforuser.hasData) {
                      return SizedBox(
                        height: 30,
                        width: 30,
                        child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: ((context, index) {
                              DocumentSnapshot usersdata =
                                  snapshotforuser.data!.docs[index];
                              return IconButton(
                                  onPressed: () async {
                                    String message = _controller.text;
                                    _controller.clear();
                                    await FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(widget.currentId)
                                        .collection('messages')
                                        .doc(widget.friendId)
                                        .collection('chats')
                                        .add({
                                      "senderId": widget.currentId,
                                      "receiverId": widget.friendId,
                                      "message": message,
                                      "type": "text",
                                      "date": DateTime.now(),
                                    }).then((value) {
                                      FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(widget.currentId)
                                          .collection('messages')
                                          .doc(widget.friendId)
                                          .set({
                                        'last_msg': message,
                                        'name': widget.name,
                                        'surname': widget.surname,
                                        'photo': widget.photo,
                                        'friend_uid': widget.friendId
                                      });
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(widget.friendId)
                                        .collection('messages')
                                        .doc(widget.currentId)
                                        .collection("chats")
                                        .add({
                                      "senderId": widget.currentId,
                                      "receiverId": widget.friendId,
                                      "message": message,
                                      "type": "text",
                                      "date": DateTime.now(),
                                    }).then((value) {
                                      FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(widget.friendId)
                                          .collection('messages')
                                          .doc(widget.currentId)
                                          .set({
                                        "last_msg": message,
                                        'name': usersdata["Name"],
                                        'surname': usersdata["Surname"],
                                        'photo': usersdata["Profile_Photo"],
                                        'friend_uid': widget.currentId
                                      });
                                    });
                                  },
                                  icon: Icon(Icons.send_rounded));
                            })),
                      );
                    } else {
                      return Text("");
                    }
                  },
                ),
                hintText: "Merhaba",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25))),
          )),
        ],
      ),
    );
  }
}
