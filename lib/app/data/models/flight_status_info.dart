enum FlightStatusType { onTime, delayed, cancelled }

class FlightStatusInfo {
  const FlightStatusInfo({
    required this.flightNo,
    required this.airlineName,
    required this.airlineCode,
    required this.date,
    required this.fromCode,
    required this.toCode,
    required this.departTime,
    required this.arriveTime,
    required this.status,
    this.newDepartTime,
    this.newArriveTime,
    this.gate,
    this.terminal,
    this.boardingTime,
    this.delayMinutes = 0,
    this.delayReason = '',
  });

  final String flightNo;
  final String airlineName;
  final String airlineCode;
  final DateTime date;
  final String fromCode;
  final String toCode;
  final String departTime;
  final String arriveTime;
  final FlightStatusType status;
  final String? newDepartTime;
  final String? newArriveTime;
  final String? gate;
  final String? terminal;
  final String? boardingTime;
  final int delayMinutes;
  final String delayReason;

  factory FlightStatusInfo.fromJson(Map<String, dynamic> json) {
    return FlightStatusInfo(
      flightNo: json['flightNo'] as String,
      airlineName: json['airlineName'] as String,
      airlineCode: json['airlineCode'] as String,
      date: DateTime.parse(json['date'] as String),
      fromCode: json['fromCode'] as String,
      toCode: json['toCode'] as String,
      departTime: json['departTime'] as String,
      arriveTime: json['arriveTime'] as String,
      status: FlightStatusType.values.firstWhere(
        (FlightStatusType s) => s.name == json['status'],
        orElse: () => FlightStatusType.onTime,
      ),
      newDepartTime: json['newDepartTime'] as String?,
      newArriveTime: json['newArriveTime'] as String?,
      gate: json['gate'] as String?,
      terminal: json['terminal'] as String?,
      boardingTime: json['boardingTime'] as String?,
      delayMinutes: (json['delayMinutes'] as num?)?.toInt() ?? 0,
      delayReason: (json['delayReason'] as String?) ?? '',
    );
  }
}
