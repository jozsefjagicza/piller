
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:piller/common/constants.dart';
import 'package:piller/common/decorations.dart';
import 'package:piller/common/styles.dart';
import 'package:piller/common/widgets/background_widget.dart';
import 'package:piller/di/service_locator.dart';
import 'package:piller/providers/auth_provider.dart';
import 'package:piller/providers/home_provider.dart';
import 'package:provider/provider.dart';

import 'movie_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.delayed(Duration.zero, () {
      String languageCode = Localizations.localeOf(context).languageCode;
      locator<HomeProvider>().loadMovies(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BackgroundWidget(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
                bottom: UIConstants.defaultPadding,
                left: UIConstants.defaultPadding,
                right: UIConstants.defaultPadding,
              ),
              child: Row(
                children: [
                  SizedBox(width: 48),
                  Expanded(
                    child: Center(
                      child: Text(
                        "movies_title".tr(),
                        style: AppTextStyles.headline,
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.favorite),
                    color: AppColors.primaryColor,
                    onPressed: () {
                      Navigator.pushNamed(context, '/home/favorite');
                    },
                  ),
                  IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.logout),
                    color: AppColors.textColor,
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: UIConstants.defaultPadding),
              child: TextField(
                controller: _searchController,
                onChanged: (query) {
                  locator<HomeProvider>().searchMovies(query);
                },
                decoration: InputDecorations.customInputDecoration(
                  labelText: 'movies_search'.tr(),
                ),
              ),
            ),
            Consumer<HomeProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                }

                if (provider.filteredMovies.isEmpty) {
                  return Center(child: Text('movies_no_results'.tr(), style: AppTextStyles.itemTitle));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: provider.filteredMovies.length,
                    itemBuilder: (context, index) {
                      return MovieItem(movie: provider.filteredMovies[index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('logout'.tr(), style: AppTextStyles.itemTitle,),
          content: Text('logout_confirmation'.tr(), style: AppTextStyles.bodyText,),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Close the dialog
              },
              child: Text('general_cancel'.tr(), style: AppTextStyles.bodyTextExtraLight,),
            ),
            TextButton(
              onPressed: () {
                locator<AuthProvider>().logOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('logout'.tr(), style: AppTextStyles.itemValue,),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

