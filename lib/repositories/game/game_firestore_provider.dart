import 'package:WhatWhereWhenMaster/models/game_data/game_data.dart';
import 'package:meta/meta.dart';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Provider of [GameData] with Firestore.
class GameFirestoreProvider {
  static const _path = 'games';

  CollectionReference<Map<String, Object>> _collection;

  /// Returns list of saved games entries.
  Future<Result<List<GameDataEntry>>> getAll() async {
    final res = await collection.get();
    return Result.value(res.docs.map(_fromDoc).toList());
  }

  @protected
  CollectionReference<Map<String, Object>> get collection =>
      _collection ??= FirebaseFirestore.instance.collection(_path);

  GameDataEntry _fromDoc(QueryDocumentSnapshot<Map<String, Object>> doc) {
    return GameDataEntry.fromJson(<String, Object>{
      'uid': doc.id,
      ...doc.data(),
    });
  }
}
