import 'package:dash_chat/dash_chat.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  const DialogWidget(
      {Key key,
      this.text,
      this.lastMessageTime,
      this.lastMessage,
      this.messagerType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(left: 10, right: 10),
          child: ClipOval(
            child: Image.network("http://ivanbask.com/img/coders.jpg"),
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
              Container(
                child: Text(lastMessage),
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

class MyTestState extends State<MyTestStateFulWidget> {
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
                    itemCount: widget.contactsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
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
                                text: 'Entry ${widget.contactsList[index]}',
                                lastMessage: "lastMessage",
                                messagerType: "WhatsUp",
                                lastMessageTime: "сейчас",
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
