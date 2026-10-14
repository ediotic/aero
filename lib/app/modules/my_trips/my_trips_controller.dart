import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/routes/app_routes.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

class MyTripsController extends GetxController {
  MyTripsController(this._repo);

  final BookingRepository _repo;

  static const List<TripStatus> tabs = <TripStatus>[
    TripStatus.confirmed,
    TripStatus.completed,
    TripStatus.cancelled,
  ];

  final RxList<Trip> trips = <Trip>[].obs;
  final RxBool loading = true.obs;
  final RxInt tab = 0.obs;
  final RxnString expandedPnr = RxnString();

  List<Trip> get visibleTrips => trips.where((Trip t) => t.status == tabs[tab.value]).toList();

  int countFor(TripStatus s) => trips.where((Trip t) => t.status == s).length;

  String tabLabel(TripStatus s) {
    switch (s) {
      case TripStatus.confirmed:
        return AppStrings.upcoming;
      case TripStatus.completed:
        return AppStrings.completed;
      case TripStatus.cancelled:
        return AppStrings.cancelled;
    }
  }

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    try {
      trips.assignAll(await _repo.getTrips());
    } on ApiException catch (e) {
      AppSnackbar.error(AppStrings.errTitle, e.message);
    } catch (_) {
      AppSnackbar.error(AppStrings.errTitle, AppStrings.errGeneric);
    } finally {
      loading.value = false;
    }
  }

  void selectTab(int index) {
    tab.value = index;
    expandedPnr.value = null;
  }

  void toggleExpand(Trip trip) {
    expandedPnr.value = expandedPnr.value == trip.pnr ? null : trip.pnr;
  }

  void viewBoardingPass(Trip trip) => Get.toNamed<void>(AppRoutes.boardingPass);

  void changeFlight(Trip trip) => Get.toNamed<void>(AppRoutes.searchFlights);

  Future<void> addBaggage(Trip trip) async {
    final int? choice = await AppDialogs.options(
      title: AppStrings.addBaggage,
      choices: const <String>[
        AppStrings.baggage5,
        AppStrings.baggage10,
        AppStrings.baggage15,
      ],
    );
    if (choice != null) {
      AppSnackbar.success(AppStrings.baggageAdded, '${trip.flightNo} · ${trip.pnr}');
    }
  }

  Future<void> cancel(Trip trip) async {
    final bool ok = await AppDialogs.confirm(
      title: AppStrings.cancelTripTitle,
      message: '${trip.fromCode} → ${trip.toCode} · ${trip.flightNo}\n${AppStrings.cancelTripBody}',
      confirmLabel: AppStrings.cancelTrip,
      cancelLabel: AppStrings.keepTrip,
      danger: true,
    );
    if (!ok) return;
    try {
      await _repo.cancelTrip(trip.pnr);
      final int i = trips.indexWhere((Trip t) => t.pnr == trip.pnr);
      if (i >= 0) trips[i] = trips[i].copyWith(status: TripStatus.cancelled);
      expandedPnr.value = null;
      AppSnackbar.success(AppStrings.tripCancelled, trip.pnr);
    } on ApiException catch (e) {
      AppSnackbar.error(AppStrings.errTitle, e.message);
    } catch (_) {
      AppSnackbar.error(AppStrings.errTitle, AppStrings.errGeneric);
    }
  }
}
