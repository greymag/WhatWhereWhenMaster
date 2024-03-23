import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:innim_bloc/innim_bloc.dart';
import 'package:innim_lib/innim_lib.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late FirebaseAuth _auth;
  StreamSubscription<User?>? _authSubscription;

  AuthBloc() : super(const AuthInitial()) {
    onBlocEvent(_mapEventToState);
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

  Stream<AuthState> _mapEventToState(AuthEvent event) async* {
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

    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      yield AuthSignInSuccess(currentUser);
    } else {
      yield const AuthSignInInProgress();

      try {
        final userCredential = await FirebaseAuth.instance.signInAnonymously();
        final newUser = userCredential.user;

        if (newUser != null) {
          yield AuthSignInSuccess(newUser);
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
