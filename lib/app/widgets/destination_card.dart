import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/core.dart';
import '../data/data.dart';
import 'app_card.dart';

/// Vertical card with an illustration, city, price and flight time.
class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key, required this.destination, required this.onTap});

  final Destination destination;
  final VoidCallback onTap;

  String get _asset {
    switch (destination.art) {
      case DestinationArt.goa:
        return AppAssets.destGoa;
      case DestinationArt.jaipur:
        return AppAssets.destJaipur;
      case DestinationArt.dubai:
        return AppAssets.destDubai;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: AppCard(
        onTap: onTap,
        radius: 24,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: SvgPicture.asset(
                _asset,
                width: double.infinity,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 10, 6, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(destination.city, style: AppTextStyles.display(17)),
                  const SizedBox(height: 4),
                  Text(
                    '${AppStrings.from} ${Formatters.rupee(destination.priceFrom)}',
                    style: AppTextStyles.body(13, weight: FontWeight.w700, color: AppColors.primary),
                  ),
                  const SizedBox(height: 2),
                  Text(destination.info, style: AppTextStyles.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
