import 'package:flutter/material.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_style.dart';
import 'cutom_button.dart';

void showConfirmModal({
  required BuildContext context,
  required String title,
  required String message,
  required IconData icon,
  required Color iconColor,
  required String confirmButtonText,
  required Color confirmButtonColor,
  required Function(BuildContext) onConfirm,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 50, color: iconColor),
            SizedBox(height: 16),
            Text(title, style: AppStyle.bold24WhiteRoboto),
            SizedBox(height: 8),
            Text(
              message,
              style: AppStyle.bold20WhiteRoboto,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Cancel",
                    color: AppColors.greyColor.withOpacity(0.7),
                    textColor: AppColors.whiteColor,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: confirmButtonText,
                    color: confirmButtonColor,
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
