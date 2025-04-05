

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:piller/common/constants.dart';
import 'package:piller/common/styles.dart';
import 'package:piller/common/widgets/background_widget.dart';
import 'package:piller/di/service_locator.dart';
import 'package:piller/feature/home/movie_item.dart';
import 'package:piller/main.dart';
import 'package:piller/providers/favorites_provider.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with RouteAware {

  final provider = locator<FavoritesProvider>();

  @override
  void initState() {
    provider.loadFavorites();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ObserverUtils.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    provider.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.textColor),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            "favorites_title".tr(),
            style: AppTextStyles.headline,
          ),
        ),
        body: Consumer<FavoritesProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
            }

            if (provider.favoriteMovies.isEmpty) {
              return Center(child: Text('favorites_no_results'.tr(), style: AppTextStyles.itemTitle,));
            }

            return ListView.builder(
              itemCount: provider.favoriteMovies.length,
              itemBuilder: (context, index) {
                return MovieItem(movie: provider.favoriteMovies[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
