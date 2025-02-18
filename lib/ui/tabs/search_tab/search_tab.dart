import 'package:flutter/material.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/tabs/home_tab/movies_list.dart';
import 'package:movies/ui/widgets/moive_item.dart';
import 'package:movies/ui/widgets/placeholder_content.dart';

import '../../../theme/app_colors.dart';
import '../../apis/api_manager.dart';
import '../../models/MoviesDataResponse.dart';
import '../../widgets/custom_text_field.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController searchController = TextEditingController();

  List<Movies> movies = [];
  List<Movies> filterMovies = [];
  String searchQuery = '';
  late Future<MoviesDataResponse> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = ApiManager.fetchMovies();
    futureMovies.then((moviesResponse) {
      setState(() {
        movies =moviesResponse.data!.movies! ;
        filterMovies = movies; // Initialize filterMovies with all movies
      });
    }).catchError((error) {
      setState(() {
        filterMovies = []; // Clear results if there's an error
      });
    });
  }

  void _searchMovies(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      // Filter movies based on the search query
      filterMovies = movies.where((movie) {
        final title = movie.title?.toLowerCase() ?? '';
        return title.contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomTextField(
            icon: Icons.search_rounded,
            hintText: "Search",
            controller: searchController,
            isPassword: false,
            onChange: _searchMovies,

          ),
          Expanded(
            child:FutureBuilder(future: futureMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.yellowColor),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Something went wrong!", style: AppStyle.semi20Yellow),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {}); // Refresh the FutureBuilder
                            },
                            child: const Text("Try again"),
                          ),
                        ],
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.data?.movies == null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(snapshot.data?.statusMessage ?? "No data available"),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {}); // Refresh the FutureBuilder
                            },
                            child: Text(
                              "Try again",
                              style: AppStyle.semi20Yellow,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  else{
                  return searchQuery.isNotEmpty&&filterMovies.isEmpty? PlaceholderContent()
                      : GridView.builder(
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // Number of columns in the grid
                        crossAxisSpacing: 16,
                        // Horizontal space between items
                        mainAxisSpacing: 8,
                        // Vertical space between items
                        childAspectRatio:
                        0.7, // Aspect ratio of each item (width / height)
                      ),
                      itemCount: filterMovies.length ?? 0,
                      itemBuilder: (context, index) {
                        return MoiveItem(index: index,movies: filterMovies,);

                      },
                    );
                  }
                },),
          ),
        ],
      ),
    );
  }
}