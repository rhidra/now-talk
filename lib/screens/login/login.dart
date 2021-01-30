import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:now_talk/bloc/auth/auth-bloc.dart';
import 'package:now_talk/bloc/auth/auth-event.dart';
import 'package:now_talk/bloc/auth/auth-state.dart';
import 'package:now_talk/components/error.dart';
import 'package:now_talk/components/loading.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _username = '';
  AuthBloc _auth;

  @override
  void initState() {
    super.initState();
    _auth = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: _auth,
      builder: (BuildContext context, AuthState state) {
        print('login $state');
        if (state is AuthLoading) {
          return LoadingScreen();
        } else if (state is Unauthenticated) {
          return ErrorScreen(error: 'Unauthenticated');
        } else if (state is AnonymouslyAuthenticated) {
          return _buildUsernameForm(context);
        } else if (state is Authenticated) {
          return ErrorScreen(error: 'You will be redirected...');
        }
        return ErrorScreen();
      },
    );
  }

  _buildUsernameForm(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.blue],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 10),
                Icon(Icons.person_search, size: 150, color: Colors.white),
                SizedBox(height: 30),
                Text(
                  'Hey there ! Before going further, can we ask for your username ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 50),
                TextField(
                  onChanged: (text) => setState(() => _username = text),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(25),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter your favorite username !',
                  ),
                ),
                const SizedBox(height: 40),
                RawMaterialButton(
                  fillColor: Colors.purple[800],
                  splashColor: Colors.purpleAccent,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20, left: 40, right: 40),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Text(
                          'Let\'s Talk !',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    _auth.add(SetUsername(_username));
                  },
                  shape: const StadiumBorder(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
