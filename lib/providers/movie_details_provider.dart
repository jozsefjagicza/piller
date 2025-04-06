
import 'package:flutter/cupertino.dart';
import 'package:piller/analytics/analytics_service.dart';
import 'package:piller/common/models/movie_details.dart';
import 'package:piller/di/service_locator.dart';
import 'package:piller/interactors/movie_details_interactor.dart';

class MovieDetailsProvider with ChangeNotifier {
  final MovieDetailsInteractor _interactor = locator<MovieDetailsInteractor>();

  MovieDetailsResponse? movieDetails;
  String? errorMessage;
  bool isLoading = false;

  Future<void> getMovieDetails(int movieId, String language) async {
    isLoading = true;
    errorMessage = null;
    movieDetails = null;
    notifyListeners();

    try {
      final responseJson = await _interactor.fetchMovieDetails(movieId, language);
      final response = MovieDetailsResponse.fromJson(responseJson);

      await AnalyticsService.logMovieDetailsOpened(
        movieId: movieId.toString(),
        title: response.title,
      );

      movieDetails = response;
    } catch (e) {
      errorMessage = e.toString();
      debugPrint('Error fetching movie details: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
