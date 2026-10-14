import 'package:get/get.dart';

import 'package:aerova_app/app/modules/airport_guide/airport_guide_binding.dart';
import 'package:aerova_app/app/modules/airport_guide/airport_guide_view.dart';
import 'package:aerova_app/app/modules/boarding_pass/boarding_pass_binding.dart';
import 'package:aerova_app/app/modules/boarding_pass/boarding_pass_view.dart';
import 'package:aerova_app/app/modules/flight_details/flight_details_binding.dart';
import 'package:aerova_app/app/modules/flight_details/flight_details_view.dart';
import 'package:aerova_app/app/modules/flight_status/flight_status_binding.dart';
import 'package:aerova_app/app/modules/flight_status/flight_status_view.dart';
import 'package:aerova_app/app/modules/home/home_binding.dart';
import 'package:aerova_app/app/modules/home/home_view.dart';
import 'package:aerova_app/app/modules/live_map/live_map_binding.dart';
import 'package:aerova_app/app/modules/live_map/live_map_view.dart';
import 'package:aerova_app/app/modules/my_trips/my_trips_binding.dart';
import 'package:aerova_app/app/modules/my_trips/my_trips_view.dart';
import 'package:aerova_app/app/modules/notifications/notifications_binding.dart';
import 'package:aerova_app/app/modules/notifications/notifications_view.dart';
import 'package:aerova_app/app/modules/onboarding/onboarding_binding.dart';
import 'package:aerova_app/app/modules/onboarding/onboarding_view.dart';
import 'package:aerova_app/app/modules/payment/payment_binding.dart';
import 'package:aerova_app/app/modules/payment/payment_view.dart';
import 'package:aerova_app/app/modules/profile/profile_binding.dart';
import 'package:aerova_app/app/modules/profile/profile_view.dart';
import 'package:aerova_app/app/modules/search_flights/search_flights_binding.dart';
import 'package:aerova_app/app/modules/search_flights/search_flights_view.dart';
import 'package:aerova_app/app/modules/seat_selection/seat_selection_binding.dart';
import 'package:aerova_app/app/modules/seat_selection/seat_selection_view.dart';
import 'package:aerova_app/app/modules/splash/splash_binding.dart';
import 'package:aerova_app/app/modules/splash/splash_view.dart';

import 'app_routes.dart';

/// Every screen, its binding and its transition in one list.
class AppPages {
  AppPages._();

  static const Duration _duration = Duration(milliseconds: 300);

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<void>(
      name: AppRoutes.splash,
      page: SplashView.new,
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<void>(
      name: AppRoutes.onboarding,
      page: OnboardingView.new,
      binding: OnboardingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<void>(
      name: AppRoutes.home,
      page: HomeView.new,
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<void>(
      name: AppRoutes.searchFlights,
      page: SearchFlightsView.new,
      binding: SearchFlightsBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _duration,
    ),
    GetPage<void>(
      name: AppRoutes.flightDetails,
      page: FlightDetailsView.new,
      binding: FlightDetailsBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _duration,
    ),
    GetPage<void>(
      name: AppRoutes.seatSelection,
      page: SeatSelectionView.new,
      binding: SeatSelectionBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _duration,
    ),
    GetPage<void>(
      name: AppRoutes.payment,
      page: PaymentView.new,
      binding: PaymentBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _duration,
    ),
    GetPage<void>(
      name: AppRoutes.boardingPass,
      page: BoardingPassView.new,
      binding: BoardingPassBinding(),
      transition: Transition.downToUp,
      transitionDuration: _duration,
    ),
    GetPage<void>(
      name: AppRoutes.myTrips,
      page: MyTripsView.new,
      binding: MyTripsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<void>(
      name: AppRoutes.flightStatus,
      page: FlightStatusView.new,
      binding: FlightStatusBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<void>(
      name: AppRoutes.airportGuide,
      page: AirportGuideView.new,
      binding: AirportGuideBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _duration,
    ),
    GetPage<void>(
      name: AppRoutes.liveMap,
      page: LiveMapView.new,
      binding: LiveMapBinding(),
      transition: Transition.downToUp,
      transitionDuration: _duration,
    ),
    GetPage<void>(
      name: AppRoutes.notifications,
      page: NotificationsView.new,
      binding: NotificationsBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _duration,
    ),
    GetPage<void>(
      name: AppRoutes.profile,
      page: ProfileView.new,
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
