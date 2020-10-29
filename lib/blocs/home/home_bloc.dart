import 'dart:async';

import 'package:WhatWhereWhenMaster/blocs/auth/auth_bloc.dart';
import 'package:WhatWhereWhenMaster/models/game_data/game_data.dart';
import 'package:WhatWhereWhenMaster/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:innim_lib/innim_lib.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

/// Home screen business logic.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthBloc auth;
  final GameRepository gameRepository;

  HomeBloc(this.auth, this.gameRepository)
      : assert(auth != null),
        assert(gameRepository != null),
        super(const HomeInitial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeStarted) {
      yield* _mapStartedToState(event);
    } else {
      debugAssertUnhandledEvent(event);
    }
  }

  Stream<HomeState> _mapStartedToState(HomeStarted event) async* {
    await for (final state in auth) {
      if (state is! AuthSignInSuccess) {
        yield const HomeSignInRequired();
      } else {
        break;
      }
    }

    yield const HomeLoadInProgress();

    final res = await gameRepository.getList();

    if (res.isValue) {
      yield HomeLoadSuccess(res.asValue.value);
    } else {
      // TODO: process error
    }
  }
}
