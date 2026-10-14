import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

import 'seat_selection_controller.dart';

class SeatSelectionView extends GetView<SeatSelectionController> {
  const SeatSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientPageScaffold(
      headerHeight: 76,
      overlap: 60,
      header: ScreenHeaderBar(
        title: AppStrings.selectSeat,
        subtitle: '${controller.flight.flightNo} · ${controller.flight.fromCode} → ${controller.flight.toCode}',
      ),
      bottomBar: BottomActionBar(
        child: Obx(() {
          final Seat? s = controller.selected.value;
          return Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(s == null ? AppStrings.noSeatSelected : '${AppStrings.seat} ${s.id}', style: AppTextStyles.caption),
                  Text(Formatters.rupee(controller.total), style: AppTextStyles.price),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: GradientButton(label: AppStrings.continueLabel, onTap: controller.confirm),
              ),
            ],
          );
        }),
      ),
      children: <Widget>[
        const _Legend(),
        const SizedBox(height: 14),
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Obx(() {
            if (controller.loading.value) return const LoadingView();
            return Column(
              children: <Widget>[
                const _ColumnHeader(),
                const SizedBox(height: 10),
                for (final int row in controller.rows) ...<Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < SeatSelectionController.letters.length; i++) ...<Widget>[
                        if (i == 3)
                          SizedBox(
                            width: 28,
                            child: Center(
                              child: Text('$row', style: AppTextStyles.body(11, weight: FontWeight.w600, color: AppColors.mutedLight)),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: _cell(row, SeatSelectionController.letters[i]),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ],
            );
          }),
        ),
      ],
    );
  }
}

extension on SeatSelectionView {
  // Called synchronously inside Obx so Rx reads are tracked.
  Widget _cell(int row, String letter) {
    final Seat seat = controller.seatAt(row, letter);
    return SeatBox(
      seat: seat,
      selected: controller.selected.value?.id == seat.id,
      onTap: () => controller.select(seat),
    );
  }
}

class _ColumnHeader extends StatelessWidget {
  const _ColumnHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < SeatSelectionController.letters.length; i++) ...<Widget>[
          if (i == 3) const SizedBox(width: 28),
          SizedBox(
            width: 42,
            child: Center(
              child: Text(
                SeatSelectionController.letters[i],
                style: AppTextStyles.body(12, weight: FontWeight.w700, color: AppColors.muted),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    Widget dot(Color c, Color b, String label) => Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: b, width: 1.5),
              ),
            ),
            const SizedBox(width: 6),
            Text(label, style: AppTextStyles.caption),
          ],
        );

    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: <Widget>[
        dot(AppColors.surface, AppColors.border, AppStrings.seatAvailable),
        dot(AppColors.warningSofter, AppColors.seatPremiumBorder, AppStrings.seatPremium),
        dot(AppColors.primary, AppColors.primary, AppStrings.seatSelected),
        dot(AppColors.seatTaken, AppColors.seatTaken, AppStrings.seatTaken),
      ],
    );
  }
}
