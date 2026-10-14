import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/routes/app_routes.dart';

class FlightStatusController extends GetxController {
  FlightStatusController(this._repo);

  final StatusRepository _repo;

  final TextEditingController search = TextEditingController();
  final RxList<FlightStatusInfo> statuses = <FlightStatusInfo>[].obs;
  final RxBool loading = true.obs;

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    try {
      statuses.assignAll(await _repo.getStatuses(query: search.text));
    } on ApiException catch (e) {
      AppSnackbar.error(AppStrings.errTitle, e.message);
    } catch (_) {
      AppSnackbar.error(AppStrings.errTitle, AppStrings.errGeneric);
    } finally {
      loading.value = false;
    }
  }

  void trackOnMap(FlightStatusInfo info) =>
      Get.toNamed<void>(AppRoutes.liveMap, arguments: info.flightNo);

  void rebook(FlightStatusInfo info) => Get.toNamed<void>(AppRoutes.searchFlights);

  @override
  void onClose() {
    search.dispose();
    super.onClose();
  }
}
