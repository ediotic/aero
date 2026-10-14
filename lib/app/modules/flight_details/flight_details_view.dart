import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

import 'flight_details_controller.dart';

class FlightDetailsView extends GetView<FlightDetailsController> {
  const FlightDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final Flight f = controller.flight;
    return GradientPageScaffold(
      headerHeight: 76,
      overlap: 110,
      header: ScreenHeaderBar(title: AppStrings.flightDetails, subtitle: '${f.airlineName} · ${f.flightNo}'),
      bottomBar: BottomActionBar(
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(AppStrings.total, style: AppTextStyles.caption),
                Text(Formatters.rupee(f.totalFare), style: AppTextStyles.price),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: GradientButton(label: AppStrings.selectSeat, onTap: controller.selectSeat),
            ),
          ],
        ),
      ),
      children: <Widget>[
        AppCard(
          shadows: AppShadows.raised,
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
                        Text('${f.flightNo} · ${f.aircraft}', style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                  if (f.badge != null) StatusChip.tone(f.badge!, f.badgeTone),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  _Endpoint(time: f.departTime, code: f.fromCode, city: f.fromCity, terminal: f.fromTerminal, end: false),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(f.duration, style: AppTextStyles.caption),
                        const SizedBox(height: 6),
                        const RouteLine(),
                        const SizedBox(height: 6),
                        Text(
                          f.isNonStop ? AppStrings.nonStop : '${f.stops} ${AppStrings.stop}',
                          style: AppTextStyles.body(12, weight: FontWeight.w700, color: AppColors.success),
                        ),
                      ],
                    ),
                  ),
                  _Endpoint(time: f.arriveTime, code: f.toCode, city: f.toCity, terminal: f.toTerminal, end: true),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const GroupLabel(AppStrings.baggage),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(child: _BagTile(icon: Icons.work_outline_rounded, label: AppStrings.cabinBag, value: '${f.cabinBaggageKg} kg')),
            const SizedBox(width: 12),
            Expanded(child: _BagTile(icon: Icons.luggage_rounded, label: AppStrings.checkInBag, value: '${f.checkInBaggageKg} kg')),
          ],
        ),
        const SizedBox(height: 18),
        const GroupLabel(AppStrings.amenities),
        const SizedBox(height: 10),
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              for (final Amenity a in controller.amenities)
                Column(
                  children: <Widget>[
                    IconTile(icon: a.icon),
                    const SizedBox(height: 8),
                    Text(a.label, style: AppTextStyles.body(12, weight: FontWeight.w600)),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const GroupLabel(AppStrings.fareBreakdown),
        const SizedBox(height: 10),
        AppCard(
          child: Column(
            children: <Widget>[
              FareRow(label: AppStrings.baseFare, value: Formatters.rupee(f.baseFare)),
              FareRow(label: AppStrings.taxes, value: Formatters.rupee(f.taxes)),
              FareRow(label: AppStrings.fuelSurcharge, value: Formatters.rupee(f.fuelSurcharge)),
              FareRow(label: AppStrings.convenienceFee, value: Formatters.rupee(f.convenienceFee)),
              const Divider(height: 24, color: AppColors.divider),
              FareRow(label: AppStrings.total, value: Formatters.rupee(f.totalFare), isTotal: true),
            ],
          ),
        ),
        if (f.refundAmount > 0) ...<Widget>[
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.successSoft,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.verified_outlined, color: AppColors.success),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${AppStrings.refundableUpTo} ${Formatters.rupee(f.refundAmount)}',
                    style: AppTextStyles.body(13, weight: FontWeight.w600, color: AppColors.success),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _Endpoint extends StatelessWidget {
  const _Endpoint({
    required this.time,
    required this.code,
    required this.city,
    required this.terminal,
    required this.end,
  });

  final String time;
  final String code;
  final String city;
  final String terminal;
  final bool end;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: end ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Text(time, style: AppTextStyles.display(22)),
        Text(code, style: AppTextStyles.body(14, weight: FontWeight.w700, color: AppColors.primary)),
        Text(city, style: AppTextStyles.caption),
        Text('${AppStrings.terminal} $terminal', style: AppTextStyles.caption),
      ],
    );
  }
}

class _BagTile extends StatelessWidget {
  const _BagTile({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: <Widget>[
          IconTile(icon: icon),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: AppTextStyles.caption),
              Text(value, style: AppTextStyles.display(17)),
            ],
          ),
        ],
      ),
    );
  }
}
