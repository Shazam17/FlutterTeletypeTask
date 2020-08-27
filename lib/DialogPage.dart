import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class MyDialogWidget extends StatefulWidget {
  MyDialogWidget({Key key}) : super(key: key);

  @override
  MyDialogPageWidgetState createState() {
    return MyDialogPageWidgetState();
  }
}

class MyDialogPageWidgetState extends State<MyDialogWidget> {
  final ChatUser user = ChatUser(
    name: "Fayeed",
    firstName: "Fayeed",
    lastName: "Pawaskar",
    uid: "12345678",
    avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
  );

  final ChatUser otherUser = ChatUser(
    name: "Mrfatty",
    uid: "25649654",
  );
  List<ChatMessage> messages = [
    ChatMessage(
        id: "1",
        user: ChatUser(
          name: "Fayeed",
          firstName: "Fayeed",
          lastName: "Pawaskar",
          uid: "12345678",
          avatar:
          "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
        ),
        text: "Text")
  ];

  void onSend(ChatMessage message) async {
    print(message.toJson());
    setState(() {
      messages.add(ChatMessage(id: "1", user: user, text: message.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 45,
                padding: EdgeInsets.all(5),
                child: ClipOval(
                  child: Image.network("http://ivanbask.com/img/coders.jpg"),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Покупатель",
                    style: TextStyle(color: Colors.black),
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
                    child: Text(
                      "WhatsUp",
                      style: TextStyle(fontSize: 12),
                    ),
                    color: Colors.amberAccent,
                  )
                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
          child: DashChat(
            onSend: onSend,
            sendOnEnter: true,
            trailing: [
              IconButton(
                icon: Icon(Icons.photo_album),
              ),
              IconButton(
                icon: Icon(Icons.add),
              )
            ],
            messages: messages,
            user: user,
            inputDecoration: InputDecoration(
              hintText: "Сообщение",
              fillColor: Colors.grey,
            ),
            inputContainerStyle: BoxDecoration(

                border: Border.symmetric(
                    vertical: BorderSide(width: 1, color: Colors.grey))),
          )),
    );
  }
}