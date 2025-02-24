import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../theme/app_colors.dart';
import '../../../theme/app_style.dart';
import '../../widgets/placeholder_content.dart';


class FavoritesList extends StatefulWidget {
  final String listType; // "watch" or "history"
  const FavoritesList({required this.listType, Key? key}) : super(key: key);

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
        // Read local lists:
        List<String> watchListIds = prefs.getStringList('watchList') ?? [];
        List<String> historyListIds = prefs.getStringList('historyList') ?? [];

        setState(() {
          if (widget.listType == "watch") {
            favorites = allFavorites.where((movie) => watchListIds.contains(movie['movieId'])).toList();
          } else if (widget.listType == "history") {
            favorites = allFavorites.where((movie) => historyListIds.contains(movie['movieId'])).toList();
          }
          isLoading = false;
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
    if (isLoading) return Center(child: CircularProgressIndicator(color: AppColors.yellowColor));
    if (favorites.isEmpty) return PlaceholderContent();
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final movie = favorites[index];
        return ListTile(
          leading: Image.network(movie['imageURL'], width: 50, height: 50, fit: BoxFit.cover),
          title: Text(movie['name'], style: AppStyle.regular20White),
          subtitle: Text("${movie['year']} - Rating: ${movie['rating']}"),
          // Optionally, add an icon to remove from the list.
        );
      },
    );
  }
}



