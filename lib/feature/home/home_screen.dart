
import 'package:flutter/material.dart';
import 'package:piller/common/constants.dart';
import 'package:piller/common/decorations.dart';
import 'package:piller/common/styles.dart';
import 'package:piller/common/widgets/background_widget.dart';
import 'package:piller/di/service_locator.dart';
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
  final provider = locator<HomeProvider>();

  @override
  void initState() {
    super.initState();
    provider.loadMovies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BackgroundWidget(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:50.0, bottom: UIConstants.defaultPadding),
                child: Text("MOVIES", style: AppTextStyles.headline),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: UIConstants.defaultPadding),
                child: TextField(
                  controller: _searchController,
                  onChanged: (query) {
                    provider.searchMovies(query);
                  },
                  decoration: InputDecorations.customInputDecoration(
                    labelText: 'Keresés...',
                  ),
                ),
              ),
              Expanded(
                child: Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (provider.filteredMovies.isEmpty) {
                      return Center(child: Text('Nincsenek elérhető filmek.'));
                    }

                    return ListView.builder(
                      itemCount: provider.filteredMovies.length,
                      itemBuilder: (context, index) {
                        return MovieItem(movie: provider.filteredMovies[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
      )
    );
  }
}
