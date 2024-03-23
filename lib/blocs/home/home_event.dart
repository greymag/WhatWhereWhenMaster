part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeStarted extends HomeEvent {
  const HomeStarted();

  @override
  List<Object> get props => const [];
}

extension HomeBlocEventsExtension on HomeBloc {
  void started() => add(const HomeStarted());
}
