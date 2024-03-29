import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:what_where_when_master/models/game_data/game_data.dart';

/// Provider of [GameData] with Firestore.
class GameFirestoreProvider {
  static const _path = 'games';

  CollectionReference<Map<String, dynamic>>? _collection;

  /// Returns list of saved games entries.
  Future<Result<List<GameDataEntry>>> getAll() async {
    final res = await collection.get();
    return Result.value(res.docs.map(_fromDoc).toList());
  }

  @protected
  CollectionReference<Map<String, dynamic>> get collection =>
      _collection ??= FirebaseFirestore.instance.collection(_path);

  GameDataEntry _fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return GameDataEntry.fromJson(<String, dynamic>{
      'uid': doc.id,
      ...doc.data(),
    });
  }
}
