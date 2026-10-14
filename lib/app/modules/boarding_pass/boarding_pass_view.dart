import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

import 'boarding_pass_controller.dart';

class BoardingPassView extends GetView<BoardingPassController> {
  const BoardingPassView({super.key});

  @override
  Widget build(BuildContext context) {
    final Booking b = controller.booking;
    final Flight f = b.flight;
    return GradientPageScaffold(
      headerHeight: 76,
      overlap: 140,
      header: ScreenHeaderBar(
        title: AppStrings.boardingPass,
        subtitle: AppStrings.bookingConfirmed,
        onBack: controller.goHome,
      ),
      bottomBar: BottomActionBar(
        child: Row(
          children: <Widget>[
            Expanded(
              child: ActionButton.outlined(
                label: AppStrings.share,
                icon: Icons.ios_share_rounded,
                height: 56,
                fontSize: 15,
                onTap: controller.share,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: GradientButton(
                label: AppStrings.addToWallet,
                leadingIcon: Icons.wallet_outlined,
                onTap: controller.addToWallet,
              ),
            ),
          ],
        ),
      ),
      children: <Widget>[
        // Top half of the ticket
        Container(
          padding: const EdgeInsets.all(22),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimens.cardRadius)),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  AirlineLogo(code: f.airlineCode),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(f.airlineName, style: AppTextStyles.cardTitle),
                        Text(f.flightNo, style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                  StatusChip.tone(AppStrings.confirmed, BadgeTone.success),
                ],
              ),
              const SizedBox(height: 22),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(f.fromCode, style: AppTextStyles.display(34)),
                      Text(f.fromCity, style: AppTextStyles.caption),
                    ],
                  ),
                  const Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: RouteLine())),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(f.toCode, style: AppTextStyles.display(34)),
                      Text(f.toCity, style: AppTextStyles.caption),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Wrap(
                runSpacing: 16,
                children: <Widget>[
                  _Cell(AppStrings.passenger, b.draft.passengerName, wide: true),
                  _Cell(AppStrings.pnr, b.pnr, wide: true),
                  _Cell(AppStrings.gate, b.gate),
                  _Cell(AppStrings.terminal, b.terminal),
                  _Cell(AppStrings.seat, b.draft.seatId.isEmpty ? '—' : b.draft.seatId),
                  _Cell(AppStrings.boarding, b.boardingTime),
                  _Cell(AppStrings.group, b.group),
                  _Cell(AppStrings.cabin, b.cabin),
                ],
              ),
            ],
          ),
        ),
        const _TearLine(),
        // Bottom half with QR
        Container(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppDimens.cardRadius)),
            boxShadow: AppShadows.raised,
          ),
          child: Column(
            children: <Widget>[
              QrImageView(
                data: b.qrData,
                size: 180,
                padding: EdgeInsets.zero,
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 12),
              Text(AppStrings.scanAtGate, style: AppTextStyles.caption),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ActionButton.outlined(
          label: AppStrings.viewAirportGuide,
          icon: Icons.map_outlined,
          onTap: controller.viewGuide,
        ),
      ],
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell(this.label, this.value, {this.wide = false});

  final String label;
  final String value;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: wide ? 0.5 : 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: AppTextStyles.caption),
          const SizedBox(height: 2),
          Text(value, style: AppTextStyles.display(wide ? 16 : 18), maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

/// Dashed divider with half-circle notches at both edges.
class _TearLine extends StatelessWidget {
  const _TearLine();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: Container(color: AppColors.surface)),
          const Positioned(
            left: 22,
            right: 22,
            top: 11,
            child: DashedLine(),
          ),
          Positioned(left: -12, top: 0, child: _notch()),
          Positioned(right: -12, top: 0, child: _notch()),
        ],
      ),
    );
  }

  Widget _notch() => Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(color: AppColors.background, shape: BoxShape.circle),
      );
}
