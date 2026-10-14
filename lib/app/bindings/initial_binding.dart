import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';

/// App-wide dependencies. Lives for the whole app session; each screen then
/// adds its own controller through its own binding.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ApiClient>(ApiClient(), permanent: true);

    Get.lazyPut<FlightRepository>(() => FlightRepository(Get.find<ApiClient>()), fenix: true);
    Get.lazyPut<BookingRepository>(() => BookingRepository(Get.find<ApiClient>()), fenix: true);
    Get.lazyPut<StatusRepository>(() => StatusRepository(Get.find<ApiClient>()), fenix: true);
    Get.lazyPut<NotificationRepository>(
      () => NotificationRepository(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<AirportRepository>(() => AirportRepository(Get.find<ApiClient>()), fenix: true);
    Get.lazyPut<ProfileRepository>(() => ProfileRepository(Get.find<ApiClient>()), fenix: true);
  }
}
