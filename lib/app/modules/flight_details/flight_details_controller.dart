import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/routes/app_routes.dart';

class Amenity {
  const Amenity(this.icon, this.label);
  final IconData icon;
  final String label;
}

class FlightDetailsController extends GetxController {
  late final Flight flight;

  final List<Amenity> amenities = const <Amenity>[
    Amenity(Icons.wifi_rounded, AppStrings.amenityWifi),
    Amenity(Icons.restaurant_rounded, AppStrings.amenityMeal),
    Amenity(Icons.power_outlined, AppStrings.amenityPower),
    Amenity(Icons.movie_outlined, AppStrings.amenityEntertainment),
  ];

  @override
  void onInit() {
    super.onInit();
    final Object? args = Get.arguments;
    flight = args is Flight ? args : MockData.flights.first;
  }

  void selectSeat() => Get.toNamed<void>(
        AppRoutes.seatSelection,
        arguments: BookingDraft(flight: flight),
      );
}
