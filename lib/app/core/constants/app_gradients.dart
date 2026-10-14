import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppGradients {
  AppGradients._();

  /// Navy to purple header used on most screens.
  static const LinearGradient header = LinearGradient(
    begin: Alignment(-0.4, -1),
    end: Alignment(0.4, 1),
    colors: <Color>[AppColors.navy800, AppColors.navy600, AppColors.primary],
    stops: <double>[0, 0.5, 1],
  );

  static const LinearGradient splash = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[AppColors.navy900, AppColors.navy800, AppColors.navy500],
    stops: <double>[0, 0.5, 1],
  );

  static const LinearGradient onboarding = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[AppColors.navy800, AppColors.navy700, AppColors.indigo],
    stops: <double>[0, 0.58, 1],
  );

  static const LinearGradient button = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[AppColors.primary, AppColors.primaryLight],
  );

  static const LinearGradient brandMark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[AppColors.primaryLight, AppColors.primary, AppColors.primaryDeep],
    stops: <double>[0, 0.55, 1],
  );

  static const LinearGradient seatSelected = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[AppColors.primary, AppColors.primaryLight],
  );

  static const LinearGradient offerPurple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[AppColors.primary, AppColors.primaryLight],
  );

  static const LinearGradient offerNavy = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[AppColors.navy800, AppColors.navy500],
  );

  static const LinearGradient sunset = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[AppColors.sunsetStart, AppColors.sunsetEnd],
  );

  static const LinearGradient night = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[AppColors.navy500, AppColors.primaryLight],
  );

  static const LinearGradient lounge = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[AppColors.navy500, AppColors.primary],
  );

  static const LinearGradient loungeQuiet = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[AppColors.airlineNb, AppColors.teal],
  );

  static const LinearGradient cardChip = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[AppColors.navy800, AppColors.primary],
  );
}
