import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

import 'live_map_controller.dart';
import 'route_geometry.dart';
import 'route_painter.dart';

class LiveMapView extends GetView<LiveMapController> {
  const LiveMapView({super.key});

  static const double _sheetHeight = 330;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.navy900,
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: DecoratedBox(
                decoration: const BoxDecoration(gradient: AppGradients.night),
                child: SvgPicture.asset(AppAssets.mapLand, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: _sheetHeight,
              child: Obx(() {
                final LiveFlight? f = controller.flight.value;
                if (f == null) return const SizedBox.shrink();
                final double p = controller.progress.value;
                return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints c) {
                    final Size size = Size(c.maxWidth, c.maxHeight);
                    final RouteGeometry geo = RouteGeometry(size);
                    final Offset pos = geo.pointAt(p);
                    const double iconSize = 44;
                    return Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: CustomPaint(
                            painter: RoutePainter(progress: p, fromCode: f.fromCode, toCode: f.toCode),
                          ),
                        ),
                        Positioned(
                          left: pos.dx - iconSize / 2,
                          top: pos.dy - iconSize / 2,
                          child: Container(
                            width: iconSize,
                            height: iconSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                              boxShadow: AppShadows.glow(AppColors.primaryGlow),
                            ),
                            child: Center(
                              child: PlaneIcon(size: 22, angle: geo.angleAt(p)),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.screenPadding),
                child: Row(
                  children: <Widget>[
                    CircleIconButton(icon: Icons.arrow_back_ios_new_rounded, onTap: () => Get.back<void>()),
                    const SizedBox(width: 12),
                    Text(AppStrings.liveMap, style: AppTextStyles.screenTitle),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: _sheetHeight,
              child: _InfoSheet(controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoSheet extends StatelessWidget {
  const _InfoSheet({required this.controller});

  final LiveMapController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppDimens.screenPadding,
        14,
        AppDimens.screenPadding,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimens.sheetRadius)),
      ),
      child: Obx(() {
        final LiveFlight? f = controller.flight.value;
        if (f == null) return const LoadingView(height: 200);
        final double p = controller.progress.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(color: AppColors.dash, borderRadius: BorderRadius.circular(3)),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                AirlineLogo(code: f.airlineCode),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${f.airlineName} · ${f.flightNo}', style: AppTextStyles.cardTitle),
                      Text('${f.fromCity} → ${f.toCity}', style: AppTextStyles.caption),
                    ],
                  ),
                ),
                StatusChip.tone(AppStrings.inAir, BadgeTone.success),
              ],
            ),
            const SizedBox(height: 18),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: p,
                minHeight: 6,
                backgroundColor: AppColors.primarySoft,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${AppStrings.departed} ${f.departedTime}', style: AppTextStyles.caption),
                Text('${AppStrings.arrives} ${f.arrivalTime}', style: AppTextStyles.caption),
              ],
            ),
            const Spacer(),
            Row(
              children: <Widget>[
                Expanded(child: _Metric(AppStrings.eta, controller.etaLabel)),
                Expanded(child: _Metric(AppStrings.altitude, '${(f.altitudeFt / 1000).toStringAsFixed(0)}k ft')),
                Expanded(child: _Metric(AppStrings.speed, '${f.speedKmh} km/h')),
                Expanded(child: _Metric(AppStrings.gate, f.arrivalGate)),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(value, style: AppTextStyles.display(16)),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}
