
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:piller/common/models/movie.dart';

class HomeInteractor {
  static const String _apiKey = '4c563e9e63cb1363f3d537a165670e5a';
  static const String _baseUrl = 'https://api.themoviedb.org/3/movie/popular';

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl?api_key=$_apiKey&language=hu-HU'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MovieResponse.fromJson(data).results;
    } else {
      throw Exception('Hiba a filmek lekérdezésekor');
    }
  }
}
