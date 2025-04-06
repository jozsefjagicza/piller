
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logLoginSuccess({required String method}) async {
    await _analytics.logLogin(loginMethod: method);
  }

  static Future<void> logLoginFailure({required String reason}) async {
    await _analytics.logEvent(
      name: 'login_failure',
      parameters: {'reason': reason},
    );
  }

  static Future<void> logTokenSaved({required String token}) async {
    await _analytics.logEvent(
      name: 'token_saved',
      parameters: {'token': token},
    );
  }

  static Future<void> logMovieListFetchSuccess() async {
    await _analytics.logEvent(name: 'movie_list_fetch_success');
  }

  static Future<void> logMovieListFetchFailure({required String error}) async {
    await _analytics.logEvent(
      name: 'movie_list_fetch_failure',
      parameters: {'error': error},
    );
  }

  static Future<void> logMovieDetailsOpened({required String movieId, required String title}) async {
    await _analytics.logEvent(
      name: 'movie_details_opened',
      parameters: {
        'movie_id': movieId,
        'title': title,
      },
    );
  }

  static Future<void> logFavoriteAdded({required String movieId}) async {
    await _analytics.logEvent(
      name: 'favorite_added',
      parameters: {'movie_id': movieId},
    );
  }

  static Future<void> logFavoriteRemoved({required String movieId}) async {
    await _analytics.logEvent(
      name: 'favorite_removed',
      parameters: {'movie_id': movieId},
    );
  }
}
