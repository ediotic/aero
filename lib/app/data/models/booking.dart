import 'flight.dart';

enum PaymentMethod { upi, card, netBanking }

/// What the traveller has chosen so far, passed from screen to screen.
class BookingDraft {
  const BookingDraft({
    required this.flight,
    this.seatId = '',
    this.seatLabel = '',
    this.seatFee = 0,
    this.passengerName = 'Ananya Sharma',
  });

  final Flight flight;
  final String seatId;
  final String seatLabel;
  final int seatFee;
  final String passengerName;

  int get total => flight.totalFare + seatFee;

  BookingDraft copyWith({
    String? seatId,
    String? seatLabel,
    int? seatFee,
    String? passengerName,
  }) {
    return BookingDraft(
      flight: flight,
      seatId: seatId ?? this.seatId,
      seatLabel: seatLabel ?? this.seatLabel,
      seatFee: seatFee ?? this.seatFee,
      passengerName: passengerName ?? this.passengerName,
    );
  }

  Map<String, dynamic> toJson(PaymentMethod method) => <String, dynamic>{
        'flightId': flight.id,
        'seat': seatId,
        'passenger': passengerName,
        'paymentMethod': method.name,
        'amount': total,
      };
}

/// A confirmed booking returned by the server after payment.
class Booking {
  const Booking({
    required this.pnr,
    required this.draft,
    required this.gate,
    required this.terminal,
    required this.boardingTime,
    required this.group,
    this.cabin = 'Economy',
  });

  final String pnr;
  final BookingDraft draft;
  final String gate;
  final String terminal;
  final String boardingTime;
  final String group;
  final String cabin;

  Flight get flight => draft.flight;

  /// Text encoded in the boarding pass QR code.
  String get qrData =>
      'AEROVA|$pnr|${flight.flightNo}|${flight.fromCode}-${flight.toCode}|${draft.seatId}|${draft.passengerName}';

  factory Booking.fromJson(Map<String, dynamic> json, BookingDraft draft) {
    return Booking(
      pnr: json['pnr'] as String,
      draft: draft,
      gate: (json['gate'] as String?) ?? '12',
      terminal: (json['terminal'] as String?) ?? draft.flight.fromTerminal,
      boardingTime: (json['boardingTime'] as String?) ?? '05:35',
      group: (json['group'] as String?) ?? '2',
      cabin: (json['cabin'] as String?) ?? 'Economy',
    );
  }
}
