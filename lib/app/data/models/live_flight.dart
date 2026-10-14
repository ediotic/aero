class LiveFlight {
  const LiveFlight({
    required this.flightNo,
    required this.airlineName,
    required this.airlineCode,
    required this.fromCode,
    required this.toCode,
    required this.fromCity,
    required this.toCity,
    required this.progress,
    required this.totalMinutes,
    required this.altitudeFt,
    required this.speedKmh,
    required this.departedTime,
    required this.arrivalTime,
    required this.arrivalGate,
  });

  final String flightNo;
  final String airlineName;
  final String airlineCode;
  final String fromCode;
  final String toCode;
  final String fromCity;
  final String toCity;

  /// 0.0 to 1.0
  final double progress;
  final int totalMinutes;
  final int altitudeFt;
  final int speedKmh;
  final String departedTime;
  final String arrivalTime;
  final String arrivalGate;

  factory LiveFlight.fromJson(Map<String, dynamic> json) {
    return LiveFlight(
      flightNo: json['flightNo'] as String,
      airlineName: json['airlineName'] as String,
      airlineCode: json['airlineCode'] as String,
      fromCode: json['fromCode'] as String,
      toCode: json['toCode'] as String,
      fromCity: json['fromCity'] as String,
      toCity: json['toCity'] as String,
      progress: (json['progress'] as num).toDouble(),
      totalMinutes: (json['totalMinutes'] as num).toInt(),
      altitudeFt: (json['altitudeFt'] as num).toInt(),
      speedKmh: (json['speedKmh'] as num).toInt(),
      departedTime: json['departedTime'] as String,
      arrivalTime: json['arrivalTime'] as String,
      arrivalGate: json['arrivalGate'] as String,
    );
  }
}
