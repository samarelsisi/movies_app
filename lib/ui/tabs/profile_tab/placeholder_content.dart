import 'package:flutter/cupertino.dart';

import '../../../theme/app_image.dart';

class PlaceholderContent extends StatelessWidget {
  const PlaceholderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(AppImage.emptyList),
    );
  }
}

