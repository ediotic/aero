enum NotificationType { gate, delay, booking, reminder, offer }

enum NotificationFilter { all, travel, bookings }

class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.timeLabel,
    required this.isToday,
    this.unread = false,
  });

  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final String timeLabel;
  final bool isToday;
  final bool unread;

  AppNotification markRead() => AppNotification(
        id: id,
        type: type,
        title: title,
        body: body,
        timeLabel: timeLabel,
        isToday: isToday,
      );

  /// True when this notification belongs under the given filter chip.
  bool matches(NotificationFilter filter) {
    switch (filter) {
      case NotificationFilter.all:
        return true;
      case NotificationFilter.travel:
        return type == NotificationType.gate ||
            type == NotificationType.delay ||
            type == NotificationType.reminder;
      case NotificationFilter.bookings:
        return type == NotificationType.booking;
    }
  }

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as String,
      type: NotificationType.values.firstWhere(
        (NotificationType t) => t.name == json['type'],
        orElse: () => NotificationType.offer,
      ),
      title: json['title'] as String,
      body: json['body'] as String,
      timeLabel: json['timeLabel'] as String,
      isToday: (json['isToday'] as bool?) ?? true,
      unread: (json['unread'] as bool?) ?? false,
    );
  }
}
