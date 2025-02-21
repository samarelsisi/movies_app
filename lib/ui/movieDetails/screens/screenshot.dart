import 'package:flutter/material.dart';

class Screenshot extends StatelessWidget {
  int index;
  List<dynamic>screenShots;
   Screenshot({required this.screenShots ,required this.index,super.key});

  @override
  Widget build(BuildContext context) {
    return    ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.network(
        screenShots[index],
        width: double.infinity,
        fit: BoxFit.cover,)
      );
  }
}
