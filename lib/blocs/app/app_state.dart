part of 'app_bloc.dart';

@immutable
abstract class AppState extends Equatable {
  const AppState();
}

class AppInitial extends AppState {
  const AppInitial();

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'AppInitial{}';
  }
}

class AppLoadInProgress extends AppState {
  const AppLoadInProgress();

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'AppLoadInProgress{}';
  }
}

/// App is ready, but you can do some preparations
/// before it goes to [AppLoadSuccess].
class AppReadyInProgress extends AppState {
  const AppReadyInProgress();

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'AppReadyInProgress{}';
  }
}

/// All preparation is done.
///
/// Now you should hide a launch screen and
/// and [AppLaunchScreenHidden] event.
class AppReadySuccess extends AppState {
  const AppReadySuccess();

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'AppReadySuccess{}';
  }
}

class AppLoadSuccess extends AppState {
  const AppLoadSuccess();

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'AppLoadSuccess{}';
  }
}
