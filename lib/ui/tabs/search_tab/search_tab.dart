import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/movieDetails/screens/movie_details_screen.dart';
import 'package:movies/ui/tabs/search_tab/cubit/search_cubit.dart';
import 'package:movies/ui/tabs/search_tab/cubit/search_states.dart';
import 'package:movies/ui/widgets/moive_item.dart';
import 'package:movies/ui/widgets/placeholder_content.dart';
import '../../../theme/app_colors.dart';
import '../../widgets/custom_text_field.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController searchController = TextEditingController();
  SearchCubit viewModel =SearchCubit();
  @override
  void initState() {
    super.initState();
    viewModel.fetchMovies();

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
            onChange: (query) {
              viewModel.searchMovies(query);
            },
          ),
          Expanded(
            child: BlocProvider(
              create: (context) => viewModel,
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.yellowColor),
                    );
                  } else if (state is SearchError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Something went wrong!", style: AppStyle.semi20Yellow),
                          ElevatedButton(
                            onPressed: () {
                             viewModel.fetchMovies();
                            },
                            child: const Text("Try again"),
                          ),
                        ],
                      ),
                    );
                  } else if (state is SearchLoaded) {
                    final movies = state.filteredMovies;
                    return searchController.text.isNotEmpty && movies.isEmpty
                        ? PlaceholderContent()
                        : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(movieId: movies[index].id!),
                              ),
                            );
                          },
                          child: MoiveItem(index: index, movies: movies),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text("No data available"),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}