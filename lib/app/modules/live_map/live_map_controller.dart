import 'dart:async';

import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';

class LiveMapController extends GetxController {
  LiveMapController(this._repo);

  final StatusRepository _repo;

  final Rxn<LiveFlight> flight = Rxn<LiveFlight>();
  final RxDouble progress = 0.0.obs;
  final RxBool loading = true.obs;

  Timer? _ticker;

  int get minutesLeft {
    final LiveFlight? f = flight.value;
    if (f == null) return 0;
    return ((1 - progress.value) * f.totalMinutes).round();
  }

  String get etaLabel {
    final int m = minutesLeft;
    return m >= 60 ? '${m ~/ 60}h ${m % 60}m' : '${m}m';
  }

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    try {
      final Object? args = Get.arguments;
      final LiveFlight f = await _repo.getLiveFlight(args is String ? args : 'AV 624');
      flight.value = f;
      progress.value = f.progress;
      _startTicker();
    } on ApiException catch (e) {
      AppSnackbar.error(AppStrings.errTitle, e.message);
    } catch (_) {
      AppSnackbar.error(AppStrings.errTitle, AppStrings.errGeneric);
    } finally {
      loading.value = false;
    }
  }

  // Demo movement for the mock. With a real backend, poll or use a socket.
  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (progress.value >= 1) {
        _ticker?.cancel();
        return;
      }
      progress.value = (progress.value + 0.001).clamp(0.0, 1.0);
    });
  }

  @override
  void onClose() {
    _ticker?.cancel();
    super.onClose();
  }
}
