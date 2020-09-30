import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:innim_lib/innim_lib.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

/// Application business logic.
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppShown) {
      yield* _mapShownToState(event);
    } else if (event is AppLaunchScreenHidden) {
      yield* _mapLaunchScreenHiddenToState(event);
    } else {
      debugAssertUnhandledEvent(event);
    }
  }

  Stream<AppState> _mapShownToState(AppShown event) async* {
    yield AppLoadInProgress();

    await Future.wait([
      Firebase.initializeApp(),
    ]);

    yield AppReadyInProgress();

    // TODO: ability to delay AppReadySuccess

    yield AppReadySuccess();
  }

  Stream<AppState> _mapLaunchScreenHiddenToState(
      AppLaunchScreenHidden event) async* {
    yield AppLoadSuccess();
  }
}
