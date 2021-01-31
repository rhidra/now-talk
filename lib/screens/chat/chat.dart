import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:now_talk/models/user.dart';

class Chat extends StatefulWidget {
  final UserModel user;

  Chat({Key key, UserModel this.user}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username),
      ),
      body: Container(),
    );
  }
}
