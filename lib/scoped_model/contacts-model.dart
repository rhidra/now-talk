import 'package:firebase_core/firebase_core.dart';
import 'package:now_talk/models/group.dart';
import 'package:now_talk/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'auth-model.dart';

class ContactsModel extends AuthModel {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  CollectionReference _groups = FirebaseFirestore.instance.collection('groups');

  bool _isLoading = false;
  String _error = '';
  List<UserModel> _contacts = [];
  List<GroupModel> _contactsGroups = [];

  List<UserModel> get contacts => _contacts;
  List<GroupModel> get groups => _contactsGroups;
  bool get isContactsLoading => _isLoading;
  bool get isContactsError => _error.isNotEmpty;
  String get contactsError => _error;

  @override
  void addListener(VoidCallback listener) async {
    await super.addListener(listener);
    loadGroups();
  }

  void loadContacts() async {
    _isLoading = true;
    notifyListeners();

    QuerySnapshot query = await _users.get();
    _contacts = query.docs
        .where((DocumentSnapshot doc) => doc.id != _auth.currentUser.uid)
        .map<UserModel>((DocumentSnapshot doc) => UserModel(doc.id, doc['username']))
        .toList();

    _isLoading = false;
    notifyListeners();
  }

  void loadGroups() async {
    _isLoading = true;
    notifyListeners();

    // Load contacts
    if (_contacts.length == 0) {
      await loadContacts();
    }

    // Load groups
    QuerySnapshot query = await _groups.where('users', arrayContains: _auth.currentUser.uid).get();
    _contactsGroups = query.docs
        .map<GroupModel>((DocumentSnapshot doc) => GroupModel.fromUIDs(
            doc.id, doc['users'].cast<String>().toList(), _contacts + [this.user]))
        .toList();

    // Create missing group by comparing with the contacts
    await Future.wait(_contacts.map((contact) async {
      if (_contactsGroups.any((group) => group.users.any((u) => u.uid == contact.uid))) {
        return;
      }

      final DocumentReference g = await _groups.add({
        'users': [this.user.uid, contact.uid]
      });
      _contactsGroups.add(GroupModel(g.id, [this.user, contact]));
    }));

    _isLoading = false;
    notifyListeners();
  }
}
