import 'dart:convert';

import 'package:what_where_when_master/models/models.dart';
import 'package:flutter/material.dart';
import 'package:innim_ui/innim_ui.dart';
import 'package:what_where_when_master/screens/game/game_screen.dart';

/// Home screen.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// TMP: emdebbed data -- START
  bool _loading = false;
  List<Round> _rounds;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_rounds == null && !_loading) {
      _loadData().then((value) => setState(() {
            _rounds = value;
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const LoadingWidget();
    if (_rounds == null || _rounds.isEmpty) return const Text('No data');

    return GameScreen(
      game: GameData(rounds: _rounds),
    );
  }

  Future<List<Round>> _loadData() async {
    _loading = true;
    final json = await DefaultAssetBundle.of(context)
        .loadString('assets/questions.json');

    final data = (await jsonDecode(json) as List).cast<Map<String, dynamic>>();
    _loading = false;
    return data.map((o) => Round.fromJson(o)).toList();
  }

  // TMP: emdebbed data -- END

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            HomeBloc(context.read(), context.read())..started(),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadSuccess) {
              return _buildBody(context, state.games);
            }

            // TODO: navigate to the auth form when HomeSignInRequired
            debugAssertState(
                state is HomeInitial ||
                    state is HomeLoadInProgress ||
                    state is HomeSignInRequired,
                state);
            return const LoadingWidget();
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<GameDataEntry> games) {
    // TODO: state if no games
    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (context, index) => _buildListItem(context, games[index]),
    );
  }

  Widget _buildListItem(BuildContext context, GameDataEntry entry) {
    return Text(entry.title);
  }
  */
}
