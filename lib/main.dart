import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:now_talk/bloc/auth/auth-bloc.dart';
import 'package:now_talk/bloc/auth/auth-event.dart';
import 'package:now_talk/bloc/auth/auth-state.dart';
import 'package:now_talk/screens/contacts/contacts.dart';
import 'package:now_talk/screens/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
      ],
      child: Root(),
    );
  }
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  AuthBloc _auth;

  @override
  void initState() {
    super.initState();
    _auth = BlocProvider.of<AuthBloc>(context);
    _auth.add(LoginAnonymously());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: _auth,
      builder: (BuildContext context, AuthState state) {
        return MaterialApp(
          title: 'Now Talk',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) {
              print('root $state');
              if (state is! Authenticated) {
                return Login();
              } else {
                return Contacts();
              }
            },
          },
        );
      },
    );
  }
}
