enum TripStatus { confirmed, completed, cancelled }

class Trip {
  const Trip({
    required this.pnr,
    required this.flightNo,
    required this.airlineName,
    required this.airlineCode,
    required this.date,
    required this.fromCode,
    required this.toCode,
    required this.departTime,
    required this.arriveTime,
    required this.seat,
    required this.baggageKg,
    required this.status,
    this.fromCity = '',
    this.toCity = '',
  });

  final String pnr;
  final String flightNo;
  final String airlineName;
  final String airlineCode;
  final DateTime date;
  final String fromCode;
  final String toCode;
  final String fromCity;
  final String toCity;
  final String departTime;
  final String arriveTime;
  final String seat;
  final int baggageKg;
  final TripStatus status;

  Trip copyWith({TripStatus? status}) {
    return Trip(
      pnr: pnr,
      flightNo: flightNo,
      airlineName: airlineName,
      airlineCode: airlineCode,
      date: date,
      fromCode: fromCode,
      toCode: toCode,
      fromCity: fromCity,
      toCity: toCity,
      departTime: departTime,
      arriveTime: arriveTime,
      seat: seat,
      baggageKg: baggageKg,
      status: status ?? this.status,
    );
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      pnr: json['pnr'] as String,
      flightNo: json['flightNo'] as String,
      airlineName: json['airlineName'] as String,
      airlineCode: json['airlineCode'] as String,
      date: DateTime.parse(json['date'] as String),
      fromCode: json['fromCode'] as String,
      toCode: json['toCode'] as String,
      fromCity: (json['fromCity'] as String?) ?? '',
      toCity: (json['toCity'] as String?) ?? '',
      departTime: json['departTime'] as String,
      arriveTime: json['arriveTime'] as String,
      seat: (json['seat'] as String?) ?? '-',
      baggageKg: (json['baggageKg'] as num?)?.toInt() ?? 15,
      status: TripStatus.values.firstWhere(
        (TripStatus s) => s.name == json['status'],
        orElse: () => TripStatus.confirmed,
      ),
    );
  }
}
