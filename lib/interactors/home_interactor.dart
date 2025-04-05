
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:piller/common/constants.dart';
import 'package:piller/common/models/movie.dart';

class HomeInteractor {

  Future<List<Movie>> fetchMovies(String languageCode) async {
    final response = await http.get(Uri.parse('${Global.baseURL}/movie/popular?api_key=${Global.apiKey}&language=$languageCode'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MovieResponse.fromJson(data).results;
    } else {
      throw Exception('Hiba a filmek lekérdezésekor');
    }
  }
}
