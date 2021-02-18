part of 'app_bloc.dart';

@immutable
abstract class AppEvent extends Equatable {
  const AppEvent();
}

class AppShown extends AppEvent {
  const AppShown();

  @override
  String toString() {
    return 'AppShown{}';
  }

  @override
  List<Object> get props => [];
}

/// Launch screen is hidden.
class AppLaunchScreenHidden extends AppEvent {
  const AppLaunchScreenHidden();

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'AppLaunchScreenHidden{}';
  }
}

extension AppBlocEventsExtension on AppBloc {
  void shown() => add(const AppShown());

  void launchScreenHidden() => add(const AppLaunchScreenHidden());
}
