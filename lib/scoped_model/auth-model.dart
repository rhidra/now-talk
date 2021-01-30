import 'package:now_talk/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class AuthModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  UserModel _user;
  bool _isLoading = false;
  String _error = '';

  UserModel get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;
  bool get isError => _error.isNotEmpty;
  String get error => _error;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    signInAnonymously();
  }

  void signInAnonymously() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _auth.signInAnonymously();

      DocumentSnapshot user = await _users.doc(_auth.currentUser.uid).get();
      if (!user.exists) {
        _user = null;
      } else {
        final String username = user.data()['username'];
        _user = UserModel(_auth.currentUser.uid, username);
      }
    } catch (e) {
      print(e.toString());
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setUsername(String username) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _users.doc(_auth.currentUser.uid).set({'username': username});
      _user = UserModel(_auth.currentUser.uid, username);
    } catch (e) {
      print(e.toString());
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
