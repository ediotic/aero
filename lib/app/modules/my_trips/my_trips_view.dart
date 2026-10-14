import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

import 'my_trips_controller.dart';

class MyTripsView extends GetView<MyTripsController> {
  const MyTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientPageScaffold(
      nav: NavTab.trips,
      headerHeight: 140,
      overlap: 20,
      onRefresh: controller.load,
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(AppDimens.screenPadding, 16, AppDimens.screenPadding, 0),
            child: Text(AppStrings.myTrips, style: AppTextStyles.display(26, color: Colors.white)),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.screenPadding),
              itemCount: MyTripsController.tabs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, int i) => Obx(() {
                final TripStatus s = MyTripsController.tabs[i];
                return PillChip(
                  label: '${controller.tabLabel(s)} (${controller.countFor(s)})',
                  selected: controller.tab.value == i,
                  style: PillStyle.onDark,
                  onTap: () => controller.selectTab(i),
                );
              }),
            ),
          ),
        ],
      ),
      children: <Widget>[
        const SizedBox(height: 18),
        Obx(() {
          if (controller.loading.value) return const LoadingView();
          final List<Trip> list = controller.visibleTrips;
          if (list.isEmpty) {
            return const EmptyView(message: AppStrings.noTrips, icon: Icons.luggage_outlined);
          }
          return Column(
            children: <Widget>[
              for (final Trip t in list) ...<Widget>[
                _TripCard(
                  trip: t,
                  expanded: controller.expandedPnr.value == t.pnr,
                  controller: controller,
                ),
                const SizedBox(height: 14),
              ],
            ],
          );
        }),
      ],
    );
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({required this.trip, required this.expanded, required this.controller});

  final Trip trip;
  final bool expanded;
  final MyTripsController controller;

  @override
  Widget build(BuildContext context) {
    final bool upcoming = trip.status == TripStatus.confirmed;
    return AppCard(
      onTap: () => controller.toggleExpand(trip),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              AirlineLogo(code: trip.airlineCode, size: 36),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${trip.airlineName} · ${trip.flightNo}', style: AppTextStyles.cardTitle),
                    Text('${AppStrings.pnr} ${trip.pnr}', style: AppTextStyles.caption),
                  ],
                ),
              ),
              _statusChip(trip.status),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              _End(code: trip.fromCode, time: trip.departTime, end: false),
              const Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: RouteLine())),
              _End(code: trip.toCode, time: trip.arriveTime, end: true),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.muted),
              const SizedBox(width: 6),
              Text(Formatters.dayDateYear(trip.date), style: AppTextStyles.caption),
              const Spacer(),
              Icon(expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded, color: AppColors.muted),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            alignment: Alignment.topCenter,
            child: !expanded
                ? const SizedBox(width: double.infinity)
                : Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Column(
                      children: <Widget>[
                        const Divider(height: 1, color: AppColors.divider),
                        const SizedBox(height: 14),
                        Row(
                          children: <Widget>[
                            Expanded(child: _Info(AppStrings.seat, trip.seat)),
                            Expanded(child: _Info(AppStrings.baggage, '${trip.baggageKg} kg')),
                            Expanded(child: _Info(AppStrings.status, controller.tabLabel(trip.status))),
                          ],
                        ),
                        if (upcoming) ...<Widget>[
                          const SizedBox(height: 16),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: ActionButton(
                                  label: AppStrings.boardingPass,
                                  icon: Icons.qr_code_2_rounded,
                                  onTap: () => controller.viewBoardingPass(trip),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ActionButton(
                                  label: AppStrings.changeFlight,
                                  icon: Icons.swap_horiz_rounded,
                                  onTap: () => controller.changeFlight(trip),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: ActionButton(
                                  label: AppStrings.addBaggage,
                                  icon: Icons.luggage_outlined,
                                  onTap: () => controller.addBaggage(trip),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ActionButton.danger(
                                  label: AppStrings.cancelTrip,
                                  icon: Icons.close_rounded,
                                  onTap: () => controller.cancel(trip),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(TripStatus s) {
    switch (s) {
      case TripStatus.confirmed:
        return StatusChip.tone(AppStrings.confirmed, BadgeTone.success);
      case TripStatus.completed:
        return StatusChip.tone(AppStrings.completed, BadgeTone.neutral);
      case TripStatus.cancelled:
        return const StatusChip(
          label: AppStrings.cancelled,
          background: AppColors.dangerSoft,
          foreground: AppColors.danger,
          fontSize: 11,
        );
    }
  }
}

class _End extends StatelessWidget {
  const _End({required this.code, required this.time, required this.end});
  final String code;
  final String time;
  final bool end;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: end ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Text(code, style: AppTextStyles.display(24)),
        Text(time, style: AppTextStyles.caption),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  const _Info(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: AppTextStyles.caption),
        const SizedBox(height: 2),
        Text(value, style: AppTextStyles.body(14, weight: FontWeight.w700)),
      ],
    );
  }
}
