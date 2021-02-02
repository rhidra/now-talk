import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:now_talk/components/error.dart';
import 'package:now_talk/components/loading.dart';
import 'package:now_talk/scoped_model/main-model.dart';
import 'package:scoped_model/scoped_model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _username = '';

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopedModel>(
      builder: (context, child, MainScopedModel model) {
        if (model.isAuthLoading) {
          return LoadingScreen();
        } else if (model.isAuthError) {
          return ErrorScreen(error: model.authError);
        } else if (model.isAuthenticated) {
          Future.delayed(
            Duration(milliseconds: 1),
            () => Navigator.of(context).pushNamedAndRemoveUntil('/contacts', (route) => false),
          );
          return LoadingScreen();
        } else {
          return _buildUsernameForm(context, model);
        }
      },
    );
  }

  _buildUsernameForm(BuildContext context, MainScopedModel model) {
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
                  shape: const StadiumBorder(),
                  onPressed: () => model.setUsername(_username),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
