import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:now_talk/components/error.dart';
import 'package:now_talk/components/loading.dart';
import 'package:now_talk/models/user.dart';
import 'package:now_talk/scoped_model/main-model.dart';
import 'package:scoped_model/scoped_model.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, MainModel model) {
        if (!model.isAuthenticated) {
          return ErrorScreen();
        } else if (model.isLoading) {
          return LoadingScreen();
        }

        final list = model.contacts.map(
          (UserModel user) => Card(
            child: InkWell(
              splashColor: Colors.purpleAccent,
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    user.username,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              onTap: () => Navigator.of(context).pushNamed('/chat', arguments: user),
            ),
          ),
        );

        return Scaffold(
          appBar: AppBar(
            title: Text('Now Talk ! - ${model.user.username}'),
          ),
          body: ListView(
            padding: EdgeInsets.all(10),
            children: list.toList(),
          ),
        );
      },
    );
  }
}
