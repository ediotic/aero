import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientPageScaffold(
      nav: NavTab.home,
      headerHeight: 120,
      overlap: 150,
      padding: EdgeInsets.zero,
      onRefresh: controller.load,
      header: _Header(controller: controller),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
          child: _SearchCard(controller: controller),
        ),
        const SizedBox(height: 24),
        _QuickActions(controller: controller),
        const SizedBox(height: 28),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
          child: SectionHeader(title: AppStrings.specialOffers),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 150,
          child: Obx(() {
            if (controller.loading.value && controller.offers.isEmpty) return const LoadingView(height: 150);
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
              itemCount: controller.offers.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (_, int i) => OfferCard(offer: controller.offers[i]),
            );
          }),
        ),
        const SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
          child: SectionHeader(
            title: AppStrings.popularDestinations,
            actionLabel: AppStrings.viewAll,
            onAction: controller.search,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 240,
          child: Obx(() {
            if (controller.loading.value && controller.destinations.isEmpty) return const LoadingView(height: 240);
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
              itemCount: controller.destinations.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (_, int i) {
                final Destination d = controller.destinations[i];
                return DestinationCard(destination: d, onTap: () => controller.openDestination(d));
              },
            );
          }),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppDimens.screenPadding, 12, AppDimens.screenPadding, 0),
      child: Row(
        children: <Widget>[
          Obx(() {
            final UserProfile? p = controller.profile.value;
            return Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white(0.18),
                border: Border.all(color: AppColors.white(0.4), width: 2),
              ),
              child: Text(
                p?.initials ?? '',
                style: AppTextStyles.display(16, color: Colors.white),
              ),
            );
          }),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  controller.greeting,
                  style: AppTextStyles.body(13, color: AppColors.white(0.8)),
                ),
                Obx(
                  () => Text(
                    controller.profile.value?.firstName ?? '',
                    style: AppTextStyles.display(20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          CircleIconButton(
            icon: Icons.notifications_none_rounded,
            badge: true,
            onTap: controller.openNotifications,
          ),
        ],
      ),
    );
  }
}

class _SearchCard extends StatelessWidget {
  const _SearchCard({required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(18),
      shadows: AppShadows.raised,
      child: Obx(() {
        final SearchQuery q = controller.query.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(AppStrings.whereToNext, style: AppTextStyles.display(20)),
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                PillChip(
                  label: AppStrings.oneWay,
                  selected: q.tripType == TripType.oneWay,
                  height: 34,
                  horizontalPadding: 14,
                  onTap: () => controller.setTripType(TripType.oneWay),
                ),
                const SizedBox(width: 8),
                PillChip(
                  label: AppStrings.roundTrip,
                  selected: q.tripType == TripType.roundTrip,
                  height: 34,
                  horizontalPadding: 14,
                  onTap: () => controller.setTripType(TripType.roundTrip),
                ),
                const SizedBox(width: 8),
                PillChip(
                  label: AppStrings.multiCity,
                  selected: q.tripType == TripType.multiCity,
                  height: 34,
                  horizontalPadding: 14,
                  onTap: () => controller.setTripType(TripType.multiCity),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _CityField(label: AppStrings.from, code: q.fromCode, city: q.fromCity),
                    const SizedBox(height: 10),
                    _CityField(label: AppStrings.to, code: q.toCode, city: q.toCity),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: controller.swap,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border, width: 1.5),
                      ),
                      child: const Icon(Icons.swap_vert_rounded, color: AppColors.primary, size: 22),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: _InfoField(
                    label: AppStrings.departure,
                    value: Formatters.dayDate(q.date),
                    onTap: () => controller.pickDate(context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: _InfoField(
                    label: AppStrings.travellers,
                    value: '${q.adults} ${q.cabin}',
                    onTap: controller.cycleTravellers,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GradientButton(
              label: AppStrings.searchFlights,
              leadingIcon: Icons.search_rounded,
              onTap: controller.search,
            ),
          ],
        );
      }),
    );
  }
}

class _CityField extends StatelessWidget {
  const _CityField({required this.label, required this.code, required this.city});
  final String label;
  final String code;
  final String city;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimens.chipRadius + 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: AppTextStyles.caption),
          const SizedBox(height: 2),
          Text.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(text: city, style: AppTextStyles.display(17)),
                TextSpan(text: '  $code', style: AppTextStyles.body(14, color: AppColors.muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  const _InfoField({required this.label, required this.value, required this.onTap});
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppDimens.chipRadius + 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label, style: AppTextStyles.caption),
            const SizedBox(height: 2),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body(14, weight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          QuickActionItem(icon: Icons.schedule_rounded, label: AppStrings.flightStatus, onTap: controller.openStatus),
          QuickActionItem(icon: Icons.luggage_rounded, label: AppStrings.myTrips, onTap: controller.openTrips),
          QuickActionItem(icon: Icons.local_airport_rounded, label: AppStrings.airportGuide, onTap: controller.openAirportGuide),
          QuickActionItem(icon: Icons.public_rounded, label: AppStrings.liveMap, onTap: controller.openLiveMap),
        ],
      ),
    );
  }
}
