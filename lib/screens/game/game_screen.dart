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
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis felis neque, fermentum vel lorem in, vestibulum congue turpis. Proin ac eros vestibulum, fringilla neque eget, iaculis nisi. Integer luctus ac est eget ultricies. Duis vulputate ac neque nec rutrum. Mauris ut consequat velit. Aenean et convallis urna, eu pellentesque mauris. Maecenas ac nibh vitae turpis placerat accumsan. Fusce fringilla et diam faucibus feugiat. Cras cursus, massa ut aliquet fringilla, lectus felis molestie eros, sit amet rutrum lectus libero nec diam.

Quisque at orci rutrum massa mattis dignissim. Curabitur facilisis id mi quis posuere. Pellentesque quis turpis viverra, ultrices libero non, vehicula purus. Vivamus rutrum interdum varius. Donec scelerisque tellus massa, finibus fermentum libero dapibus vel. Vestibulum dui mauris, sodales ac justo in, facilisis dapibus risus. Morbi sodales molestie sem, in dictum mi condimentum sed.

Sed scelerisque vehicula lacus dignissim sodales. Nam tempus laoreet enim in condimentum. Ut vitae imperdiet orci, eu vestibulum magna. Nam semper purus nulla. Quisque eu dictum nunc. In a nibh orci. Cras pulvinar hendrerit nisi, id commodo sapien suscipit in. In commodo vestibulum fringilla. Vivamus rhoncus rutrum maximus. Proin tempus in quam non varius. Duis volutpat, nunc a venenatis consectetur, ex mi eleifend libero, vel consectetur erat justo eget lacus. In ut consequat sem, in blandit mauris. Aliquam a elit aliquet nisi vulputate sagittis in a arcu. In sed mollis mauris.

Suspendisse potenti. Curabitur mattis malesuada auctor. Nullam viverra bibendum odio nec sollicitudin. Suspendisse potenti. Nam at consequat eros, vitae porttitor tortor. Morbi dui augue, pellentesque in venenatis sit amet, tincidunt id nibh. Mauris quis nibh eu neque pulvinar elementum. Nam urna erat, egestas sit amet nisl ut, pellentesque gravida dolor. Aliquam sit amet feugiat quam. Etiam aliquet erat at lacus scelerisque placerat. Nullam ullamcorper sodales mollis.

Nunc velit enim, ultrices sit amet felis vel, venenatis pharetra nibh. Etiam laoreet dapibus orci quis imperdiet. Aenean at eleifend lacus. Pellentesque in tortor justo. Vestibulum volutpat odio vehicula velit elementum pharetra. Donec vitae ex vitae elit tincidunt laoreet. Donec ac leo ut dui vehicula molestie quis eu nulla. Curabitur id leo tempus, viverra magna sit amet, tincidunt nisi. Duis nec lorem vitae lorem pellentesque hendrerit eget a elit. Phasellus tincidunt dictum efficitur. Nam ullamcorper eros quis tincidunt tristique. Pellentesque convallis nunc ut tempor maximus. Proin eu commodo mi, sed tristique lacus. Ut sodales non arcu in imperdiet. Nunc efficitur pulvinar malesuada.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis felis neque, fermentum vel lorem in, vestibulum congue turpis. Proin ac eros vestibulum, fringilla neque eget, iaculis nisi. Integer luctus ac est eget ultricies. Duis vulputate ac neque nec rutrum. Mauris ut consequat velit. Aenean et convallis urna, eu pellentesque mauris. Maecenas ac nibh vitae turpis placerat accumsan. Fusce fringilla et diam faucibus feugiat. Cras cursus, massa ut aliquet fringilla, lectus felis molestie eros, sit amet rutrum lectus libero nec diam.

Quisque at orci rutrum massa mattis dignissim. Curabitur facilisis id mi quis posuere. Pellentesque quis turpis viverra, ultrices libero non, vehicula purus. Vivamus rutrum interdum varius. Donec scelerisque tellus massa, finibus fermentum libero dapibus vel. Vestibulum dui mauris, sodales ac justo in, facilisis dapibus risus. Morbi sodales molestie sem, in dictum mi condimentum sed.

Sed scelerisque vehicula lacus dignissim sodales. Nam tempus laoreet enim in condimentum. Ut vitae imperdiet orci, eu vestibulum magna. Nam semper purus nulla. Quisque eu dictum nunc. In a nibh orci. Cras pulvinar hendrerit nisi, id commodo sapien suscipit in. In commodo vestibulum fringilla. Vivamus rhoncus rutrum maximus. Proin tempus in quam non varius. Duis volutpat, nunc a venenatis consectetur, ex mi eleifend libero, vel consectetur erat justo eget lacus. In ut consequat sem, in blandit mauris. Aliquam a elit aliquet nisi vulputate sagittis in a arcu. In sed mollis mauris.

Suspendisse potenti. Curabitur mattis malesuada auctor. Nullam viverra bibendum odio nec sollicitudin. Suspendisse potenti. Nam at consequat eros, vitae porttitor tortor. Morbi dui augue, pellentesque in venenatis sit amet, tincidunt id nibh. Mauris quis nibh eu neque pulvinar elementum. Nam urna erat, egestas sit amet nisl ut, pellentesque gravida dolor. Aliquam sit amet feugiat quam. Etiam aliquet erat at lacus scelerisque placerat. Nullam ullamcorper sodales mollis.

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
