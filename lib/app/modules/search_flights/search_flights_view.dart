import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

import 'search_flights_controller.dart';

class SearchFlightsView extends GetView<SearchFlightsController> {
  const SearchFlightsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchQuery q = controller.query;
    return GradientPageScaffold(
      headerHeight: 232,
      overlap: 24,
      onRefresh: controller.load,
      header: Column(
        children: <Widget>[
          ScreenHeaderBar(
            title: '${q.fromCode} → ${q.toCode}',
            subtitle: '${Formatters.dayDate(q.date)} · ${q.adults} ${AppStrings.adult} · ${q.cabin}',
            trailing: CircleIconButton(icon: Icons.tune_rounded, onTap: () {}),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 74,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.screenPadding),
              itemCount: controller.dates.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, int i) => Obx(
                () => _DateChip(
                  option: controller.dates[i],
                  selected: controller.dateIndex.value == i,
                  onTap: () => controller.selectDate(i),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.screenPadding),
              itemCount: FlightFilter.values.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, int i) {
                final FlightFilter f = FlightFilter.values[i];
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
        Obx(() {
          if (controller.loading.value) return const LoadingView();
          if (controller.error.value != null) {
            return Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                children: <Widget>[
                  EmptyView(message: controller.error.value!, icon: Icons.wifi_off_rounded),
                  ActionButton.outlined(label: AppStrings.retry, onTap: controller.load),
                ],
              ),
            );
          }
          final List<Flight> list = controller.visibleFlights;
          if (list.isEmpty) {
            return const EmptyView(message: AppStrings.noFlights, icon: Icons.flight_outlined);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 18, 4, 12),
                child: Text(
                  '${list.length} ${AppStrings.flightsFound}',
                  style: AppTextStyles.body(13, weight: FontWeight.w600, color: AppColors.muted),
                ),
              ),
              for (final Flight f in list) ...<Widget>[
                FlightCard(flight: f, onTap: () => controller.openFlight(f)),
                const SizedBox(height: 14),
              ],
            ],
          );
        }),
      ],
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({required this.option, required this.selected, required this.onTap});

  final DateOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 64,
        decoration: BoxDecoration(
          color: selected ? Colors.white : AppColors.white(0.12),
          borderRadius: BorderRadius.circular(20),
          border: selected ? null : Border.all(color: AppColors.white(0.25)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Formatters.weekday(option.date),
              style: AppTextStyles.body(
                11,
                weight: FontWeight.w600,
                color: selected ? AppColors.muted : AppColors.white(0.75),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${option.date.day}',
              style: AppTextStyles.display(18, color: selected ? AppColors.ink : Colors.white),
            ),
            const SizedBox(height: 2),
            Text(
              Formatters.rupeeShort(option.fareFrom),
              style: AppTextStyles.body(
                11,
                weight: FontWeight.w700,
                color: selected ? AppColors.primary : AppColors.white(0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
