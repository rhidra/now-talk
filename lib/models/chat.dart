import 'package:now_talk/models/user.dart';

class ChatModel {
  final String id;
  final List<Message> messages;

  ChatModel(this.id, this.messages);

  ChatModel.fromJson(this.id, data, List<UserModel> users)
      : this.messages = data['messages'].map<Message>((d) => Message.fromJson(d, users)).toList();
}

class Message {
  final String content;
  final DateTime sentAt;
  final UserModel sentBy;

  Message(this.content, this.sentAt, this.sentBy);

  Message.fromJson(data, List<UserModel> users)
      : this.content = data['content'],
        this.sentBy = users.firstWhere((u) => u.uid == data['sentBy']),
        this.sentAt = DateTime.fromMillisecondsSinceEpoch(data['sentAt'].millisecondsSinceEpoch);

  bool get isMe => sentBy.isMe;
}
