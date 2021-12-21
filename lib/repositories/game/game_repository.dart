import 'package:what_where_when_master/models/game_data/game_data.dart';
import 'package:what_where_when_master/repositories/game/game_firestore_provider.dart';
import 'package:async/async.dart';

/// Repository for working with [GameData].
class GameRepository {
  final GameFirestoreProvider provider;

  GameRepository(this.provider) : assert(provider != null);

  /// Returns list of saved games entries.
  Future<Result<List<GameDataEntry>>> getList() {
    return provider.getAll();
  }
}
