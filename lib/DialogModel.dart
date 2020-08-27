class Message {
  DateTime time;
  String message;
  String image;

  Message({this.time, this.message,this.image});

  factory Message.fromJson(Map<String, dynamic> json) {
    return new Message(
        time: DateTime.parse(json["time"].toString()),
        message: json["message"].toString(),
        image: json["image"].toString());
  }
}

class DialogCard {
  final String name;
  final String lastMessage;
  final String messagerType;
  final String lastMessageDate;
  final String imageUrl;
  final List<Message> myMessages;
  final List<Message> otherMessages;

  factory DialogCard.fromJson(Map<String, dynamic> json) {
    return new DialogCard(
        name: json['name'].toString(),
        lastMessage: json['lastMessage'].toString(),
        messagerType: json['messagerType'].toString(),
        lastMessageDate: json['lastMessageDate'].toString(),
        imageUrl: json['imageUrl'].toString(),
        myMessages: MessagesList.fromJson(json["messages"] as List).messages,
        otherMessages:
            MessagesList.fromJson(json["userMessages"] as List).messages);
  }

  DialogCard(
      {this.name,
      this.lastMessage,
      this.messagerType,
      this.lastMessageDate,
      this.imageUrl,
      this.myMessages,
      this.otherMessages});
}

class MessagesList {
  final List<Message> messages;

  MessagesList({
    this.messages,
  });

  factory MessagesList.fromJson(List<dynamic> parsedJson) {
    List<Message> messages = new List<Message>();
    parsedJson.forEach((element) {
      messages.add(Message.fromJson(element));
    });
    return new MessagesList(
      messages: messages,
    );
  }
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
