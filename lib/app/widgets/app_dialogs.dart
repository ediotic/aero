import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/core.dart';

class AppDialogs {
  AppDialogs._();

  /// Yes/no dialog. Returns true when the user confirms.
  static Future<bool> confirm({
    required String title,
    required String message,
    required String confirmLabel,
    String cancelLabel = AppStrings.cancel,
    bool danger = false,
  }) async {
    final bool? result = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(title, style: AppTextStyles.display(18)),
        content: Text(message, style: AppTextStyles.body(14, color: AppColors.muted, height: 1.5)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back<bool>(result: false),
            child: Text(
              cancelLabel,
              style: AppTextStyles.body(14, weight: FontWeight.w700, color: AppColors.muted),
            ),
          ),
          TextButton(
            onPressed: () => Get.back<bool>(result: true),
            child: Text(
              confirmLabel,
              style: AppTextStyles.body(
                14,
                weight: FontWeight.w700,
                color: danger ? AppColors.danger : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Bottom sheet with a list of choices. Returns the picked index or null.
  static Future<int?> options({
    required String title,
    required List<String> choices,
  }) {
    return Get.bottomSheet<int>(
      Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimens.sheetRadius)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.dash,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(title, style: AppTextStyles.display(18)),
              const SizedBox(height: 8),
              for (int i = 0; i < choices.length; i++)
                InkWell(
                  onTap: () => Get.back<int>(result: i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      choices[i],
                      style: AppTextStyles.body(15, weight: FontWeight.w600),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
