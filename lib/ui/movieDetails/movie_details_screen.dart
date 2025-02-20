import 'package:flutter/material.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/apis/api_manager.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

   MovieDetailsScreen({required this.movieId}) ;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<Map<String, dynamic>?> _movieDetailsFuture;

  @override
  void initState() {
    super.initState();
    _movieDetailsFuture = ApiManager.fetchMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _movieDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found.'));
          }

          final movie = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (movie['large_cover_image'] != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(movie['large_cover_image']),
                  ),
                const SizedBox(height: 16),
                Text(
                  movie['title_long'] ?? 'No Title',
                  style: AppStyle.bold14Yellow,
                ),
                const SizedBox(height: 8),
                Text(
                  'Rating: ${movie['rating'] ?? 'N/A'} ⭐ | Runtime: ${movie['runtime']} mins',
                  style: AppStyle.regular16WhiteRoboto
                ),
                const SizedBox(height: 16),
                Text(
                  movie['description_full'] ?? 'No description available.',
                  style:  AppStyle.regular16WhiteRoboto,
                ),
                const SizedBox(height: 20),
                if (movie['cast'] != null) ...[
                  Text(
                    'Cast:',
                    style:  AppStyle.regular16WhiteRoboto,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movie['cast'].length,
                      itemBuilder: (context, index) {
                        final cast = movie['cast'][index];
                        return Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 12),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: cast['url_small_image'] != null
                                    ? NetworkImage(cast['url_small_image'])
                                    : null,
                                child: cast['url_small_image'] == null
                                    ? const Icon(Icons.person, size: 40)
                                    : null,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                cast['name'] ?? '',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
