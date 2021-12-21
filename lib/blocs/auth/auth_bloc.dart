import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:innim_lib/innim_lib.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseAuth _auth;
  StreamSubscription<User> _authSubscription;

  AuthBloc() : super(const AuthInitial());

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthAppStarted) {
      yield* _mapAppStartedToState(event);
    } else if (event is AuthSignedIn) {
      yield* _mapSignedInToState(event);
    } else if (event is AuthSignedOut) {
      yield* _mapSignedOuyToState(event);
    } else {
      debugAssertUnhandledEvent(event);
    }
  }

  Stream<AuthState> _mapAppStartedToState(AuthAppStarted event) async* {
    if (state is! AuthInitial) return;

    _auth = FirebaseAuth.instance;

    final user = _auth.currentUser;
    if (user != null) {
      yield AuthSignInSuccess(user);
    } else {
      yield const AuthSignInInProgress();

      try {
        final userCredential = await FirebaseAuth.instance.signInAnonymously();

        if (userCredential?.user != null) {
          yield AuthSignInSuccess(userCredential?.user);
        } else {
          yield const AuthSignOutSuccess();
        }
      } catch (e) {
        // logError('Anonymous sign in failed: $e');
        yield const AuthSignOutSuccess();
      }
    }

    _authSubscription = _auth.authStateChanges().listen((user) {
      if (user == null) {
        signedOut();
      } else {
        signedIn(user);
      }
    });
  }

  Stream<AuthState> _mapSignedInToState(AuthSignedIn event) async* {
    yield AuthSignInSuccess(event.user);
  }

  Stream<AuthState> _mapSignedOuyToState(AuthSignedOut event) async* {
    yield const AuthSignOutSuccess();
  }
}
