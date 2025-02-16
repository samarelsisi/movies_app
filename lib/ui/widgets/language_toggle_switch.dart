import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_image.dart';

class LanguageToggleSwitch extends StatefulWidget {
  final Function(bool isEnglish) onToggle;

  const LanguageToggleSwitch({Key? key, required this.onToggle}) : super(key: key);

  @override
  _LanguageToggleSwitchState createState() => _LanguageToggleSwitchState();
}

class _LanguageToggleSwitchState extends State<LanguageToggleSwitch> {
  bool isEnglish = true;

  void _toggleLanguage() {
    setState(() {
      isEnglish = !isEnglish;
    });
    widget.onToggle(isEnglish);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.blackColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.yellowColor, width: 3),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: isEnglish ? 2 : 52,
              top: 2,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.yellowColor,
                ),
              ),
            ),
            Positioned(
              left: 2,
              top: 2,
              child: Image.asset(AppImage.usaFlag, width: 40, height: 40),
            ),
            Positioned(
              right: 2,
              top: 2,
              child: Image.asset(AppImage.egyptFlag, width: 40, height: 40),
            ),
          ],
        ),
      ),
    );
  }
}
