import 'package:WhatWhereWhenMaster/application/routes.dart';
import 'package:WhatWhereWhenMaster/application/theme.dart';
import 'package:WhatWhereWhenMaster/blocs/app/app_bloc.dart';
import 'package:WhatWhereWhenMaster/blocs/auth/auth_bloc.dart';
import 'package:WhatWhereWhenMaster/repositories/game/game_firestore_provider.dart';
import 'package:WhatWhereWhenMaster/repositories/repositories.dart';
import 'package:WhatWhereWhenMaster/screens/launch/launch_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:innim_lib/innim_lib.dart';
import 'package:innim_ui/innim_ui.dart';

import 'localization.dart';

class WwwMasterApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  WwwMasterApp({Key key}) : super(key: key) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Bloc.observer = _ApplicationBlocDelegate();
  }

  @override
  Widget build(BuildContext context) {
    return _buildRepositories(
      context,
      child: BlocProvider(
        create: (context) => AppBloc()..shown(),
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state is AppInitial ||
                state is AppLoadInProgress ||
                state is AppReadyInProgress ||
                state is AppReadySuccess) {
              return _buildLaunchApp();
            }

            if (state is AppLoadSuccess) {
              return _buildMainApp(state);
            }

            debugAssertUnknownState(state);
            return LoadingWidget();
          },
        ),
      ),
    );
  }

  Widget _buildRepositories(BuildContext context, {@required Widget child}) {
    assert(context != null);
    assert(child != null);
    // TODO: move to DI
    final gameProvider = GameFirestoreProvider();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GameRepository>(
          create: (context) => GameRepository(gameProvider),
        ),
      ],
      child: child,
    );
  }

  Widget _buildLaunchApp() {
    return _buildApp(
      home: const LaunchScreen(),
    );
  }

  Widget _buildMainApp(AppLoadSuccess state) {
    return _buildApp(
      initialRoute: AppRoutes.home,
      navigatorKey: _navigatorKey,
      onGenerateRoute: _onGenerateRoute,
      builder: (context, child) {
        return _buildGlobalBlocs(
          localizations: AppLocalizations.of(context),
          builder: (context) => child,
        );
      },
    );
  }

  Widget _buildApp({
    Widget home,
    String initialRoute,
    TransitionBuilder builder,
    GlobalKey<NavigatorState> navigatorKey,
    RouteFactory onGenerateRoute,
    List<NavigatorObserver> navigatorObservers = const <NavigatorObserver>[],
  }) {
    return MaterialApp(
      // TODO: title: '',
      theme: WwwMasterTheme.theme,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: _createLocalization(),
      navigatorKey: navigatorKey,
      onGenerateRoute: onGenerateRoute,
      navigatorObservers: navigatorObservers,
      builder: builder,
      initialRoute: initialRoute,
      home: home,
    );
  }

  Widget _buildGlobalBlocs({
    @required WidgetBuilder builder,
    @required AppLocalizations localizations,
  }) {
    assert(localizations != null);
    assert(builder != null);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..appStarted(),
          lazy: false,
        ),
      ],
      child: Builder(
        builder: builder,
      ),
    );
  }

  /// Создает список делегатов локализации для приложения.
  List<LocalizationsDelegate<dynamic>> _createLocalization() => [
        AppLocalizations.delegate,
        InnimLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ];

  Route<T> _onGenerateRoute<T>(RouteSettings settings) {
    return AppRoutes.createRoute(settings.name, settings: settings);
  }
}

/// Вспомогательный класс, для глобального отслеживания действия со всеми блоками
class _ApplicationBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugLog('$bloc: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
    debugError('️Error:\n$error. Stacktrace: $stackTrace');
  }
}
