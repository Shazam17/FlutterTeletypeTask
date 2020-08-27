import 'package:dash_chat/dash_chat.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/DialogPage.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyTestStateFulWidget(title: 'Flutter Demo Home Page'),
    );
  }
}

class DialogWidget extends StatelessWidget {
  final String text;
  final String lastMessageTime;
  final String lastMessage;
  final String messagerType;
  final String imageUrl;

  const DialogWidget(
      {Key key,
      this.text,
      this.lastMessageTime,
      this.lastMessage,
      this.messagerType,
      this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 60,
          width: 60,
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Image.network(imageUrl),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text(
                  text,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
              Container(
                width: 240,
                child: Text(
                  lastMessage,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
                child: Text(messagerType),
                color: Colors.amberAccent,
              )
            ],
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 32),
          child: Text(
            lastMessageTime,
            style: TextStyle(color: Colors.grey),
          ),
        )
      ],
    );
  }
}

class MyTestStateFulWidget extends StatefulWidget {
  MyTestStateFulWidget({Key key, this.title}) : super(key: key);
  final String title;

  final List<String> contactsList = <String>[
    'Contact1',
    'Contact2',
    'Contact3'
  ];

  @override
  MyTestState createState() {
    return MyTestState();
  }
}

class DropDownHeader extends StatefulWidget {
  @override
  DropDownHeaderState createState() {
    return DropDownHeaderState();
  }
}

class DropDownHeaderState extends State<DropDownHeader> {
  int _value = 0;

  Widget getDropDownButton() {
    return Container(
      width: 155.0,
      height: 45,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down),
              value: _value,
              items: [
                DropdownMenuItem(
                  child: Center(
                    child: Text("Диалоги"),
                  ),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Center(
                    child: Text("Непрочитанные"),
                  ),
                  value: 1,
                )
              ],
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              }),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return getDropDownButton();
  }
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

class DialogCard {
  final String name;
  final String lastMessage;
  final String messagerType;
  final String lastMessageDate;
  final String imageUrl;

  factory DialogCard.fromJson(Map<String, dynamic> json) {
    return new DialogCard(
      name: json['name'].toString(),
      lastMessage: json['lastMessage'].toString(),
      messagerType: json['messagerType'].toString(),
      lastMessageDate: json['lastMessageDate'].toString(),
      imageUrl: json['imageUrl'].toString(),
    );
  }

  DialogCard(
      {this.name,
      this.lastMessage,
      this.messagerType,
      this.lastMessageDate,
      this.imageUrl});
}

class DialogCardList {
  final List<DialogCard> dialogs;

  DialogCardList({
    this.dialogs,
  });

  factory DialogCardList.fromJson(List<dynamic> parsedJson) {
    List<DialogCard> dialogs = new List<DialogCard>();
    parsedJson.forEach((element) {
      dialogs.add(DialogCard.fromJson(element));
    });
    return new DialogCardList(
      dialogs: dialogs,
    );
  }
}

class MyTestState extends State<MyTestStateFulWidget> {
  List<DialogCard> list;

  void getDialogsFromLocalJson() {
    loadPeoples().then((data) {
      Map<String, dynamic> decoded = jsonDecode(data);
      List<dynamic> decodedList = decoded["list"] as List;
      setState(() {
        list = DialogCardList.fromJson(decodedList).dialogs;
      });
    });
  }

  Future<String> loadPeoples() async {
    return await rootBundle.loadString("assets/peoples.json");
  }

  MyTestState() {
    getDialogsFromLocalJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EmptyAppBar(),
        body: SafeArea(
          top: true,
          child: new Column(
            children: [
              Container(
                child: DropDownHeader(),
              ),
              Container(
                alignment: Alignment.center,
                height: 80,
                child: SearchBar(
                  hintText: "Поиск",
                  searchBarPadding: EdgeInsets.only(left: 30, right: 30),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyDialogWidget()));
                        },
                        child: Center(
                          child: Container(
                              padding: EdgeInsets.only(right: 7),
                              margin: EdgeInsets.only(top: 15),
                              height: 60,
                              child: DialogWidget(
                                text: list[index].name,
                                lastMessage: list[index].lastMessage,
                                messagerType: list[index].messagerType,
                                lastMessageTime: list[index].lastMessageDate,
                                imageUrl: list[index].imageUrl,
                              )),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
