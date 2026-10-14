enum SeatState { free, premium, taken }

class Seat {
  const Seat({required this.row, required this.letter, required this.state});

  final int row;
  final String letter;
  final SeatState state;

  String get id => '$row$letter';
  bool get isWindow => letter == 'A' || letter == 'F';
  bool get isMiddle => letter == 'B' || letter == 'E';

  String get position {
    if (isWindow) return 'Window';
    if (isMiddle) return 'Middle';
    return 'Aisle';
  }

  /// Seat fee in rupees.
  int get fee => state == SeatState.premium ? 550 : 250;
}
