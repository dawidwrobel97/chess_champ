import 'package:chess_app/src/domain/models/chess_game_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class FavouritesPageRepository {
  Stream<List<ChessGameModel>> getUserChessGamesStream() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User isn\'t logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favourites')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
      (data) {
        return data.docs.map(
          (doc) {
            return ChessGameModel.fromJson(doc.data());
          },
        ).toList();
      },
    );
  }
}
