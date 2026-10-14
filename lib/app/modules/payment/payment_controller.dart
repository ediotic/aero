import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/routes/app_routes.dart';

class PaymentController extends GetxController {
  PaymentController(this._repo);

  final BookingRepository _repo;

  static const List<String> banks = <String>['HDFC', 'SBI', 'ICICI', 'Axis', 'Kotak', 'PNB'];
  static final RegExp _upiPattern = RegExp(r'^[\w.\-]{2,}@[a-zA-Z]{2,}$');

  late final BookingDraft draft;

  final Rx<PaymentMethod> method = PaymentMethod.upi.obs;
  final RxString selectedBank = 'HDFC'.obs;
  final RxBool paying = false.obs;

  final TextEditingController upiId = TextEditingController();
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController cardExpiry = TextEditingController();
  final TextEditingController cardCvv = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final Object? args = Get.arguments;
    draft = args is BookingDraft ? args : BookingDraft(flight: MockData.flights.first);
  }

  void selectMethod(PaymentMethod m) => method.value = m;

  void selectBank(String bank) => selectedBank.value = bank;

  /// Returns an error message, or null when the chosen method's input is valid.
  String? validate() {
    switch (method.value) {
      case PaymentMethod.upi:
        return _upiPattern.hasMatch(upiId.text.trim()) ? null : AppStrings.errUpi;
      case PaymentMethod.card:
        final String digits = cardNumber.text.replaceAll(RegExp(r'\s'), '');
        if (digits.length < 12) return AppStrings.errCardNumber;
        if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(cardExpiry.text.trim())) return AppStrings.errCardExpiry;
        if (cardCvv.text.trim().length < 3) return AppStrings.errCardCvv;
        return null;
      case PaymentMethod.netBanking:
        return null;
    }
  }

  Future<void> pay() async {
    if (paying.value) return;
    final String? problem = validate();
    if (problem != null) {
      AppSnackbar.error(AppStrings.checkDetails, problem);
      return;
    }
    paying.value = true;
    try {
      final Booking booking = await _repo.createBooking(draft, method.value);
      Get.offNamed<void>(AppRoutes.boardingPass, arguments: booking);
    } on ApiException catch (e) {
      AppSnackbar.error(AppStrings.paymentFailed, e.message);
    } catch (_) {
      AppSnackbar.error(AppStrings.paymentFailed, AppStrings.errGeneric);
    } finally {
      paying.value = false;
    }
  }

  @override
  void onClose() {
    upiId.dispose();
    cardNumber.dispose();
    cardExpiry.dispose();
    cardCvv.dispose();
    super.onClose();
  }
}
