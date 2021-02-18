import 'package:WhatWhereWhenMaster/blocs/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innim_ui/innim_ui.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _checkState(context, context.bloc<AppBloc>().state);

    return Scaffold(
      body: BlocListener<AppBloc, AppState>(
        listener: _checkState,
        child: LoadingWidget(),
      ),
    );
  }

  void _checkState(BuildContext context, AppState state) {
    if (state is AppReadySuccess) {
      context.bloc<AppBloc>().launchScreenHidden();
    }
  }
}
