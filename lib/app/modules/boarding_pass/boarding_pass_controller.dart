import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/routes/app_routes.dart';

class BoardingPassController extends GetxController {
  late final Booking booking;

  @override
  void onInit() {
    super.onInit();
    final Object? args = Get.arguments;
    booking = args is Booking
        ? args
        : Booking(
            pnr: 'AX7K2P',
            draft: BookingDraft(flight: MockData.flights.first, seatId: '12A', seatLabel: '12A · Window'),
            gate: 'B14',
            terminal: '3',
            boardingTime: '07:35',
            group: '2',
          );
  }

  void addToWallet() => AppSnackbar.success(AppStrings.walletTitle, AppStrings.walletBody);

  void share() => AppSnackbar.info(AppStrings.shareTitle, AppStrings.shareBody);

  void viewGuide() => Get.toNamed<void>(AppRoutes.airportGuide);

  void goHome() => Get.offAllNamed<void>(AppRoutes.home);
}
