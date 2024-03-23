import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:innim_bloc/innim_bloc.dart';
import 'package:innim_lib/innim_lib.dart';

import 'package:what_where_when_master/blocs/auth/auth_bloc.dart';
import 'package:what_where_when_master/models/game_data/game_data.dart';
import 'package:what_where_when_master/repositories/repositories.dart';

part 'home_event.dart';
part 'home_state.dart';

/// Home screen business logic.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthBloc auth;
  final GameRepository gameRepository;

  HomeBloc(this.auth, this.gameRepository) : super(const HomeInitial()) {
    onBlocEvent(_mapEventToState);
  }

  Stream<HomeState> _mapEventToState(HomeEvent event) async* {
    if (event is HomeStarted) {
      yield* _mapStartedToState(event);
    } else {
      debugAssertUnhandledEvent(event);
    }
  }

  Stream<HomeState> _mapStartedToState(HomeStarted event) async* {
    await for (final state in auth.stream) {
      if (state is! AuthSignInSuccess) {
        yield const HomeSignInRequired();
      } else {
        break;
      }
    }

    yield const HomeLoadInProgress();

    final res = await gameRepository.getList();

    if (res.isValue) {
      yield HomeLoadSuccess(res.asValue!.value);
    } else {
      // TODO: process error
    }
  }
}
