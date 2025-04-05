

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:piller/common/constants.dart';

class MovieDetailsInteractor {

  Future<Map<String, dynamic>> fetchMovieDetails(int movieId, String language) async {
    final url = Uri.parse(
      '${Global.baseURL}/movie/$movieId?api_key=${Global.apiKey}&language=$language',
    );
    debugPrint("Fetching movie details from: $url");
    debugPrint("Language: $language");

    final response = await http.get(url);

    debugPrint("Response status: ${response.statusCode}");

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      debugPrint("Movie title: ${jsonData['title']}");
      return jsonData;
    } else {
      debugPrint("Failed to fetch movie details: ${response.body}");
      throw Exception('Failed to load movie details');
    }
  }
}
