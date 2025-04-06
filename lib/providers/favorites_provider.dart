
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:piller/analytics/analytics_service.dart';
import 'package:piller/common/models/movie.dart';
import 'package:piller/di/service_locator.dart';
import 'package:piller/interactors/favorites_interactor.dart';

class FavoritesProvider extends ChangeNotifier {
  final FavoritesInteractor _favoritesInteractor = locator<FavoritesInteractor>();
  String? errorMessage;

  bool isLoading = false;
  List<Movie> favoriteMovies = [];

  Future<void> addFavorite(Movie movie) async {
    if (!await isFavorite(movie.id.toString())) {
      await _favoritesInteractor.addMovieToFavorites(movie);
      await AnalyticsService.logFavoriteAdded(movieId: movie.id.toString());
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String movieId) async {
    if (await isFavorite(movieId)) {
      await _favoritesInteractor.removeMovieFromFavorites(movieId);
      await AnalyticsService.logFavoriteRemoved(movieId: movieId);
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String movieId) async {
    bool isFavorite = await _favoritesInteractor.checkFavorite(movieId);
    return isFavorite;
  }

  Future<void> loadFavorites() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    favoriteMovies = await _favoritesInteractor.getFavoriteMovies();
    if (favoriteMovies.isNotEmpty) {
    } else {
      errorMessage = 'favorites_error'.tr();
    }
    isLoading = false;
    notifyListeners();
  }
}
