import 'package:flutter/material.dart';
import 'package:innim_ui/innim_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:what_where_when_master/application/localization.dart';
import 'package:what_where_when_master/models/models.dart';

import 'game_tab.dart';

/// Game screen.
///
/// Shows rounds of the game, notes and rules.
class GameScreen extends StatefulWidget {
  /// Data of the game.
  final GameData game;

  const GameScreen({Key key, @required this.game})
      : assert(game != null),
        super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      body: _buildBodyByTab(context, _currentTabIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: (value) {
          if (_currentTabIndex != value) {
            setState(() {
              _currentTabIndex = value;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.casino),
            label: loc.bottomNavigationTabGame,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.comment),
            label: loc.bottomNavigationTabNotes,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.gavel),
            label: loc.bottomNavigationTabRules,
          ),
        ],
      ),
    );
  }

  Widget _buildBodyByTab(BuildContext context, int index) {
    switch (index) {
      case 0:
        return GameTab(game: widget.game);
      case 1:
        return const _Notes();
      case 2:
        return const _TextContent(
          text: '''
Открытый турнир Борисоглебского филиала ФГБОУ ВО «Воронежского государственного университета» по интеллектуальной игре «Что? Где? Когда?» среди школьников и студентов 

Правила игры
1. Игра состоит из трёх туров по 10 вопросов в каждом.
2. Игра проводится по упрощённым правилам спортивного «Что? Где? Когда?», кратко изложенным ниже.
3. Задача команд — своевременно дать правильный ответ на вопрос, поставленный ведущим. За каждый правильный ответ команда получает одно игровое очко.
4. Ответы даются в письменном виде на карточках для ответа, содержащих название команды, номер тура и номер вопроса.
5. Ведущий объявляет номер вопроса, задаёт сам вопрос (для всех вопросов, кроме блиц-вопросов и музыкальных вопросов, текст вопроса озвучивается дважды) и произносит слово «Время», после чего начинается отсчёт чистого времени, равного 60 секундам. За 10 секунд до окончания минуты обсуждения даётся сигнал о том, что осталось 10 секунд. По окончании минуты обсуждения производится обратный отсчёт дополнительных 10 секунд, до истечения которых каждая команда обязана сдать карточку с ответом. Если у команды ответа нет, сдаётся пустая карточка.
6. Блиц-вопрос состоит из преамбулы и двух или более мини-вопросов, на каждый из которых командам даётся определённое время. Суммарное время на все мини-вопросы составляет одну минуту. Преамбула включает информацию о том, что данный вопрос является блиц-вопросом, о числе мини-вопросов и о времени, которое даётся на каждый мини-вопрос. Ответы на все мини-вопросы блица записываются на одной карточке в том же порядке, в котором задаются мини-вопросы. Ответ на блиц-вопрос признаётся правильным, только если правильными признаются ответы на все мини-вопросы.
7. Сдавшей ответ вовремя считается команда, капитан (игрок) которой поднял вверх руку с карточкой с ответом до истечения дополнительных 10 секунд.
8. Ответы, сданные с опозданием, не рассматриваются.
9. Ответ считается неправильным, если:
- не раскрывает суть вопроса с достаточной степенью конкретизации (степень необходимой конкретизации определяется жюри);
- форма ответа не соответствует форме вопроса;
- команда сдала более одного варианта ответа, хотя бы один из которых неверен;
- в ответе допущены грубые ошибки (неправильно названы имена, фамилии, названия, даты, способ действия и т.п.), искажающие или меняющие суть ответа.
10. При наличии в ответе дополнительной информации собственно ответом считается фраза или слово, впрямую отвечающие форме вопроса. Неточности в дополнительной информации не учитываются, если они не меняют смысл ответа.
11. Победителем объявляется команда, набравшая наибольшее количество игровых очков. В случае если несколько команд набрали одинаковое количество очков, места определяются по дополнительному показателю — суммарному рейтингу вопросов, на которые команда дала правильный ответ. Рейтинг вопроса равен числу команд, не ответивших на него, плюс один.
12. Если несколько команд набрали наибольшее количество игровых очков и их суммарный рейтинг вопросов также одинаков, то для определения победителя между этими командами проводится «перестрелка» — команды отвечают на дополнительные вопросы до первой ошибки (команда, не ответившая на вопрос, выбывает из «перестрелки»; если неверный ответ дали все команды, то никто не выбывает). «Перестрелка» продолжается до тех пор, пока не останется только одна команда, верно ответившая на все дополнительные вопросы, которая и объявляется победителем.

Жюри

Подсказки и средства связи

Мобильники зрителей
''',
        );
    }

    assert(false, 'Unhandled tab index: $index');
    return Container();
  }
}

class _TextContent extends StatelessWidget {
  final String text;
  const _TextContent({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class _Notes extends StatefulWidget {
  const _Notes({Key key}) : super(key: key);

  @override
  __NotesState createState() => __NotesState();
}

class __NotesState extends State<_Notes> {
  static const _prefsKey = 'notesText';

  SharedPreferences _prefs;
  var _text = '';
  bool _isPending = false;
  bool _isEditing = false;

  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();

    _load();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        // TODO: another string
        title: Text(loc.bottomNavigationTabNotes),
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () async {
                final text = _textController.text;
                setState(() {
                  _text = text;
                  _isEditing = false;
                });
                await _prefs.setString(_prefsKey, _textController.text);
              },
            ),
          if (!_isEditing && !_isPending)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                _textController.text = _text;
                setState(() {
                  _isEditing = true;
                });
              },
            ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isPending) return const LoadingWidget();
    if (_isEditing) return _buildEditing(context);
    return _buildText(context, _text);
  }

  Widget _buildText(BuildContext context, String text) {
    return _TextContent(text: text);
  }

  Widget _buildEditing(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        autofocus: true,
        controller: _textController,
        minLines: null,
        maxLines: null,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.newline,
        expands: true,
        decoration: const InputDecoration(focusedBorder: InputBorder.none),
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  Future<void> _load() async {
    _isPending = true;

    _prefs ??= await SharedPreferences.getInstance();
    final text = _prefs.getString(_prefsKey) ?? '';

    setState(() {
      _isPending = false;
      _text = text;
    });
  }
}
