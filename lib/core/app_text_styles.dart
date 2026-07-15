import 'package:flutter/material.dart';
import 'package:tvk_grievance/core/constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const heading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static const subHeading = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static const body = TextStyle(fontSize: 13, color: AppColors.black);

  static const caption = TextStyle(fontSize: 11, color: AppColors.grey);

  static const dashboardNumber = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xffFFC107),
  );

  static const dashboardLabel = TextStyle(
    fontSize: 11,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
}
