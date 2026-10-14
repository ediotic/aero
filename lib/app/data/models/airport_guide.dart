enum AirportServiceType { lounge, quietLounge, metro, taxi, shuttle, cafe, restaurant }

class AirportService {
  const AirportService({
    required this.type,
    required this.title,
    required this.subtitle,
    this.highlight = '',
    this.trailing = '',
  });

  final AirportServiceType type;
  final String title;
  final String subtitle;

  /// Extra line, e.g. the lounge access price.
  final String highlight;

  /// Right-aligned value, e.g. a fare.
  final String trailing;

  factory AirportService.fromJson(Map<String, dynamic> json) {
    return AirportService(
      type: AirportServiceType.values.firstWhere(
        (AirportServiceType t) => t.name == json['type'],
        orElse: () => AirportServiceType.cafe,
      ),
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      highlight: (json['highlight'] as String?) ?? '',
      trailing: (json['trailing'] as String?) ?? '',
    );
  }
}

class AirportGuide {
  const AirportGuide({
    required this.code,
    required this.name,
    required this.terminals,
    required this.gate,
    required this.walkMinutes,
    required this.securityWaitMinutes,
    required this.boardingTime,
    required this.lounges,
    required this.transport,
    required this.food,
  });

  final String code;
  final String name;
  final List<String> terminals;
  final String gate;
  final int walkMinutes;
  final int securityWaitMinutes;
  final String boardingTime;
  final List<AirportService> lounges;
  final List<AirportService> transport;
  final List<AirportService> food;

  factory AirportGuide.fromJson(Map<String, dynamic> json) {
    List<AirportService> list(String key) => (json[key] as List<dynamic>? ?? <dynamic>[])
        .map((dynamic e) => AirportService.fromJson(e as Map<String, dynamic>))
        .toList();

    return AirportGuide(
      code: json['code'] as String,
      name: json['name'] as String,
      terminals: (json['terminals'] as List<dynamic>).cast<String>(),
      gate: json['gate'] as String,
      walkMinutes: (json['walkMinutes'] as num).toInt(),
      securityWaitMinutes: (json['securityWaitMinutes'] as num).toInt(),
      boardingTime: json['boardingTime'] as String,
      lounges: list('lounges'),
      transport: list('transport'),
      food: list('food'),
    );
  }
}
