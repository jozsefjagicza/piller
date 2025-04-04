
class MovieDetailsResponse {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;
  final String status;
  final double popularity;
  final String originalLanguage;
  final List<Genre> genres;

  MovieDetailsResponse({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.status,
    required this.popularity,
    required this.originalLanguage,
    required this.genres,
  });

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) {
    return MovieDetailsResponse(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
      status: json['status'],
      popularity: (json['popularity'] as num).toDouble(),
      originalLanguage: json['original_language'],
      genres: (json['genres'] as List).map((e) => Genre.fromJson(e)).toList(),
    );
  }

  String? get posterURL =>
      posterPath != null ? 'https://image.tmdb.org/t/p/w500$posterPath' : null;
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}
