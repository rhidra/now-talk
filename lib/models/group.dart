import 'package:now_talk/models/user.dart';

class GroupModel {
  final String id;
  final List<UserModel> users;

  GroupModel(this.id, this.users);

  GroupModel.fromUIDs(this.id, List<String> uids, List<UserModel> users)
      : this.users = uids.map<UserModel>((uid) => users.firstWhere((u) => u.uid == uid)).toList();
}
