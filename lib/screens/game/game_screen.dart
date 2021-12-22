import 'package:flutter/material.dart';

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
        return const _TextContent(
          text: '''
Suspendisse potenti. Curabitur mattis malesuada auctor. Nullam viverra bibendum odio nec sollicitudin. Suspendisse potenti. Nam at consequat eros, vitae porttitor tortor. Morbi dui augue, pellentesque in venenatis sit amet, tincidunt id nibh. Mauris quis nibh eu neque pulvinar elementum. Nam urna erat, egestas sit amet nisl ut, pellentesque gravida dolor. Aliquam sit amet feugiat quam. Etiam aliquet erat at lacus scelerisque placerat. Nullam ullamcorper sodales mollis.

Nunc velit enim, ultrices sit amet felis vel, venenatis pharetra nibh. Etiam laoreet dapibus orci quis imperdiet. Aenean at eleifend lacus. Pellentesque in tortor justo. Vestibulum volutpat odio vehicula velit elementum pharetra. Donec vitae ex vitae elit tincidunt laoreet. Donec ac leo ut dui vehicula molestie quis eu nulla. Curabitur id leo tempus, viverra magna sit amet, tincidunt nisi. Duis nec lorem vitae lorem pellentesque hendrerit eget a elit. Phasellus tincidunt dictum efficitur. Nam ullamcorper eros quis tincidunt tristique. Pellentesque convallis nunc ut tempor maximus. Proin eu commodo mi, sed tristique lacus. Ut sodales non arcu in imperdiet. Nunc efficitur pulvinar malesuada.''',
        );
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
