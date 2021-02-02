import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:now_talk/components/error.dart';
import 'package:now_talk/components/loading.dart';
import 'package:now_talk/models/group.dart';
import 'package:now_talk/scoped_model/main-model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:math' as math;

class Chat extends StatefulWidget {
  final GroupModel group;

  Chat({Key key, GroupModel this.group}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _textCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    MainModel model = ScopedModel.of(context);
    model.loadChat(widget.group);
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, MainModel model) {
      if (!model.isAuthenticated) {
        return ErrorScreen();
      } else if (model.isChatLoading) {
        return LoadingScreen();
      }

      final feed = model.chat.messages.reversed.map<Widget>(
        (msg) => Align(
          alignment: msg.isMe ? Alignment.bottomRight : Alignment.bottomLeft,
          child: Bubble(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(msg.content),
            ),
            radius: Radius.circular(100),
            margin: BubbleEdges.only(bottom: 25, right: 10, left: 10),
            nip: msg.isMe ? BubbleNip.rightBottom : BubbleNip.leftBottom,
            color: msg.isMe ? Colors.white : Color.fromRGBO(235, 199, 255, 1.0),
          ),
        ),
      );

      const double buttonWidth = 50;
      const double barPadding = 10;
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.group.getName(model.user.uid)),
        ),
        body: Stack(
          children: [
            ListView(
              children: <Widget>[SizedBox(height: 60)] + feed.toList(),
              reverse: true,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black.withAlpha(80))],
                ),
                child: Padding(
                  padding: EdgeInsets.all(barPadding),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - buttonWidth - barPadding * 3,
                        child: TextField(
                          controller: _textCtrl,
                          onEditingComplete: () => handleSubmit(model),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Enter messsage...',
                          ),
                        ),
                      ),
                      SizedBox(width: barPadding),
                      Material(
                        child: Ink(
                          width: buttonWidth,
                          decoration: const ShapeDecoration(
                            color: Colors.purple,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: Transform.rotate(
                              angle: (-35 * math.pi / 180),
                              child: Icon(Icons.send),
                            ),
                            color: Colors.white,
                            onPressed: () => handleSubmit(model),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void handleSubmit(MainModel model) {
    final txt = _textCtrl.text.trim();
    if (txt.length > 0) {
      model.sendMessage(txt, widget.group);
    }
    _textCtrl.clear();
  }
}
