import 'package:now_talk/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _chats = FirebaseFirestore.instance.collection('chats');

  bool _isLoading = false;
  String _error = '';
  List<UserModel> _contacts = [];

  List<UserModel> get contacts => _contacts;
  bool get isLoading => _isLoading;
  bool get isError => _error.isNotEmpty;
  String get error => _error;

  void loadContacts() async {
    // _isLoading = true;
    // notifyListeners();

    // QuerySnapshot query = await _users.get();
    // query.docs.forEach((DocumentSnapshot doc) {
    //   if (doc.id != _auth.currentUser.uid) {
    //     contacts.add(UserModel(doc.id, doc['username']));
    //   }
    // });

    // _isLoading = false;
    // notifyListeners();
  }
}
