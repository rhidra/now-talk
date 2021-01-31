import 'package:now_talk/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ContactsModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  bool _isLoading = false;
  String _error = '';
  List<UserModel> _contacts = [];

  List<UserModel> get contacts => _contacts;
  bool get isLoading => _isLoading;
  bool get isError => _error.isNotEmpty;
  String get error => _error;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    loadContacts();
  }

  void loadContacts() async {
    _isLoading = true;
    notifyListeners();

    QuerySnapshot query = await _users.get();
    query.docs.forEach((DocumentSnapshot doc) {
      if (doc.id != _auth.currentUser.uid) {
        contacts.add(UserModel(doc.id, doc['username']));
      }
    });

    _isLoading = false;
    notifyListeners();
  }
}
