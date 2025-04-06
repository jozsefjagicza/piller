
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:piller/analytics/analytics_service.dart';
import 'package:piller/common/models/movie.dart';
import 'package:piller/di/service_locator.dart';
import 'package:piller/interactors/home_interactor.dart';

class HomeProvider with ChangeNotifier {
  final HomeInteractor _interactor = locator<HomeInteractor>();
  List<Movie> _movies = [];
  List<Movie> _filteredMovies = [];
  bool isLoading = false;
  String? errorMessage;

  List<Movie> get movies => _movies;
  List<Movie> get filteredMovies => _filteredMovies;

  Future<void> loadMovies(String languageCode) async {
    debugPrint("Loading movies with language code: $languageCode");
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      _movies = await _interactor.fetchMovies(languageCode);
      _filteredMovies = List.from(_movies);
      await AnalyticsService.logMovieListFetchSuccess();
    } catch (e) {
      _movies = [];
      _filteredMovies = [];
      errorMessage = 'movies_load_error'.tr();
      await AnalyticsService.logMovieListFetchFailure(error: 'network_error');
    }

    isLoading = false;
    notifyListeners();
  }

  void searchMovies(String query) {
    if (query.isEmpty) {
      _filteredMovies = List.from(_movies);
    } else {
      _filteredMovies = _movies.where((movie) =>
          movie.title.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }
}

