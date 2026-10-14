import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/routes/app_routes.dart';

class HomeController extends GetxController {
  HomeController(this._flights, this._profiles);

  final FlightRepository _flights;
  final ProfileRepository _profiles;

  final Rx<SearchQuery> query = SearchQuery.initial().obs;
  final RxList<Offer> offers = <Offer>[].obs;
  final RxList<Destination> destinations = <Destination>[].obs;
  final Rxn<UserProfile> profile = Rxn<UserProfile>();
  final RxBool loading = true.obs;

  String get greeting {
    final int hour = DateTime.now().hour;
    if (hour < 12) return AppStrings.goodMorning;
    if (hour < 17) return AppStrings.goodAfternoon;
    return AppStrings.goodEvening;
  }

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    try {
      final List<dynamic> results = await Future.wait<dynamic>(<Future<dynamic>>[
        _flights.getOffers(),
        _flights.getDestinations(),
        _profiles.getProfile(),
      ]);
      offers.assignAll(results[0] as List<Offer>);
      destinations.assignAll(results[1] as List<Destination>);
      profile.value = results[2] as UserProfile;
    } on ApiException catch (e) {
      AppSnackbar.error(AppStrings.errTitle, e.message);
    } catch (_) {
      AppSnackbar.error(AppStrings.errTitle, AppStrings.errGeneric);
    } finally {
      loading.value = false;
    }
  }

  void setTripType(TripType type) => query.value = query.value.copyWith(tripType: type);

  void swap() => query.value = query.value.swapped();

  Future<void> pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: query.value.date,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) query.value = query.value.copyWith(date: picked);
  }

  /// Cycles 1 -> 2 -> 3 -> 4 -> 1 passengers.
  void cycleTravellers() {
    final int next = query.value.adults >= 4 ? 1 : query.value.adults + 1;
    query.value = query.value.copyWith(adults: next);
  }

  void search() => Get.toNamed<void>(AppRoutes.searchFlights, arguments: query.value);

  void openDestination(Destination d) {
    if (d.toCode.isNotEmpty) {
      query.value = query.value.copyWith(toCode: d.toCode, toCity: d.city);
    }
    search();
  }

  void openNotifications() => Get.toNamed<void>(AppRoutes.notifications);
  void openStatus() => Get.toNamed<void>(AppRoutes.flightStatus);
  void openAirportGuide() => Get.toNamed<void>(AppRoutes.airportGuide);
  void openLiveMap() => Get.toNamed<void>(AppRoutes.liveMap);
  void openTrips() => Get.toNamed<void>(AppRoutes.myTrips);
}
