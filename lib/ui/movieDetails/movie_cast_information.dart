import 'package:flutter/material.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/models/MoviesDetailsResponse.dart';

class MovieCastInformation extends StatelessWidget {
  List<Cast>cast;
   MovieCastInformation({required this.cast,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: cast?.isEmpty ?? true
          ? Center(
        child: Text(
          "No cast data available",
          style: AppStyle.bold24White,
        ),
      )
          : ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final castMember = cast![index];
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    castMember.urlSmallImage ?? "",
                    height: 100, // Adjust as needed
                    width: 100, // Adjust as needed
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.grey,
                      ); // Fallback for failed image load
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: ${castMember.name ?? "N/A"}",
                        style: AppStyle.regular16WhiteRoboto,
                      ),
                      Text(
                        "Character: ${castMember.characterName ?? "N/A"}",
                        style: AppStyle.regular16WhiteRoboto,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: cast?.length ?? 0,
      ),
    );
  }
}
