import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';

class AirportGuideController extends GetxController {
  AirportGuideController(this._repo);

  final AirportRepository _repo;

  final Rxn<AirportGuide> guide = Rxn<AirportGuide>();
  final RxBool loading = true.obs;
  final RxInt terminal = 0.obs;

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    try {
      final Object? args = Get.arguments;
      final String code = args is String ? args : 'DEL';
      guide.value = await _repo.getGuide(code);
    } on ApiException catch (e) {
      AppSnackbar.error(AppStrings.errTitle, e.message);
    } catch (_) {
      AppSnackbar.error(AppStrings.errTitle, AppStrings.errGeneric);
    } finally {
      loading.value = false;
    }
  }

  void selectTerminal(int i) => terminal.value = i;

  IconData iconFor(AirportServiceType t) {
    switch (t) {
      case AirportServiceType.lounge:
        return Icons.weekend_outlined;
      case AirportServiceType.quietLounge:
        return Icons.self_improvement_rounded;
      case AirportServiceType.metro:
        return Icons.train_outlined;
      case AirportServiceType.taxi:
        return Icons.local_taxi_outlined;
      case AirportServiceType.shuttle:
        return Icons.directions_bus_outlined;
      case AirportServiceType.cafe:
        return Icons.local_cafe_outlined;
      case AirportServiceType.restaurant:
        return Icons.restaurant_outlined;
    }
  }

  void onServiceTap(AirportService s) => AppSnackbar.info(s.title, s.subtitle);
}
