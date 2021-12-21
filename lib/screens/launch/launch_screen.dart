import 'package:what_where_when_master/blocs/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innim_ui/innim_ui.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _checkState(context, context.read<AppBloc>().state);

    return Scaffold(
      body: BlocListener<AppBloc, AppState>(
        listener: _checkState,
        child: const LoadingWidget(),
      ),
    );
  }

  void _checkState(BuildContext context, AppState state) {
    if (state is AppReadySuccess) {
      context.read<AppBloc>().launchScreenHidden();
    }
  }
}
