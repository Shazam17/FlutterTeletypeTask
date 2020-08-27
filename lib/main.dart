import 'package:dash_chat/dash_chat.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/DialogPage.dart';
import 'package:flutter_app/DialogModel.dart';
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
  final Widget lastMessage;
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          height: 50,
          width: 50,
          margin: EdgeInsets.only(left: 10, right: 10),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
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
              Container(width: 240, child: lastMessage),
              Container(
                decoration: BoxDecoration(
                    color: messagerType == "WHATSAPP"
                        ? Colors.amberAccent
                        : Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                padding: EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
                child: Text(
                  messagerType,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black38),
                ),
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

  Future<List<DialogCard>> search(String search) async {
    List<DialogCard> cards = [];
    list.forEach((element) {
      if (element.name.contains(search)) {
        cards.add(element);
      }
    });
    debugPrint(cards.length.toString());
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EmptyAppBar(),
        body: Align(
          alignment: Alignment.topLeft,
          child: SafeArea(
            minimum: const EdgeInsets.only(top: 16.0),
            child: new Column(
              children: [
                Container(
                  child: DropDownHeader(),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 80,
                  child: SearchBar<DialogCard>(
                    onSearch: search,
                    onItemFound: (DialogCard post, int index) {
                      return ListTile(
                        title: Text(post.name),
                        subtitle: Text("text"),
                      );
                    },
                    hintText: "Поиск",
                    searchBarPadding: EdgeInsets.only(left: 30, right: 30),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: list != null ? list.length : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyDialogWidget(
                                          dialogCard: list[index],
                                        )));
                          },
                          child: Center(
                            child: Container(
                                padding: EdgeInsets.only(right: 7),
                                margin: EdgeInsets.only(top: 15),
                                height: 60,
                                child: DialogWidget(
                                  text: list[index].name,
                                  lastMessage: list[index]
                                          .myMessages
                                          .last
                                          .time
                                          .isAfter(list[index]
                                              .otherMessages
                                              .last
                                              .time)
                                      ? RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: "Вы:",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            TextSpan(
                                              text: list[index]
                                                  .myMessages
                                                  .last
                                                  .message,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ]))
                                      : Text(
                                          list[index]
                                              .otherMessages
                                              .last
                                              .message,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  messagerType: list[index].messagerType,
                                  lastMessageTime: list[index].myMessages.last.time.hour.toString() + ":" + list[index].myMessages.last.time.minute.toString(),
                                  imageUrl: list[index].imageUrl,
                                )),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
