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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopedModel>(
      builder: (context, child, MainScopedModel model) {
        var body;
        if (!model.isAuthenticated) {
          body = ErrorScreen();
        } else if (model.isContactsLoading) {
          body = LoadingScreen();
        }

        final list = model.groups.map((GroupModel group) => _buildGroupCard(context, model, group));
        body = ListView(
          padding: EdgeInsets.all(10),
          children: list.toList(),
        );

        return Scaffold(
          appBar: AppBar(
            title: Text('Now Talk ! - ${model.user.username}'),
          ),
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => model.loadGroups(),
            child: body,
          ),
        );
      },
    );
  }

  Widget _buildGroupCard(BuildContext context, MainScopedModel model, GroupModel group) {
    return Card(
      child: InkWell(
        splashColor: Colors.purpleAccent,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://i.pravatar.cc/100?u=${group.id}'),
          ),
          title: Text(group.name),
          subtitle: Text(group.lastMessage?.content ?? ''),
        ),
        onTap: () => Navigator.of(context).pushNamed('/chat', arguments: group),
      ),
    );
  }
}
