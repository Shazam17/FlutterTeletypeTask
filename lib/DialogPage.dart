import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/DialogModel.dart';
import 'package:image_picker/image_picker.dart';

class MyDialogWidget extends StatefulWidget {
  DialogCard dialogCard;

  MyDialogWidget({Key key, this.dialogCard}) : super(key: key);

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

  ChatUser otherUser;
  List<ChatMessage> messages = List<ChatMessage>();

  @override
  void initState() {
    otherUser = ChatUser(
        name: widget.dialogCard.name,
        uid: "25649654",
        avatar: widget.dialogCard.imageUrl);
    List<ChatMessage> messagesTemp = [];
    widget.dialogCard.otherMessages.forEach((element) {
      messagesTemp.add(ChatMessage(
          id: "1",
          user: otherUser,
          text: element.message,
          createdAt: element.time,
          image: element.image));
    });

    widget.dialogCard.myMessages.forEach((element) {
      messagesTemp.add(ChatMessage(
          id: "1", user: user, text: element.message, createdAt: element.time));
    });
    messagesTemp.sort((ChatMessage a, ChatMessage b) =>
       a.createdAt.compareTo(b.createdAt)
    );
    messages.addAll(messagesTemp);
  }

  void onSend(ChatMessage message) async {
    print(message.toJson());
    setState(() {
      messages.add(ChatMessage(
          id: "1", user: user, text: message.text, createdAt: DateTime.now()));
      Future.delayed(Duration(milliseconds: 500), () {
        messages.add(ChatMessage(
            id: "1",
            user: otherUser,
            text: "ответ",
            createdAt: DateTime.now()));
      });
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
                height: 38,
                width: 38,
                child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.dialogCard.imageUrl)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      widget.dialogCard.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black,fontSize: 16),
                    ),
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
            onPressed: () async {},
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
