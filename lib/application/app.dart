import 'package:what_where_when_master/application/routes.dart';
import 'package:what_where_when_master/application/theme.dart';
import 'package:what_where_when_master/blocs/app/app_bloc.dart';
import 'package:what_where_when_master/blocs/auth/auth_bloc.dart';
import 'package:what_where_when_master/repositories/game/game_firestore_provider.dart';
import 'package:what_where_when_master/repositories/repositories.dart';
import 'package:what_where_when_master/screens/launch/launch_screen.dart';
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
    Bloc.observer = _ApplicationBlocObserver(logEnabled: false);
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
            return const LoadingWidget();
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

class _ApplicationBlocObserver extends BlocObserver {
  final bool logEnabled;

  _ApplicationBlocObserver({this.logEnabled = false});

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (logEnabled) _logTransition(bloc, transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    debugError('️Error:\n$error. Stacktrace: $stacktrace');
  }

  void _logTransition(Bloc bloc, Transition transition) {
    final title = '================= [ ${bloc.runtimeType} ] =================';
    final now = DateTime.now();
    final separator = List.generate(title.length, (index) => '=').join();
    debugLog('''
$title
Date      : ${now.toIso8601String()}
Event     : ${transition.event}
Prev state: ${transition.currentState}
Next state: ${transition.nextState}
$separator
''');
  }
}
