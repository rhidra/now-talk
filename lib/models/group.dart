import 'package:firebase_auth/firebase_auth.dart';
import 'package:now_talk/models/chat.dart';
import 'package:now_talk/models/user.dart';

class GroupModel {
  final String id;
  final List<UserModel> users;
  Message lastMessage = null;

  GroupModel(this.id, this.users);

  GroupModel.fromUIDs(this.id, List<String> uids, List<UserModel> users)
      : this.users = uids
            .map<UserModel>((uid) => users.firstWhere(
                  (u) => u?.uid == uid,
                  orElse: () => UserModel(uid, ''),
                ))
            .toList();

  String get name {
    return users
        .where((u) => u.uid != FirebaseAuth.instance.currentUser?.uid)
        .map((u) => u.username)
        .reduce((s, u) => '$s, $u');
  }
}
