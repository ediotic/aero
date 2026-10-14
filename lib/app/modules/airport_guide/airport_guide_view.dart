import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

import 'airport_guide_controller.dart';
import 'gate_route_painter.dart';

class AirportGuideView extends GetView<AirportGuideController> {
  const AirportGuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientPageScaffold(
      headerHeight: 150,
      overlap: 30,
      onRefresh: controller.load,
      header: Obx(() {
        final AirportGuide? g = controller.guide.value;
        final int sel = controller.terminal.value;
        return Column(
          children: <Widget>[
            ScreenHeaderBar(title: AppStrings.airportGuide, subtitle: g == null ? null : '${g.name} · ${g.code}'),
            const SizedBox(height: 14),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.screenPadding),
                itemCount: g?.terminals.length ?? 0,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, int i) => PillChip(
                  label: '${AppStrings.terminal} ${g!.terminals[i]}',
                  selected: sel == i,
                  style: PillStyle.onDark,
                  onTap: () => controller.selectTerminal(i),
                ),
              ),
            ),
          ],
        );
      }),
      children: <Widget>[
        Obx(() {
          final AirportGuide? g = controller.guide.value;
          if (controller.loading.value || g == null) return const LoadingView();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 18),
              AppCard(
                padding: const EdgeInsets.all(14),
                shadows: AppShadows.raised,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 170,
                      width: double.infinity,
                      child: CustomPaint(painter: GateRoutePainter(gate: g.gate)),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: <Widget>[
                        Expanded(child: _Fact(AppStrings.gate, g.gate)),
                        Expanded(child: _Fact(AppStrings.walk, '${g.walkMinutes} ${AppStrings.min}')),
                        Expanded(child: _Fact(AppStrings.security, '${g.securityWaitMinutes} ${AppStrings.min}')),
                        Expanded(child: _Fact(AppStrings.boarding, g.boardingTime)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const SectionHeader(title: AppStrings.lounges),
              const SizedBox(height: 12),
              for (final AirportService s in g.lounges) _LoungeCard(service: s, controller: controller),
              const SizedBox(height: 10),
              const SectionHeader(title: AppStrings.transport),
              const SizedBox(height: 12),
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: <Widget>[
                    for (int i = 0; i < g.transport.length; i++)
                      SettingsTile(
                        icon: controller.iconFor(g.transport[i].type),
                        title: g.transport[i].title,
                        value: g.transport[i].trailing.isEmpty ? g.transport[i].subtitle : g.transport[i].trailing,
                        showDivider: i != g.transport.length - 1,
                        onTap: () => controller.onServiceTap(g.transport[i]),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const SectionHeader(title: AppStrings.foodAndDrink),
              const SizedBox(height: 12),
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: <Widget>[
                    for (int i = 0; i < g.food.length; i++)
                      SettingsTile(
                        icon: controller.iconFor(g.food[i].type),
                        title: g.food[i].title,
                        value: g.food[i].subtitle,
                        showDivider: i != g.food.length - 1,
                        onTap: () => controller.onServiceTap(g.food[i]),
                      ),
                  ],
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}

class _LoungeCard extends StatelessWidget {
  const _LoungeCard({required this.service, required this.controller});

  final AirportService service;
  final AirportGuideController controller;

  @override
  Widget build(BuildContext context) {
    final bool quiet = service.type == AirportServiceType.quietLounge;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => controller.onServiceTap(service),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: quiet ? AppGradients.loungeQuiet : AppGradients.lounge,
            borderRadius: BorderRadius.circular(AppDimens.cardRadius),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(color: AppColors.white(0.16), shape: BoxShape.circle),
                child: Icon(controller.iconFor(service.type), color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(service.title, style: AppTextStyles.display(16, color: Colors.white)),
                    const SizedBox(height: 2),
                    Text(service.subtitle, style: AppTextStyles.body(12, color: AppColors.white(0.8))),
                    if (service.highlight.isNotEmpty) ...<Widget>[
                      const SizedBox(height: 6),
                      Text(
                        service.highlight,
                        style: AppTextStyles.body(12, weight: FontWeight.w700, color: AppColors.amber),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
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
      children: <Widget>[
        Text(value, style: AppTextStyles.display(15)),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}
