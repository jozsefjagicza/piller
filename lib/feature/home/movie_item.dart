
import 'package:flutter/material.dart';
import 'package:piller/common/constants.dart';
import 'package:piller/common/decorations.dart';
import 'package:piller/common/models/movie.dart';
import 'package:piller/common/styles.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/home/details', arguments: movie);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: UIConstants.defaultPadding, vertical: 4),
        decoration: BoxDecorations.customBoxDecoration(),
        child: ListTile(
          leading: movie.posterURL != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(movie.posterURL!, width: 60, height: 160, fit: BoxFit.cover),
          )
              : Icon(Icons.movie, size: 50),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title, style: AppTextStyles.itemTitle),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        SizedBox(width: 4),
                        Text("${movie.voteAverage}", style: AppTextStyles.voteStyle),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text("${movie.voteCount}", style: TextStyle(fontSize: 12, color: AppColors.primaryColor)),
                ],
              ),
              Text(movie.overview, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.bodyText),
            ],
          ),
        ),
      ),
    );
  }
}

