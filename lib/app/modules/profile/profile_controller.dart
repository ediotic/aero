import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/routes/app_routes.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

class ProfileController extends GetxController {
  ProfileController(this._repo);

  final ProfileRepository _repo;

  final Rxn<UserProfile> profile = Rxn<UserProfile>();
  final RxBool loading = true.obs;

  final RxBool pushAlerts = true.obs;
  final RxBool emailUpdates = false.obs;
  final RxBool biometric = true.obs;
  // UI state only. Wire this to a ThemeController when dark theme is built.
  final RxBool darkMode = false.obs;

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    loading.value = true;
    try {
      profile.value = await _repo.getProfile();
    } on ApiException catch (e) {
      AppSnackbar.error(AppStrings.errTitle, e.message);
    } catch (_) {
      AppSnackbar.error(AppStrings.errTitle, AppStrings.errGeneric);
    } finally {
      loading.value = false;
    }
  }

  void openNotifications() => Get.toNamed<void>(AppRoutes.notifications);

  void comingSoon() => AppSnackbar.info(AppStrings.comingSoon, AppStrings.comingSoonBody);

  Future<void> logout() async {
    final bool ok = await AppDialogs.confirm(
      title: AppStrings.logoutTitle,
      message: AppStrings.logoutBody,
      confirmLabel: AppStrings.logout,
      danger: true,
    );
    if (ok) Get.offAllNamed<void>(AppRoutes.splash);
  }
}
