import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:now_talk/bloc/auth/auth-event.dart';
import 'package:now_talk/bloc/auth/auth-state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:now_talk/models/user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  AuthState get initialState => Unauthenticated();

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginAnonymously) {
      yield* _loginAnonymously(event);
    }
    if (event is SetUsername) {
      yield* _setUsername(event);
    }
  }

  Stream<AuthState> _loginAnonymously(AuthEvent event) async* {
    yield AuthLoading();
    try {
      await auth.signInAnonymously();

      DocumentSnapshot user = await users.doc(auth.currentUser.uid).get();
      if (!user.exists) {
        yield AnonymouslyAuthenticated();
      } else {
        final String username = user.data()['username'];
        yield Authenticated(UserModel(auth.currentUser.uid, username));
      }
    } catch (e) {
      print(e.toString());
      yield AuthError();
    }
  }

  Stream<AuthState> _setUsername(SetUsername event) async* {
    yield AuthLoading();
    await users.doc(auth.currentUser.uid).set({'username': event.username});
    yield Authenticated(UserModel(auth.currentUser.uid, event.username));
  }
}
