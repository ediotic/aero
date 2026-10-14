enum TripType { oneWay, roundTrip, multiCity }

/// What the traveller typed into the search card on Home.
class SearchQuery {
  const SearchQuery({
    required this.fromCode,
    required this.fromCity,
    required this.toCode,
    required this.toCity,
    required this.date,
    this.adults = 1,
    this.cabin = 'Economy',
    this.tripType = TripType.oneWay,
  });

  factory SearchQuery.initial() => SearchQuery(
        fromCode: 'DEL',
        fromCity: 'New Delhi',
        toCode: 'BOM',
        toCity: 'Mumbai',
        date: DateTime.now().add(const Duration(days: 6)),
      );

  final String fromCode;
  final String fromCity;
  final String toCode;
  final String toCity;
  final DateTime date;
  final int adults;
  final String cabin;
  final TripType tripType;

  SearchQuery copyWith({
    String? fromCode,
    String? fromCity,
    String? toCode,
    String? toCity,
    DateTime? date,
    int? adults,
    String? cabin,
    TripType? tripType,
  }) {
    return SearchQuery(
      fromCode: fromCode ?? this.fromCode,
      fromCity: fromCity ?? this.fromCity,
      toCode: toCode ?? this.toCode,
      toCity: toCity ?? this.toCity,
      date: date ?? this.date,
      adults: adults ?? this.adults,
      cabin: cabin ?? this.cabin,
      tripType: tripType ?? this.tripType,
    );
  }

  /// Swap origin and destination.
  SearchQuery swapped() => copyWith(
        fromCode: toCode,
        fromCity: toCity,
        toCode: fromCode,
        toCity: fromCity,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'from': fromCode,
        'to': toCode,
        'date': date.toIso8601String().substring(0, 10),
        'adults': adults,
        'cabin': cabin,
        'tripType': tripType.name,
      };
}
