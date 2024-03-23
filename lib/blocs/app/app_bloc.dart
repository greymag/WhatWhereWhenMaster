import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:innim_bloc/innim_bloc.dart';
import 'package:innim_lib/innim_lib.dart';

part 'app_event.dart';
part 'app_state.dart';

/// Application business logic.
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppInitial()) {
    onBlocEvent(_mapEventToState);
  }

  Stream<AppState> _mapEventToState(AppEvent event) async* {
    if (event is AppShown) {
      yield* _mapShownToState(event);
    } else if (event is AppLaunchScreenHidden) {
      yield* _mapLaunchScreenHiddenToState(event);
    } else {
      debugAssertUnhandledEvent(event);
    }
  }

  Stream<AppState> _mapShownToState(AppShown event) async* {
    yield const AppLoadInProgress();

    await Future.wait([
      Firebase.initializeApp(),
    ]);

    yield const AppReadyInProgress();

    // TODO: ability to delay AppReadySuccess

    yield const AppReadySuccess();
  }

  Stream<AppState> _mapLaunchScreenHiddenToState(
    AppLaunchScreenHidden event,
  ) async* {
    yield const AppLoadSuccess();
  }
}
