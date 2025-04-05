
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:piller/common/constants.dart';
import 'package:piller/common/models/movie.dart';
import 'package:piller/common/models/movie_details.dart';
import 'package:piller/common/styles.dart';
import 'package:piller/common/widgets/background_widget.dart';
import 'package:piller/di/service_locator.dart';
import 'package:piller/feature/movie_details/items/genres_widget.dart';
import 'package:piller/feature/movie_details/items/movie_quick_info_row.dart';
import 'package:piller/providers/favorites_provider.dart';
import 'package:piller/providers/movie_details_provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool isFavorite = false;
  late Future<MovieDetailsResponse> _movieFuture;
  final FavoritesProvider _favoritesProvider = locator<FavoritesProvider>();

  @override
  void initState() {
    super.initState();
  }

  void toggleFavorite() {
    setState(() {
        if (isFavorite) {
          _favoritesProvider.removeFavorite(widget.movie.id.toString());
        } else {
          _favoritesProvider.addFavorite(widget.movie);
        }
        isFavorite = !isFavorite;
    });
  }

  Future<void>_checkFavorite() async {
    bool favoriteStatus = await _favoritesProvider.isFavorite(widget.movie.id.toString());
    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String languageCode =
        "${Localizations.localeOf(context).languageCode}-${Localizations.localeOf(context).countryCode}";
    _movieFuture = locator<MovieDetailsProvider>().getMovieDetails(widget.movie.id, languageCode);
    _checkFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: FutureBuilder<MovieDetailsResponse>(
        future: _movieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                tr('general_error', args: [snapshot.error.toString()]),
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(child: Text('no_data_available'.tr()));
          } else {
            final movie = snapshot.data!;
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: AppColors.textColor),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    if (movie.posterURL != null) Image.network(movie.posterURL!),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: UIConstants.defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movie.title, style: AppTextStyles.headline),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow, size: 20),
                              SizedBox(width: 4),
                              Text("${movie.voteAverage}", style: AppTextStyles.voteStyle),
                              Spacer(),
                              IconButton(
                                iconSize: 30,
                                icon: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                ),
                                color: AppColors.primaryColor,
                                onPressed: toggleFavorite,
                              ),
                            ],
                          ),
                          SizedBox(height: UIConstants.defaultPadding),
                          MovieQuickInfoRow(movie: movie),
                          SizedBox(height: UIConstants.defaultPadding),
                          Text(movie.overview, style: AppTextStyles.itemTitle),
                          SizedBox(height: UIConstants.defaultPadding),
                          Row(
                            children: [
                              Text('${'movie_rating'.tr()}: ', style: AppTextStyles.itemTitle),
                              Text(
                                '${movie.voteAverage} (${movie.voteCount} ${'movie_votes'.tr()})',
                                style: AppTextStyles.itemValue,
                              ),
                            ],
                          ),
                          SizedBox(height: UIConstants.defaultPadding),
                          GenresWidget(genres: movie.genres),
                        ],
                      ),
                    ),
                    SizedBox(height: UIConstants.largePadding),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

