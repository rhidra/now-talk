import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:now_talk/models/group.dart';
import 'package:now_talk/models/user.dart';
import 'package:now_talk/scoped_model/main-model.dart';
import 'package:scoped_model/scoped_model.dart';

class Chat extends StatefulWidget {
  final GroupModel group;

  Chat({Key key, GroupModel this.group}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, MainModel model) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.group.getName(model.user.uid)),
        ),
        body: Container(),
      );
    });
  }
}
