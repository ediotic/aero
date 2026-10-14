import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientPageScaffold(
      nav: NavTab.profile,
      headerHeight: 180,
      overlap: 70,
      onRefresh: controller.load,
      header: Obx(() {
        final UserProfile? p = controller.profile.value;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.screenPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 76,
                height: 76,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white(0.18),
                  border: Border.all(color: AppColors.white(0.5), width: 3),
                ),
                child: Text(p?.initials ?? '', style: AppTextStyles.display(26, color: Colors.white)),
              ),
              const SizedBox(height: 10),
              Text(p?.name ?? '', style: AppTextStyles.display(21, color: Colors.white)),
              Text(p?.email ?? '', style: AppTextStyles.body(13, color: AppColors.white(0.8))),
            ],
          ),
        );
      }),
      children: <Widget>[
        Obx(() {
          final UserProfile? p = controller.profile.value;
          if (p == null) return const LoadingView(height: 120);
          return AppCard(
            shadows: AppShadows.raised,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const IconTile(icon: Icons.workspace_premium_rounded, gradient: AppGradients.button, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(p.tier, style: AppTextStyles.cardTitle),
                          Text('${p.points} ${AppStrings.points}', style: AppTextStyles.caption),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 28, color: AppColors.divider),
                Row(
                  children: <Widget>[
                    Expanded(child: _Stat('${p.trips}', AppStrings.trips)),
                    Expanded(child: _Stat(p.miles, AppStrings.miles)),
                    Expanded(child: _Stat('${p.countries}', AppStrings.countries)),
                  ],
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 20),
        const GroupLabel(AppStrings.account),
        const SizedBox(height: 10),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: <Widget>[
              SettingsTile(icon: Icons.person_outline_rounded, title: AppStrings.personalInfo, onTap: controller.comingSoon),
              Obx(
                () => SettingsTile(
                  icon: Icons.group_outlined,
                  title: AppStrings.savedPassengers,
                  value: '${controller.profile.value?.savedPassengers ?? 0}',
                  onTap: controller.comingSoon,
                ),
              ),
              SettingsTile(
                icon: Icons.credit_card_rounded,
                title: AppStrings.paymentMethods,
                showDivider: false,
                onTap: controller.comingSoon,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const GroupLabel(AppStrings.preferences),
        const SizedBox(height: 10),
        AppCard(
          padding: EdgeInsets.zero,
          child: Obx(
            () => Column(
              children: <Widget>[
                SettingsTile(
                  icon: Icons.notifications_none_rounded,
                  title: AppStrings.pushAlerts,
                  showChevron: false,
                  onTap: controller.openNotifications,
                  trailing: AppToggle(value: controller.pushAlerts.value, onChanged: controller.pushAlerts.call),
                ),
                SettingsTile(
                  icon: Icons.mail_outline_rounded,
                  title: AppStrings.emailUpdates,
                  showChevron: false,
                  trailing: AppToggle(value: controller.emailUpdates.value, onChanged: controller.emailUpdates.call),
                ),
                SettingsTile(
                  icon: Icons.fingerprint_rounded,
                  title: AppStrings.biometric,
                  showChevron: false,
                  trailing: AppToggle(value: controller.biometric.value, onChanged: controller.biometric.call),
                ),
                SettingsTile(
                  icon: Icons.dark_mode_outlined,
                  title: AppStrings.darkMode,
                  showChevron: false,
                  showDivider: false,
                  trailing: AppToggle(value: controller.darkMode.value, onChanged: controller.darkMode.call),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: <Widget>[
              SettingsTile(icon: Icons.help_outline_rounded, title: AppStrings.helpSupport, onTap: controller.comingSoon),
              SettingsTile(
                icon: Icons.logout_rounded,
                title: AppStrings.logout,
                danger: true,
                showChevron: false,
                showDivider: false,
                onTap: controller.logout,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.value, this.label);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(value, style: AppTextStyles.display(20)),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}
