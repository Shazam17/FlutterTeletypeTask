import 'package:flappy_search_bar/flappy_search_bar.dart';
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

class MyTestState extends State<MyTestStateFulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      top: true,
      child: new Column(
        children: [
          Container(
            child: Center(
                child: Text(
              "Диалоги",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 29,
                  fontWeight: FontWeight.w500),
            )),
          ),
          Container(
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
                  return Center(
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
