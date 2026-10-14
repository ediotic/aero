import 'package:flutter/material.dart';

import '../core/core.dart';
import 'icon_tile.dart';

/// One row of a settings list: icon, title and a trailing widget or chevron.
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.trailing,
    this.onTap,
    this.danger = false,
    this.showDivider = true,
    this.showChevron = true,
  });

  final IconData icon;
  final String title;

  /// Muted text shown before the chevron, e.g. "English".
  final String? value;

  /// Replaces the value and chevron (used for toggles).
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool danger;
  final bool showDivider;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final Color accent = danger ? AppColors.danger : AppColors.primary;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(bottom: BorderSide(color: AppColors.divider, width: 1.5))
              : null,
        ),
        child: Row(
          children: <Widget>[
            IconTile(
              icon: icon,
              size: 38,
              color: accent,
              background: danger ? AppColors.dangerSofter : AppColors.primarySoft,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.body(
                  14,
                  weight: FontWeight.w700,
                  color: danger ? AppColors.danger : AppColors.ink,
                ),
              ),
            ),
            if (trailing != null)
              trailing!
            else ...<Widget>[
              if (value != null)
                Text(value!, style: AppTextStyles.body(13, color: AppColors.muted)),
              if (showChevron && !danger)
                const Icon(Icons.chevron_right_rounded, color: AppColors.mutedLight, size: 22),
            ],
          ],
        ),
      ),
    );
  }
}
