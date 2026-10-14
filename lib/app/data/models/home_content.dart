/// Which illustration a destination card uses.
enum DestinationArt { goa, jaipur, dubai }

class Destination {
  const Destination({
    required this.city,
    required this.priceFrom,
    required this.info,
    required this.art,
    required this.toCode,
  });

  final String city;
  final int priceFrom;
  final String info;
  final DestinationArt art;
  final String toCode;

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      city: json['city'] as String,
      priceFrom: (json['priceFrom'] as num).toInt(),
      info: json['info'] as String,
      art: DestinationArt.values.firstWhere(
        (DestinationArt a) => a.name == json['art'],
        orElse: () => DestinationArt.goa,
      ),
      toCode: (json['toCode'] as String?) ?? '',
    );
  }
}

enum OfferStyle { purple, navy }

class Offer {
  const Offer({
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.style,
  });

  final String badge;
  final String title;
  final String subtitle;
  final OfferStyle style;

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      badge: json['badge'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      style: OfferStyle.values.firstWhere(
        (OfferStyle s) => s.name == json['style'],
        orElse: () => OfferStyle.purple,
      ),
    );
  }
}
