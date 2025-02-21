import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/movieDetails/screens/movie_details_screen.dart';
import 'package:movies/ui/movieDetails/movie_suggestion/cubit/movie_suggestin_cubit.dart';
import 'package:movies/ui/movieDetails/movie_suggestion/cubit/movie_suggestion_state.dart';
import 'package:movies/ui/widgets/moive_item.dart';

class MoviesSuggestionScreen extends StatefulWidget {
  int movieId;
   MoviesSuggestionScreen({required this.movieId,super.key});

  @override
  State<MoviesSuggestionScreen> createState() => _MoviesSuggestionScreenState();
}

class _MoviesSuggestionScreenState extends State<MoviesSuggestionScreen> {
  MovieSuggestionCubit viewModel=MovieSuggestionCubit();
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.fetchMovieSuggestion(widget.movieId);
  }
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context)=>viewModel,
      child: BlocBuilder<MovieSuggestionCubit,MovieSuggestionState>
        (builder: (context, state) {
          if(state is MovieSuggestionErrorState){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage,style: AppStyle.semi20Yellow),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        viewModel.fetchMovieSuggestion(widget.movieId);
                      }); // Refresh the FutureBuilder
                    },
                    child: const Text("Try again"),
                  ),
                ],
              ),
            );
          }
          else if(state is MovieSuggestionLoadingState){
            return const Center(
              child: CircularProgressIndicator(color: AppColors.yellowColor),
            );
          }
          else if(state is MovieSuggestionLoadedState){
            final movies=state.movieSuggestion.data!.movies!;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 8,
                childAspectRatio:
                0.7, // Aspect ratio of each item (width / height)
              ),
              itemCount: movies.length?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print(" Id ${movies[index].id!}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(movieId: movies[index].id!,),
                      ),
                    );
                  }
                  , child: MoiveItem(index: index,movies: movies,)
                );
              },
            );
          }

          return Container();
        },),
    );


  }
}
