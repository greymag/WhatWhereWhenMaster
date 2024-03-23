part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => const [];

  @override
  String toString() => 'AuthInitial()';
}

class AuthSignInInProgress extends AuthState {
  const AuthSignInInProgress();

  @override
  List<Object> get props => const [];

  @override
  String toString() => 'AuthSignInInProgress()';
}

class AuthSignInSuccess extends AuthState {
  final User user;

  const AuthSignInSuccess(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'AuthSignInSuccess(user: $user)';
}

class AuthSignOutInProgress extends AuthState {
  const AuthSignOutInProgress();

  @override
  List<Object> get props => const [];

  @override
  String toString() => 'AuthSignOutInProgress()';
}

class AuthSignOutSuccess extends AuthState {
  const AuthSignOutSuccess();

  @override
  List<Object> get props => const [];

  @override
  String toString() => 'AuthSignOutSuccess()';
}
