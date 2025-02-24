import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/ui/movieDetails/screens/movie_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../theme/app_colors.dart';
import '../../../theme/app_style.dart';
import '../../widgets/placeholder_content.dart';


class FavoritesList extends StatefulWidget {
  final String listType; // "watch" or "history"
  final Function(int)? onListLengthChanged; // Callback for list length changes

  const FavoritesList({
    required this.listType,
    this.onListLengthChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  bool isLoading = true;
  List<dynamic> favorites = [];

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("auth_token");
      if (token == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final url = Uri.parse("https://route-movie-apis.vercel.app/favorites/all");
      final response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final allFavorites = jsonResponse['data'] as List<dynamic>;

        // Read local lists
        List<String> watchListIds = prefs.getStringList('watchList') ?? [];
        List<String> historyListIds = prefs.getStringList('historyList') ?? [];

        setState(() {
          if (widget.listType == "watch") {
            favorites = allFavorites
                .where((movie) => watchListIds.contains(movie['movieId']))
                .toList();
          } else if (widget.listType == "history") {
            favorites = allFavorites
                .where((movie) => historyListIds.contains(movie['movieId']))
                .toList();
          }
          isLoading = false;

          // Notify the parent widget about the list length
          widget.onListLengthChanged?.call(favorites.length);
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (isLoading) return Center(child: CircularProgressIndicator(color: AppColors.yellowColor));
    if (favorites.isEmpty) return PlaceholderContent();
    return GridView.builder(
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount:  favorites.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                favorites[index]['imageURL']! ?? '',
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
                width: width * .16,
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
                      "${favorites[index]['rating'].toString()}" ?? " ",
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

  }
}



