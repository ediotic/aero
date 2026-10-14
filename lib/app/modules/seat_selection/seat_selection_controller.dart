import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/routes/app_routes.dart';

class SeatSelectionController extends GetxController {
  SeatSelectionController(this._repo);

  final FlightRepository _repo;

  static const int firstRow = 10;
  static const int lastRow = 21;
  static const int premiumRows = 2;
  static const List<String> letters = <String>['A', 'B', 'C', 'D', 'E', 'F'];

  late final BookingDraft draft;
  final RxList<String> taken = <String>[].obs;
  final Rxn<Seat> selected = Rxn<Seat>();
  final RxBool loading = true.obs;

  Flight get flight => draft.flight;

  @override
  void onInit() {
    super.onInit();
    final Object? args = Get.arguments;
    draft = args is BookingDraft ? args : BookingDraft(flight: MockData.flights.first);
  }

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    try {
      taken.assignAll(await _repo.getTakenSeats(flight.id));
    } on ApiException catch (e) {
      AppSnackbar.error(AppStrings.errTitle, e.message);
    } catch (_) {
      AppSnackbar.error(AppStrings.errTitle, AppStrings.errGeneric);
    } finally {
      loading.value = false;
    }
  }

  List<int> get rows => List<int>.generate(lastRow - firstRow + 1, (int i) => firstRow + i);

  Seat seatAt(int row, String letter) {
    final String id = '$row$letter';
    final SeatState state = taken.contains(id)
        ? SeatState.taken
        : (row < firstRow + premiumRows ? SeatState.premium : SeatState.free);
    return Seat(row: row, letter: letter, state: state);
  }

  void select(Seat seat) {
    selected.value = selected.value?.id == seat.id ? null : seat;
  }

  int get total => draft.flight.totalFare + (selected.value?.fee ?? 0);

  void confirm() {
    final Seat? seat = selected.value;
    if (seat == null) {
      AppSnackbar.info(AppStrings.pickSeatTitle, AppStrings.pickSeatBody);
      return;
    }
    Get.toNamed<void>(
      AppRoutes.payment,
      arguments: draft.copyWith(
        seatId: seat.id,
        seatLabel: '${seat.id} · ${seat.position}',
        seatFee: seat.fee,
      ),
    );
  }
}
