import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:innim_ui/innim_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:what_where_when_master/application/localization.dart';
import 'package:what_where_when_master/models/models.dart';
import 'package:what_where_when_master/screens/game/game_screen.dart';

/// Home screen.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements ILoadDataScope {
  // TMP: embedded data -- START
  bool _loading = false;
  bool _loadFailed = false;
  List<Round>? _rounds;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_rounds == null && !_loading) {
      _reloadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const LoadingWidget();
    if (_loadFailed) {
      return Column(
        children: [
          const Text('Invalid data'),
          ElevatedButton(
            onPressed: () async {
              await Prefs.saveDataJson(null);
              _reloadData();
            },
            child: const Text('Reset to embedded data'),
          ),
        ],
      );
    }
    final rounds = _rounds;
    if (rounds == null || rounds.isEmpty) return const Text('No data');

    return GameScreen(
      game: GameData(rounds: rounds),
    );
  }

  void _reloadData() {
    _loadData().then(
      (value) => setState(() {
        _rounds = value;
      }),
    );
  }

  Future<List<Round>> _loadData() async {
    _loading = true;
    final assetsBundle = DefaultAssetBundle.of(context);
    final json = await Prefs.getDataJson() ??
        await assetsBundle.loadString('assets/questions.json');

    try {
      final data =
          (await jsonDecode(json) as List).cast<Map<String, dynamic>>();
      final res = data.map(Round.fromJson).toList();
      _loading = false;
      _loadFailed = false;
      return res;
    } catch (e) {
      print('Error: $e');
      _loading = false;
      _loadFailed = true;
      return [];
    }
  }

  // TMP: embedded data -- END

  // TMP: load by url data -- START
  @override
  Future<void> showLoadDataDialog() async {
    final res = await showDialog<bool>(
      context: context,
      builder: (context) => _LoadDataDialog(),
    );

    if (res == true && mounted) {
      final loc = AppLocalizations.of(context);
      _reloadData();
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            loc.loadSucceed,
            textAlign: TextAlign.center,
          ),
          icon: const Icon(Icons.info),
        ),
      );
    }
  }
  // TMP: load by url data -- END

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
              state,
            );
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

class _LoadDataDialog extends StatefulWidget {
  @override
  State<_LoadDataDialog> createState() => _LoadDataDialogState();
}

class _LoadDataDialogState extends State<_LoadDataDialog> {
  final _urlController = TextEditingController();
  bool _loading = false;
  bool _loadFailed = false;

  @override
  void initState() {
    super.initState();

    Prefs.getDataUrl().then((value) {
      _urlController.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final screenSize = MediaQuery.sizeOf(context);

    return AlertDialog(
      title: Text(loc.loadDataTitle),
      content: SizedBox(
        width: min(screenSize.width * .8, 600),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: loc.urlField,
                  ),
                ),
                if (_loadFailed)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      loc.loadFailed,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
              ],
            ),
            if (_loading)
              const PositionedDirectional(
                end: 0,
                top: 0,
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: LoadingWidget(),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(loc.cancelBtn),
        ),
        TextButton(
          onPressed: () async {
            final navigator = Navigator.of(context);
            setState(() {
              _loading = true;
            });
            final res = await _loadData(_urlController.text.trim());

            if (res) {
              navigator.pop(res);
            } else {
              setState(() {
                _loadFailed = true;
                _loading = false;
              });
            }
          },
          child: Text(loc.loadBtn),
        ),
      ],
    );
  }

  Future<bool> _loadData(String url) async {
    if (url.isEmpty) return false;
    await Prefs.saveDataUrl(url);
    try {
      final response = await Dio().get<String>(
        url,
        options: Options(
          responseType: ResponseType.plain,
        ),
      );

      final jsonData = response.data;
      if (jsonData == null || jsonData.isEmpty) {
        print('Json data is empty. Response: $response');
        return false;
      }

      final parsed = await jsonDecode(jsonData);

      if (parsed is! List) {
        print('Json data is not represent list. Response: $jsonData');
        return false;
      }

      await Prefs.saveDataJson(jsonData);

      return true;
    } catch (e) {
      print('Failed: $e');
      return false;
    }
  }
}

abstract interface class ILoadDataScope {
  static ILoadDataScope? of(BuildContext context) =>
      context.findAncestorStateOfType<_HomeScreenState>();

  Future<void> showLoadDataDialog();
}

class Prefs {
  static const _dataUrlKey = 'data_url';
  static const _dataJsonKey = 'data_json';
  static const _notesTextKey = 'notesText';

  static SharedPreferences? _prefs;

  static Future<void> saveNotesText(String value) =>
      _setString(_notesTextKey, value);

  static Future<String> getNotesText() => _getStringOr(_notesTextKey, '');

  static Future<void> saveDataUrl(String value) =>
      _setString(_dataUrlKey, value);

  static Future<String> getDataUrl() => _getStringOr(_dataUrlKey, '');

  static Future<void> saveDataJson(String? value) async {
    if (value != null) {
      await _setString(_dataJsonKey, value);
    } else {
      await _remove(_dataJsonKey);
    }
  }

  static Future<String?> getDataJson() => _getString(_dataJsonKey);

  static Future<void> _setString(String key, String value) async {
    await (await _getPrefs()).setString(key, value);
  }

  static Future<String?> _getString(String key) async {
    return (await _getPrefs()).getString(key);
  }

  static Future<void> _remove(String key) async {
    await (await _getPrefs()).remove(key);
  }

  static Future<String> _getStringOr(
    String key, [
    String defaultVal = '',
  ]) async {
    return (await _getString(key)) ?? defaultVal;
  }

  static Future<SharedPreferences> _getPrefs() async =>
      _prefs ??= await SharedPreferences.getInstance();

  Prefs._();
}
