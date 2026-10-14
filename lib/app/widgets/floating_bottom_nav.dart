import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/core.dart';
import '../routes/app_routes.dart';
import 'plane_icon.dart';

enum NavTab { home, trips, status, profile, none }

/// Floating pill navigation with a raised circular flight button in the
/// middle. Pass [NavTab.none] on screens that are not one of the four tabs.
class FloatingBottomNav extends StatelessWidget {
  const FloatingBottomNav({super.key, required this.active});

  final NavTab active;

  void _go(NavTab tab, String route) {
    if (tab == active) return;
    Get.offAllNamed<void>(route);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.navTotalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: AppDimens.navBarHeight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimens.navBarHeight / 2),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color.fromRGBO(18, 24, 80, 0.20),
                    blurRadius: 34,
                    offset: Offset(0, 14),
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(18, 24, 80, 0.08),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _NavItem(
                        icon: Icons.home_rounded,
                        label: AppStrings.navHome,
                        selected: active == NavTab.home,
                        onTap: () => _go(NavTab.home, AppRoutes.home),
                      ),
                      _NavItem(
                        icon: Icons.confirmation_number_outlined,
                        label: AppStrings.navTrips,
                        selected: active == NavTab.trips,
                        onTap: () => _go(NavTab.trips, AppRoutes.myTrips),
                      ),
                    ],
                  ),
                  const SizedBox(width: 68),
                  Row(
                    children: <Widget>[
                      _NavItem(
                        icon: Icons.explore_outlined,
                        label: AppStrings.navStatus,
                        selected: active == NavTab.status,
                        onTap: () => _go(NavTab.status, AppRoutes.flightStatus),
                      ),
                      _NavItem(
                        icon: Icons.person_outline_rounded,
                        label: AppStrings.navProfile,
                        selected: active == NavTab.profile,
                        onTap: () => _go(NavTab.profile, AppRoutes.profile),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Semantics(
              button: true,
              label: AppStrings.searchFlights,
              child: GestureDetector(
                onTap: () => Get.toNamed<void>(AppRoutes.searchFlights),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppGradients.seatSelected,
                    boxShadow: <BoxShadow>[
                      // The "ring" that cuts the button out of the pill.
                      const BoxShadow(color: AppColors.background, spreadRadius: 6),
                      BoxShadow(
                        color: AppColors.alpha(AppColors.primary, 0.5),
                        blurRadius: 30,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const PlaneIcon(size: 30, angle: PlaneIcon.diagonal),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = selected ? AppColors.primary : AppColors.navInactive;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 62,
        height: 56,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, color: color, size: 22),
                const SizedBox(height: 3),
                Text(label, style: AppTextStyles.body(11, weight: FontWeight.w600, color: color)),
              ],
            ),
            if (selected)
              Positioned(
                bottom: 2,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
