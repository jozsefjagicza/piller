
import 'package:flutter/cupertino.dart';
import 'package:piller/common/models/movie.dart';
import 'package:piller/interactors/home_interactor.dart';

class HomeProvider with ChangeNotifier {
  final HomeInteractor _interactor = HomeInteractor();
  List<Movie> _movies = [];
  List<Movie> _filteredMovies = [];
  bool isLoading = false;

  List<Movie> get movies => _movies;
  List<Movie> get filteredMovies => _filteredMovies;

  Future<void> loadMovies() async {
    isLoading = true;
    notifyListeners();

    try {
      _movies = await _interactor.fetchMovies();
      _filteredMovies = List.from(_movies);
    } catch (e) {
      _movies = [];
      _filteredMovies = [];
    }

    isLoading = false;
    notifyListeners();
  }

  void searchMovies(String query) {
    debugPrint("Searching movies with query: $query");
    if (query.isEmpty) {
      _filteredMovies = List.from(_movies);
    } else {
      _filteredMovies = _movies.where((movie) =>
          movie.title.toLowerCase().contains(query.toLowerCase())).toList();
      debugPrint("Searching movies with query: $_filteredMovies");
    }
    notifyListeners();
  }
}

