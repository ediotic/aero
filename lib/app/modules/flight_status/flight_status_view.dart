import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

import 'flight_status_controller.dart';

class FlightStatusView extends GetView<FlightStatusController> {
  const FlightStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientPageScaffold(
      nav: NavTab.status,
      headerHeight: 150,
      overlap: 20,
      onRefresh: controller.load,
      header: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            Text(AppStrings.flightStatus, style: AppTextStyles.display(26, color: Colors.white)),
            const SizedBox(height: 16),
            AppInputField(
              controller: controller.search,
              hint: AppStrings.statusSearchHint,
              prefixIcon: Icons.search_rounded,
              fillColor: Colors.white,
              borderColor: null,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => controller.load(),
            ),
          ],
        ),
      ),
      children: <Widget>[
        const SizedBox(height: 18),
        Obx(() {
          if (controller.loading.value) return const LoadingView();
          if (controller.statuses.isEmpty) {
            return const EmptyView(message: AppStrings.noStatus, icon: Icons.flight_outlined);
          }
          return Column(
            children: <Widget>[
              for (final FlightStatusInfo s in controller.statuses) ...<Widget>[
                _StatusCard(info: s, controller: controller),
                const SizedBox(height: 14),
              ],
            ],
          );
        }),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.info, required this.controller});

  final FlightStatusInfo info;
  final FlightStatusController controller;

  @override
  Widget build(BuildContext context) {
    final bool delayed = info.status == FlightStatusType.delayed;
    final bool cancelled = info.status == FlightStatusType.cancelled;
    final TextStyle timeStyle = AppTextStyles.display(
      22,
      color: cancelled ? AppColors.mutedLight : AppColors.ink,
    );

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              AirlineLogo(code: info.airlineCode, size: 36),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${info.airlineName} · ${info.flightNo}', style: AppTextStyles.cardTitle),
                    Text(Formatters.dayDateYear(info.date), style: AppTextStyles.caption),
                  ],
                ),
              ),
              StatusChip.flightStatus(info.status),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    info.departTime,
                    style: timeStyle.copyWith(decoration: delayed ? TextDecoration.lineThrough : null),
                  ),
                  if (delayed && info.newDepartTime != null)
                    Text(
                      info.newDepartTime!,
                      style: AppTextStyles.body(14, weight: FontWeight.w700, color: AppColors.warningText),
                    ),
                  Text(info.fromCode, style: AppTextStyles.caption),
                ],
              ),
              const Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: RouteLine())),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(info.arriveTime, style: timeStyle),
                  if (delayed && info.newArriveTime != null)
                    Text(
                      info.newArriveTime!,
                      style: AppTextStyles.body(14, weight: FontWeight.w700, color: AppColors.warningText),
                    ),
                  Text(info.toCode, style: AppTextStyles.caption),
                ],
              ),
            ],
          ),
          if (delayed) ...<Widget>[
            const SizedBox(height: 14),
            _Banner(
              icon: Icons.schedule_rounded,
              text: '${AppStrings.delayedBy} ${info.delayMinutes} ${AppStrings.minutes}. ${info.delayReason}',
              background: AppColors.warningSofter,
              foreground: AppColors.warningText,
            ),
          ],
          if (cancelled) ...<Widget>[
            const SizedBox(height: 14),
            _Banner(
              icon: Icons.error_outline_rounded,
              text: AppStrings.cancelledBanner,
              background: AppColors.dangerSofter,
              foreground: AppColors.danger,
            ),
            const SizedBox(height: 12),
            ActionButton.danger(label: AppStrings.rebook, icon: Icons.refresh_rounded, onTap: () => controller.rebook(info)),
          ] else ...<Widget>[
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                if (info.terminal != null) Expanded(child: _Fact(AppStrings.terminal, info.terminal!)),
                if (info.gate != null) Expanded(child: _Fact(AppStrings.gate, info.gate!)),
                if (info.boardingTime != null) Expanded(child: _Fact(AppStrings.boarding, info.boardingTime!)),
              ],
            ),
            const SizedBox(height: 12),
            ActionButton(
              label: AppStrings.trackOnMap,
              icon: Icons.public_rounded,
              onTap: () => controller.trackOnMap(info),
            ),
          ],
        ],
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.icon, required this.text, required this.background, required this.foreground});

  final IconData icon;
  final String text;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 18, color: foreground),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: AppTextStyles.body(13, weight: FontWeight.w600, color: foreground, height: 1.4)),
          ),
        ],
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: AppTextStyles.caption),
        Text(value, style: AppTextStyles.body(15, weight: FontWeight.w700)),
      ],
    );
  }
}
