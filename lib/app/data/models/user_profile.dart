class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.tier,
    required this.points,
    required this.trips,
    required this.miles,
    required this.countries,
    required this.savedPassengers,
  });

  final String name;
  final String email;
  final String tier;
  final int points;
  final int trips;
  final String miles;
  final int countries;
  final int savedPassengers;

  String get initials {
    final List<String> parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  String get firstName => name.trim().split(RegExp(r'\s+')).first;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] as String,
      email: json['email'] as String,
      tier: (json['tier'] as String?) ?? 'Aerova Prime',
      points: (json['points'] as num?)?.toInt() ?? 0,
      trips: (json['trips'] as num?)?.toInt() ?? 0,
      miles: (json['miles'] as String?) ?? '0',
      countries: (json['countries'] as num?)?.toInt() ?? 0,
      savedPassengers: (json['savedPassengers'] as num?)?.toInt() ?? 0,
    );
  }
}
