/// Small formatting helpers (no intl dependency).
class Formatters {
  Formatters._();

  static const List<String> _weekdays = <String>[
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
  ];
  static const List<String> _months = <String>[
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  /// 4299 -> ₹4,299 and 1840000 -> ₹18,40,000 (Indian grouping).
  static String rupee(num value) {
    final String digits = value.round().abs().toString();
    final String sign = value < 0 ? '-' : '';
    if (digits.length <= 3) return '$sign₹$digits';
    final String last3 = digits.substring(digits.length - 3);
    String rest = digits.substring(0, digits.length - 3);
    final List<String> groups = <String>[];
    while (rest.length > 2) {
      groups.insert(0, rest.substring(rest.length - 2));
      rest = rest.substring(0, rest.length - 2);
    }
    if (rest.isNotEmpty) groups.insert(0, rest);
    return '$sign₹${groups.join(',')},$last3';
  }

  /// Sat, 17 Oct
  static String dayDate(DateTime d) =>
      '${_weekdays[d.weekday - 1]}, ${d.day} ${_months[d.month - 1]}';

  /// Sat, 17 Oct 2026
  static String dayDateYear(DateTime d) => '${dayDate(d)} ${d.year}';

  /// Thu
  static String weekday(DateTime d) => _weekdays[d.weekday - 1];

  /// 4300 -> ₹4.3k
  static String rupeeShort(num value) {
    if (value >= 1000) {
      return '₹${(value / 1000).toStringAsFixed(1)}k';
    }
    return '₹${value.round()}';
  }
}
