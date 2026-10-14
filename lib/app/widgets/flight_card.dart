import 'package:flutter/material.dart';

import '../core/core.dart';
import '../data/data.dart';
import 'airline_logo.dart';
import 'app_card.dart';
import 'dashed_line.dart';
import 'status_chip.dart';

/// One search result: airline, times, route line, baggage and fare.
class FlightCard extends StatelessWidget {
  const FlightCard({super.key, required this.flight, required this.onTap});

  final Flight flight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              AirlineLogo(code: flight.airlineCode),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      flight.airlineName,
                      style: AppTextStyles.body(14, weight: FontWeight.w700),
                    ),
                    Text(
                      '${flight.flightNo} · ${flight.aircraft}',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              if (flight.badge != null) StatusChip.tone(flight.badge!, flight.badgeTone),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              _TimeBlock(
                time: flight.departTime,
                place: '${flight.fromCode} · ${flight.fromTerminal}',
                alignment: CrossAxisAlignment.start,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      flight.duration,
                      style: AppTextStyles.body(12, weight: FontWeight.w600, color: AppColors.muted),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 14,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          const DashedLine(),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      flight.isNonStop ? AppStrings.nonStop : '${flight.stops} ${AppStrings.stop}',
                      style: AppTextStyles.body(
                        12,
                        weight: FontWeight.w600,
                        color: flight.isNonStop ? AppColors.success : AppColors.warning,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _TimeBlock(
                time: flight.arriveTime,
                place: '${flight.toCode} · ${flight.toTerminal}',
                alignment: CrossAxisAlignment.end,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const DashedLine(color: AppColors.border, thickness: 1.5, dashWidth: 5, dashGap: 6),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(
                  '${flight.checkInBaggageKg}kg ${AppStrings.checkInBag} · ${flight.perk}',
                  style: AppTextStyles.caption,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(Formatters.rupee(flight.totalFare), style: AppTextStyles.price),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeBlock extends StatelessWidget {
  const _TimeBlock({
    required this.time,
    required this.place,
    required this.alignment,
  });

  final String time;
  final String place;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: <Widget>[
        Text(time, style: AppTextStyles.display(22)),
        Text(place, style: AppTextStyles.caption),
      ],
    );
  }
}
