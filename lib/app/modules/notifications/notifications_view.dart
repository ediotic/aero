import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

import 'notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientPageScaffold(
      headerHeight: 130,
      overlap: 20,
      onRefresh: controller.load,
      header: Column(
        children: <Widget>[
          ScreenHeaderBar(
            title: AppStrings.notifications,
            trailing: GestureDetector(
              onTap: controller.markAllRead,
              child: Text(
                AppStrings.markAllRead,
                style: AppTextStyles.body(13, weight: FontWeight.w700, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.screenPadding),
              itemCount: NotificationFilter.values.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, int i) {
                final NotificationFilter f = NotificationFilter.values[i];
                return Obx(
                  () => PillChip(
                    label: controller.filterLabel(f),
                    selected: controller.filter.value == f,
                    style: PillStyle.onDark,
                    onTap: () => controller.setFilter(f),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      children: <Widget>[
        const SizedBox(height: 18),
        Obx(() {
          if (controller.loading.value) return const LoadingView();
          final List<AppNotification> today = controller.today;
          final List<AppNotification> earlier = controller.earlier;
          if (today.isEmpty && earlier.isEmpty) {
            return const EmptyView(message: AppStrings.noNotifications, icon: Icons.notifications_off_outlined);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (today.isNotEmpty) ...<Widget>[
                const GroupLabel(AppStrings.today),
                const SizedBox(height: 10),
                for (final AppNotification n in today) _NotificationTile(item: n, controller: controller),
              ],
              if (earlier.isNotEmpty) ...<Widget>[
                const SizedBox(height: 8),
                const GroupLabel(AppStrings.earlier),
                const SizedBox(height: 10),
                for (final AppNotification n in earlier) _NotificationTile(item: n, controller: controller),
              ],
            ],
          );
        }),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.item, required this.controller});

  final AppNotification item;
  final NotificationsController controller;

  @override
  Widget build(BuildContext context) {
    final bool alert = item.type == NotificationType.delay;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        padding: const EdgeInsets.all(14),
        borderColor: item.unread ? AppColors.primaryBorder : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconTile(
              icon: controller.iconFor(item.type),
              background: alert ? AppColors.warningSoft : AppColors.primarySoft,
              color: alert ? AppColors.warning : AppColors.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(child: Text(item.title, style: AppTextStyles.cardTitle)),
                      if (item.unread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(item.body, style: AppTextStyles.body(13, color: AppColors.muted, height: 1.4)),
                  const SizedBox(height: 6),
                  Text(item.timeLabel, style: AppTextStyles.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
