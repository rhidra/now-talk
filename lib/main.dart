import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:now_talk/bloc/auth/auth-bloc.dart';
import 'package:now_talk/bloc/auth/auth-event.dart';
import 'package:now_talk/bloc/auth/auth-state.dart';
import 'package:now_talk/scoped_model/auth-model.dart';
import 'package:now_talk/screens/contacts/contacts.dart';
import 'package:now_talk/screens/login/login.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(authModel: AuthModel()));
}

class MyApp extends StatelessWidget {
  final AuthModel authModel;

  MyApp({this.authModel});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AuthModel>(
      model: authModel,
      child: Root(),
    );
  }
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Now Talk',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => Login(),
        '/contacts': (BuildContext context) => Contacts(),
      },
    );
  }
}