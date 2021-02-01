class UserModel {
  final String username;
  final String uid;

  UserModel(this.uid, this.username);

  @override
  String toString() {
    return username;
  }
}
