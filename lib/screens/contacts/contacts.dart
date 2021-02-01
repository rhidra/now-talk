import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:now_talk/components/error.dart';
import 'package:now_talk/components/loading.dart';
import 'package:now_talk/models/group.dart';
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
        } else if (model.isContactsLoading) {
          return LoadingScreen();
        }

        final list = model.groups.map((GroupModel group) => _buildGroupCard(context, model, group));

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

  Widget _buildGroupCard(BuildContext context, MainModel model, GroupModel group) {
    return Card(
      child: InkWell(
        splashColor: Colors.purpleAccent,
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              group.getName(model.user.uid),
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        onTap: () => Navigator.of(context).pushNamed('/chat', arguments: group),
      ),
    );
  }
}
