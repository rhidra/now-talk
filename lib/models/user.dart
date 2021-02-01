import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String username;
  final String uid;

  FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel(this.uid, this.username);

  @override
  String toString() {
    return username;
  }

  bool get isMe => _auth.currentUser.uid == uid;
}
