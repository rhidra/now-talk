import 'package:flutter/widgets.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Hello contacts'),
      ),
    );
  }
}
