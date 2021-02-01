import 'package:flutter/cupertino.dart';
import 'package:now_talk/models/chat.dart';
import 'package:now_talk/models/group.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'contacts-model.dart';

class ChatScopedModel extends ContactsScopedModel {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _chatsRef = FirebaseFirestore.instance.collection('chats');

  bool _isLoading = false;
  String _error = '';
  ChatModel _chat = null;

  bool get isChatLoading => _isLoading;
  bool get isChatError => _error.isNotEmpty;
  String get chatError => _error;
  ChatModel get chat => _chat;

  void loadChat(GroupModel group) async {
    _isLoading = true;
    notifyListeners();

    DocumentSnapshot chat = await _chatsRef.doc(group.id).get();

    if (!chat.exists) {
      _chatsRef.doc(group.id).set({'messages': []});
    }

    _chatsRef.doc(group.id).snapshots().listen(
          (snapshot) => handleStream(snapshot, group, null),
          onError: (err) => handleStream(null, null, err),
        );
  }

  void handleStream(DocumentSnapshot snapshot, GroupModel group, dynamic error) {
    _error = '';
    _isLoading = false;

    if (error != null) {
      print('ERROR');
      print(error);
      _error = 'Can\'t get data from server !';
      notifyListeners();
      return;
    }

    _chat = ChatModel.fromJson(group.id, snapshot.data(), group.users);
    notifyListeners();
  }
}
