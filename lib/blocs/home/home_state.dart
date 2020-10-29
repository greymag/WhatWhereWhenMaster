part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object> get props => const [];
}

class HomeSignInRequired extends HomeState {
  const HomeSignInRequired();

  @override
  List<Object> get props => const [];
}

class HomeLoadInProgress extends HomeState {
  const HomeLoadInProgress();

  @override
  List<Object> get props => const [];
}

class HomeLoadSuccess extends HomeState {
  final List<GameDataEntry> games;

  const HomeLoadSuccess(this.games);

  @override
  List<Object> get props => [games];
}
