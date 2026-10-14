/// Colour tone of the small badge shown on a flight card.
enum BadgeTone { success, primary, warning, neutral }

class Flight {
  const Flight({
    required this.id,
    required this.airlineName,
    required this.airlineCode,
    required this.flightNo,
    required this.aircraft,
    required this.departTime,
    required this.arriveTime,
    required this.fromCode,
    required this.toCode,
    required this.fromCity,
    required this.toCity,
    required this.fromTerminal,
    required this.toTerminal,
    required this.duration,
    required this.baseFare,
    required this.taxes,
    required this.fuelSurcharge,
    required this.convenienceFee,
    required this.checkInBaggageKg,
    this.cabinBaggageKg = 7,
    this.stops = 0,
    this.perk = '',
    this.badge,
    this.badgeTone = BadgeTone.neutral,
    this.refundAmount = 0,
    this.wifiFrom = 299,
  });

  final String id;
  final String airlineName;
  final String airlineCode;
  final String flightNo;
  final String aircraft;
  final String departTime;
  final String arriveTime;
  final String fromCode;
  final String toCode;
  final String fromCity;
  final String toCity;
  final String fromTerminal;
  final String toTerminal;
  final String duration;
  final int stops;
  final int baseFare;
  final int taxes;
  final int fuelSurcharge;
  final int convenienceFee;
  final int checkInBaggageKg;
  final int cabinBaggageKg;

  /// Short highlight shown in the card footer, e.g. "Refundable".
  final String perk;
  final String? badge;
  final BadgeTone badgeTone;
  final int refundAmount;
  final int wifiFrom;

  int get totalFare => baseFare + taxes + fuelSurcharge + convenienceFee;
  int get taxesAndFees => taxes + fuelSurcharge + convenienceFee;
  bool get isNonStop => stops == 0;

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'] as String,
      airlineName: json['airlineName'] as String,
      airlineCode: json['airlineCode'] as String,
      flightNo: json['flightNo'] as String,
      aircraft: (json['aircraft'] as String?) ?? '',
      departTime: json['departTime'] as String,
      arriveTime: json['arriveTime'] as String,
      fromCode: json['fromCode'] as String,
      toCode: json['toCode'] as String,
      fromCity: (json['fromCity'] as String?) ?? json['fromCode'] as String,
      toCity: (json['toCity'] as String?) ?? json['toCode'] as String,
      fromTerminal: (json['fromTerminal'] as String?) ?? '',
      toTerminal: (json['toTerminal'] as String?) ?? '',
      duration: json['duration'] as String,
      stops: (json['stops'] as num?)?.toInt() ?? 0,
      baseFare: (json['baseFare'] as num).toInt(),
      taxes: (json['taxes'] as num).toInt(),
      fuelSurcharge: (json['fuelSurcharge'] as num?)?.toInt() ?? 0,
      convenienceFee: (json['convenienceFee'] as num?)?.toInt() ?? 0,
      checkInBaggageKg: (json['checkInBaggageKg'] as num?)?.toInt() ?? 15,
      cabinBaggageKg: (json['cabinBaggageKg'] as num?)?.toInt() ?? 7,
      perk: (json['perk'] as String?) ?? '',
      badge: json['badge'] as String?,
      badgeTone: BadgeTone.values.firstWhere(
        (BadgeTone t) => t.name == json['badgeTone'],
        orElse: () => BadgeTone.neutral,
      ),
      refundAmount: (json['refundAmount'] as num?)?.toInt() ?? 0,
    );
  }
}
