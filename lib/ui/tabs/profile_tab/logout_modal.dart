import 'package:flutter/material.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_style.dart';
import '../../widgets/cutom_button.dart';

void showLogoutModal(BuildContext context, Function(BuildContext) logoutFunction) {
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
            Icon(Icons.exit_to_app, size: 50, color: AppColors.redColor),
            SizedBox(height: 16),
            Text("Logout", style: AppStyle.bold24WhiteRoboto),
            SizedBox(height: 8),
            Text(
              "Are you sure you want to log out?",
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
                    text: "Logout",
                    color: AppColors.redColor,
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      Navigator.pop(context);
                      logoutFunction(context);
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
