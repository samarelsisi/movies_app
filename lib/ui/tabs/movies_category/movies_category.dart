import 'package:flutter/material.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/apis/api_manager.dart';
import 'package:movies/ui/models/MoviesDataResponse.dart';

import '../../../theme/app_colors.dart';
import 'category_tab.dart';


class MovieCategory extends StatefulWidget {
  static const String routeName = "movies_category";

  @override
  _MovieCategoryState createState() => _MovieCategoryState();
}

class _MovieCategoryState extends State<MovieCategory> {
  late Future<MoviesDataResponse> futureMovies;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureMovies = ApiManager.fetchMovies();
  }

  // Function to extract unique genres from movies
  List<String> moviesCategory(List<Movies> movies) {
    Set<String> categories = {};
    for (var movie in movies) {
      if (movie.genres != null) {
        categories.addAll(movie.genres!);
      }
    }
    return categories.toList();
  }

  Map<String, List<Movies>> filterMoviesByCategory(List<Movies> movies) {
    Map<String, List<Movies>> categorizedMovies = {};
    for (var movie in movies) {
      if (movie.genres != null) {
        for (var genre in movie.genres!) {
          if (!categorizedMovies.containsKey(genre)) {
            categorizedMovies[genre] = [];
          }
          categorizedMovies[genre]!.add(movie);
        }
      }
    }
    return categorizedMovies;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder<MoviesDataResponse>(
        future: futureMovies,
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
          } else {
            final movies = snapshot.data!.data!.movies!;
            final category = moviesCategory(movies);
            final categorizedMovies = filterMoviesByCategory(movies);

            return DefaultTabController(
              length: category.length,
              child: Column(
                children: [
                  TabBar(
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index; // Update the selected index
                      });
                    },
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    labelPadding: EdgeInsets.symmetric(horizontal: 4),
                    tabs: category.map((genre) {
                      return CategoryTab(
                          backgroundColor: AppColors.yellowColor,
                          isSelected: selectedIndex == category.indexOf(genre),
                          categoryName: genre,
                          textSelectedStyle: AppStyle.bold20Black,
                          textUnSelectedStyle: AppStyle.bold20Yellow);
                    }).toList(),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: category.map((genre) {
                        final movies = categorizedMovies[genre] ?? [];
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // Number of columns in the grid
                            crossAxisSpacing: 20,
                            // Horizontal space between items
                            mainAxisSpacing: 8,
                            // Vertical space between items
                            childAspectRatio:
                                0.7, // Aspect ratio of each item (width / height)
                          ),
                          itemCount: categorizedMovies[genre]?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    child: Image.network(
                                      movies[index].mediumCoverImage! ?? '',
                                      // Use medium-sized cover image
                                      fit: BoxFit.cover,
                                      // Cover the entire container
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: Icon(Icons.error,
                                              color: AppColors.redColor),
                                        ); // Show an error icon if the image fails to load
                                      },
                                    )),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    width: width * .2,
                                    height: height * .04,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color(0x14121312).withOpacity(0.9),
                                    ),
                                    padding: EdgeInsets.only(
                                      left: width * .03,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${movies[index].rating.toString()}" ??
                                              " ",
                                          style: AppStyle.regular16WhiteRoboto,
                                        ),
                                        Icon(
                                          Icons.star_rate_rounded,
                                          color: AppColors.yellowColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
