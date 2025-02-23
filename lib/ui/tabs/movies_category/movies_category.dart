import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/models/MoviesDataResponse.dart';
import 'package:movies/ui/tabs/home_tab/cubit/movies_state.dart';
import 'package:movies/ui/tabs/home_tab/cubit/movies_view_model.dart';
import '../../../theme/app_colors.dart';
import '../../movieDetails/screens/movie_details_screen.dart';
import 'category_tab.dart';

class MovieCategory extends StatefulWidget {
  static const String routeName = "movies_category";


  @override
  _MovieCategoryState createState() => _MovieCategoryState();
}

class _MovieCategoryState extends State<MovieCategory> {
  int selectedIndex = 0;
  MoviesViewModel viewModel=MoviesViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.getMovies();
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
      body: BlocProvider(
        create: (context) => viewModel,
        child: BlocBuilder<MoviesViewModel, MoviesStates>(
          builder: (context, state) {
            if(state is MoviesLoadingState){
              return const Center(
                child: CircularProgressIndicator(color: AppColors.yellowColor),
              );
            }
            else if(state is MoviesErrorState){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage,style: AppStyle.semi20Yellow),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          viewModel.getMovies();
                        }); // Refresh the FutureBuilder
                      },
                      child: const Text("Try again"),
                    ),
                  ],
                ),
              );
            }
            else if (state is MoviesLoadedState) {
              final movies = state.moviesList;
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
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: categorizedMovies[genre]?.length ?? 0,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  print(" Id ${movies[index].id!}");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailsScreen(movieId: movies[index].id!),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      child: Image.network(
                                        movies[index].mediumCoverImage! ?? '',
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Center(
                                            child: Icon(Icons.error, color: AppColors.redColor),
                                          );
                                        },
                                      ),
                                    ),
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
                                        padding: EdgeInsets.only(left: width * .03),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "${movies[index].rating.toString()}" ?? " ",
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
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text("No data available"),
              );
            }
          },
        ),
      ),
    );
  }
}