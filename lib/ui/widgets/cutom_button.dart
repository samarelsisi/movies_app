import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final IconData? icon;
  final String? assetImage;
  final bool isLeading;
  final double? width;

  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    this.textColor = Colors.black, // Default text color is black
    required this.onPressed,
    this.icon,
    this.assetImage,
    this.isLeading = true,
    this.width,
  })  : assert(icon == null || assetImage == null, "Use either icon or assetImage, not both."),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget;

    if (assetImage != null) {
      leadingWidget = Image.asset(assetImage!, width: 24, height: 24);
    } else if (icon != null) {
      leadingWidget = Icon(icon, size: 24, color: textColor); // Set icon color same as textColor
    }

    Widget button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor, // Apply text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingWidget != null && isLeading) ...[
            leadingWidget,
            const SizedBox(width: 10),
          ],
          Text(
            text,
            style: AppStyle.regular20Black.copyWith(color: textColor), // Set text color dynamically
          ),
          if (leadingWidget != null && !isLeading) ...[
            const SizedBox(width: 10),
            leadingWidget,
          ],
        ],
      ),
    );

    return width != null
        ? SizedBox(width: width, child: button)
        : SizedBox(width: double.infinity, child: button);
  }
}
