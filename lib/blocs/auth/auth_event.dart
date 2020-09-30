part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

@immutable
class AuthAppStarted extends AuthEvent {
  const AuthAppStarted();

  @override
  List<Object> get props => const [];

  @override
  String toString() => 'AuthAppStarted()';
}

@immutable
class AuthSignedIn extends AuthEvent {
  final User user;
  const AuthSignedIn(this.user) : assert(user != null);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'AuthSignedIn(user: $user)';
}

@immutable
class AuthSignedOut extends AuthEvent {
  const AuthSignedOut();

  @override
  List<Object> get props => const [];

  @override
  String toString() => 'AuthSignedOut()';
}

extension AuthEventsExtension on AuthBloc {
  void appStarted() => add(const AuthAppStarted());

  void signedIn(User user) => add(AuthSignedIn(user));

  void signedOut() => add(const AuthSignedOut());
}
