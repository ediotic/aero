import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

/// One place for toasts so every screen looks the same.
class AppSnackbar {
  AppSnackbar._();

  static void info(String title, String message) =>
      _show(title, message, AppColors.navy800);

  static void success(String title, String message) =>
      _show(title, message, AppColors.success);

  static void error(String title, String message) =>
      _show(title, message, AppColors.danger);

  static void _show(String title, String message, Color background) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
    Get.snackbar(
      title,
      message,
      backgroundColor: background,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 18,
      duration: const Duration(seconds: 3),
    );
  }
}
