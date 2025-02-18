import 'package:flutter/material.dart';

class AvatarSelector extends StatefulWidget {
  final List<String> avatarImages;
  final int selectedAvatarIndex;
  final Function(int) onAvatarSelected;

  const AvatarSelector({
    Key? key,
    required this.avatarImages,
    required this.selectedAvatarIndex,
    required this.onAvatarSelected,
  }) : super(key: key);

  @override
  _AvatarSelectorState createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedAvatarIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: PageView.builder(
        itemCount: widget.avatarImages.length,
        controller: PageController(viewportFraction: 0.25, initialPage: selectedIndex),
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
          widget.onAvatarSelected(index); // Notify parent widget
        },
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onAvatarSelected(index); // Notify parent widget
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Transform.scale(
                scale: isSelected ? 2.0 : 1.0, // Scale effect for selected avatar
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(
                      vertical: isSelected ? 0 : 10, horizontal: 8),
                  width: isSelected ? 120 : 60,
                  height: isSelected ? 120 : 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(widget.avatarImages[index]),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
