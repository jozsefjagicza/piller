
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:piller/common/constants.dart';
import 'package:piller/common/models/movie_details.dart';
import 'package:piller/common/styles.dart';

class GenresWidget extends StatelessWidget {
  const GenresWidget({
    super.key,
    required this.genres,
  });

  final List<Genre> genres;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${'movie_genres'.tr()}: ', style: AppTextStyles.itemTitle),
        SizedBox(width: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: genres.map((genre) {
            return Container(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Text(
                genre.name,
                style: AppTextStyles.bodyTextWhite,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
