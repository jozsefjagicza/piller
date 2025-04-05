
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:piller/common/constants.dart';
import 'package:piller/common/models/movie_details.dart';
import 'package:piller/common/styles.dart';

class MovieQuickInfoRow extends StatelessWidget {
  final MovieDetailsResponse movie;

  const MovieQuickInfoRow({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MovieInfoTile(title: 'movie_status'.tr(), value: movie.status),
        Container(
          width: 1,
          height: 40,
          color: AppColors.lightColor,
        ),
        MovieInfoTile(title: 'movie_popularity'.tr(), value: '${movie.popularity}'),
        Container(
          width: 1,
          height: 40,
          color: AppColors.lightColor,
        ),
        MovieInfoTile(title: 'movie_language'.tr(), value: movie.originalLanguage.toUpperCase()),
      ],
    );
  }
}

class MovieInfoTile extends StatelessWidget {
  final String title;
  final String value;

  const MovieInfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: AppTextStyles.itemTitle),
          Text(value, style: AppTextStyles.itemValue),
        ],
      ),
    );
  }
}

