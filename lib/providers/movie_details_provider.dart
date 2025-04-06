
import 'package:flutter/cupertino.dart';
import 'package:piller/analytics/analytics_service.dart';
import 'package:piller/common/models/movie_details.dart';
import 'package:piller/di/service_locator.dart';
import 'package:piller/interactors/movie_details_interactor.dart';

class MovieDetailsProvider with ChangeNotifier {
  final MovieDetailsInteractor _interactor = locator<MovieDetailsInteractor>();

  Future<MovieDetailsResponse> getMovieDetails(int movieId, String language) async {
    final responseJson = await _interactor.fetchMovieDetails(movieId, language);
    MovieDetailsResponse response = MovieDetailsResponse.fromJson(responseJson);
    await AnalyticsService.logMovieDetailsOpened(
      movieId: movieId.toString(),
      title: response.title,
    );
    return response;
  }
}

