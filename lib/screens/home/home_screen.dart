import 'package:WhatWhereWhenMaster/blocs/home/home_bloc.dart';
import 'package:WhatWhereWhenMaster/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innim_lib/innim_lib.dart';
import 'package:innim_ui/innim_ui.dart';

/// Home screen.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            HomeBloc(context.bloc(), context.repository())..started(),
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
            return LoadingWidget();
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
}
