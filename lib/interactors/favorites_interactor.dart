
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:piller/common/models/movie.dart';

class FavoritesInteractor {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addMovieToFavorites(Movie movie) async {
    try {
      await _firestore.collection('favorites').doc(movie.id.toString()).set({
        'id': movie.id,
        'title': movie.title,
        'overview': movie.overview,
        'poster_path': movie.posterPath,
        'vote_average': movie.voteAverage,
        'vote_count': movie.voteCount,
        'added_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error adding movie to favorites: $e');
    }
  }

  Future<void> removeMovieFromFavorites(String movieId) async {
    try {
      await _firestore.collection('favorites').doc(movieId).delete();
    } catch (e) {
      debugPrint('Error removing movie from favorites: $e');
    }
  }

  Future<List<Movie>> getFavoriteMovies() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('favorites').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Movie.fromJson(data);
      }).toList();
    } catch (e) {
      debugPrint('Error fetching favorite movies: $e');
      return [];
    }
  }

  Future<bool> checkFavorite(String movieId) async {
    try {
      final doc = await _firestore.collection('favorites').doc(movieId).get();
      debugPrint("Checking favorite status for movie ID: $doc");
      return doc.exists;
    } catch (e) {
      debugPrint('Error checking favorite status: $e');
      return false;
    }
  }
}
