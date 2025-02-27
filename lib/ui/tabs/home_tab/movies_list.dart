
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/ui/movieDetails/screens/movie_details_screen.dart';
import 'package:movies/ui/widgets/moive_item.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_image.dart';
import '../../../theme/app_style.dart';
import '../../data/services/favorites_service.dart';
import '../../models/MoviesDataResponse.dart';
import '../../movieDetails/cubit/movie_details_view_model.dart';
import '../profile_tab/favorites_repository.dart';
import 'cubit/favorites_cubit.dart';
import 'movies_carousel.dart';

class MoviesList extends StatelessWidget {
  final List<Movies> movies;
  MoviesList({required this.movies ,super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return  SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: height*.68,
            child: Stack(
              children: [
                Image.asset(AppImage.homeBg,fit: BoxFit.cover,width: double.infinity,),
                Align(
                    child: MovieCarousel(movies: movies)),
                SizedBox(
                  height: .1,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Action",style: AppStyle.regular20WhiteRoboto,),
                Row(
                  children: [
                    Text("See More",style: AppStyle.bold14Yellow,),
                    SizedBox(
                      width: width*.02,
                    ),
                    Icon(Icons.arrow_forward,color: AppColors.yellowColor,)
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: height*.3,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: width*.04,
                );
              },
              itemCount:movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (_) => MovieDetailsCubit(),
                                ),
                                BlocProvider(
                                  create: (_) => FavoritesCubit(
                                    favoritesService: FavoritesService(),
                                    favoritesRepository: FavoritesRepository(),
                                  ),
                                ),
                              ],
                              child: MovieDetailsScreen(movieId: movies[index].id!),
                            ),
                          ),
                        );
                      },
                      child: MoiveItem(
                        index: index,
                        movies: movies,
                        containerWidth: width * .4,
                      ),
                    )

                  ],
                );
              },),
          )
        ],
      ),
    );
  }
}
