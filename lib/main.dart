import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:now_talk/scoped_model/main-model.dart';
import 'package:now_talk/screens/chat/chat.dart';
import 'package:now_talk/screens/contacts/contacts.dart';
import 'package:now_talk/screens/login/login.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(model: MainModel()));
}

class MyApp extends StatelessWidget {
  final MainModel model;

  MyApp({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: model,
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
      onGenerateRoute: (RouteSettings settings) {
        final routes = <String, WidgetBuilder>{
          '/': (ctx) => Login(),
          '/contacts': (ctx) => Contacts(),
          '/chat': (ctx) => Chat(group: settings.arguments),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
      // routes: {
      //   '/': (BuildContext context) => Login(),
      //   '/contacts': (BuildContext context) => Contacts(),
      //   '/chat': (BuildContext context) => Chat(),
      // },
    );
  }
}
