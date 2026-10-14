import 'package:flutter/material.dart';

import '../core/core.dart';
import '../data/data.dart';
import 'plane_icon.dart';

/// Promo card shown in the horizontal "Special offers" list.
class OfferCard extends StatelessWidget {
  const OfferCard({super.key, required this.offer, this.onTap});

  final Offer offer;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool purple = offer.style == OfferStyle.purple;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 290,
        height: 150,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          gradient: purple ? AppGradients.offerPurple : AppGradients.offerNavy,
          borderRadius: BorderRadius.circular(AppDimens.cardRadius),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: -30,
              top: -40,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: purple ? AppColors.white(0.12) : AppColors.alpha(AppColors.primaryLight, 0.35),
                ),
              ),
            ),
            Positioned(
              right: -10,
              bottom: -30,
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white(0.09)),
              ),
            ),
            if (purple)
              const Positioned(
                right: 36,
                top: 38,
                child: PlaneIcon(size: 58, angle: PlaneIcon.diagonal),
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: purple ? AppColors.amber : AppColors.white(0.16),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      offer.badge,
                      style: AppTextStyles.body(
                        11,
                        weight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: purple ? AppColors.ink : Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 180,
                    child: Text(
                      offer.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.display(20, color: Colors.white, height: 1.2),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    offer.subtitle,
                    style: AppTextStyles.body(12, color: AppColors.white(0.9)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
