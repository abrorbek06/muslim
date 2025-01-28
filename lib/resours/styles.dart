import 'package:flutter/cupertino.dart';
import 'package:taqvim/resours/colors.dart';

abstract class AppStyles {
  static const titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.mainColor,
  ); static const ramadantitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.mainColor,
  );
  static const developedStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.mainColor,
  );
  static const noAdsStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.mainColor,
  );
  static const hijri = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: AppColors.gray,
  );
  static const tasbih_soni = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.gray,
      fontFamily: "Inter"

  );
}
