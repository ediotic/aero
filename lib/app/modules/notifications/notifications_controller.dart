import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';

class NotificationsController extends GetxController {
  NotificationsController(this._repo);

  final NotificationRepository _repo;

  final RxList<AppNotification> items = <AppNotification>[].obs;
  final Rx<NotificationFilter> filter = NotificationFilter.all.obs;
  final RxBool loading = true.obs;

  List<AppNotification> get filtered =>
      items.where((AppNotification n) => n.matches(filter.value)).toList();

  List<AppNotification> get today => filtered.where((AppNotification n) => n.isToday).toList();
  List<AppNotification> get earlier => filtered.where((AppNotification n) => !n.isToday).toList();
  int get unreadCount => items.where((AppNotification n) => n.unread).length;

  String filterLabel(NotificationFilter f) {
    switch (f) {
      case NotificationFilter.all:
        return AppStrings.filterAll;
      case NotificationFilter.travel:
        return AppStrings.filterTravel;
      case NotificationFilter.bookings:
        return AppStrings.filterBookings;
    }
  }

  IconData iconFor(NotificationType t) {
    switch (t) {
      case NotificationType.gate:
        return Icons.meeting_room_outlined;
      case NotificationType.delay:
        return Icons.schedule_rounded;
      case NotificationType.booking:
        return Icons.confirmation_number_outlined;
      case NotificationType.reminder:
        return Icons.notifications_active_outlined;
      case NotificationType.offer:
        return Icons.local_offer_outlined;
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
      items.assignAll(await _repo.getNotifications());
    } on ApiException catch (e) {
      AppSnackbar.error(AppStrings.errTitle, e.message);
    } catch (_) {
      AppSnackbar.error(AppStrings.errTitle, AppStrings.errGeneric);
    } finally {
      loading.value = false;
    }
  }

  void setFilter(NotificationFilter f) => filter.value = f;

  Future<void> markAllRead() async {
    if (unreadCount == 0) return;
    try {
      await _repo.markAllRead();
      items.assignAll(items.map((AppNotification n) => n.markRead()).toList());
    } on ApiException catch (e) {
      AppSnackbar.error(AppStrings.errTitle, e.message);
    } catch (_) {
      AppSnackbar.error(AppStrings.errTitle, AppStrings.errGeneric);
    }
  }
}
