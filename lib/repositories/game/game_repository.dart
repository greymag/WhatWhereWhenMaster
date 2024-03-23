import 'package:async/async.dart';
import 'package:what_where_when_master/models/game_data/game_data.dart';
import 'package:what_where_when_master/repositories/game/game_firestore_provider.dart';

/// Repository for working with [GameData].
class GameRepository {
  final GameFirestoreProvider provider;

  GameRepository(this.provider);

  /// Returns list of saved games entries.
  Future<Result<List<GameDataEntry>>> getList() {
    return provider.getAll();
  }
}
