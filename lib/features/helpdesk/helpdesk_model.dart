class LocalizedText {
  final String en;
  final String ta;

  const LocalizedText({
    required this.en,
    required this.ta,
  });

  factory LocalizedText.fromJson(Map<String, dynamic>? json) {
    return LocalizedText(
      en: json?['en']?.toString() ?? '',
      ta: json?['ta']?.toString() ?? '',
    );
  }

  String getValue(bool isTamil) {
    if (isTamil && ta.isNotEmpty) {
      return ta;
    }

    return en;
  }
}

class HelpdeskContact {
  final String id;

  final LocalizedText name;
  final LocalizedText tags;
  final LocalizedText address;

  final String emoji;
  final String phone;
  final String whatsappNumber;

  final double latitude;
  final double longitude;
  final String mapUrl;

  final bool isActive;

  const HelpdeskContact({
    required this.id,
    required this.name,
    required this.tags,
    required this.address,
    required this.emoji,
    required this.phone,
    required this.whatsappNumber,
    required this.latitude,
    required this.longitude,
    required this.mapUrl,
    required this.isActive,
  });

  factory HelpdeskContact.fromJson(Map<String, dynamic> json) {
    final location =
        json['Location'] as Map<String, dynamic>? ?? {};

    return HelpdeskContact(
      id: json['_id']?.toString() ?? '',

      name: LocalizedText.fromJson(
        json['Name'] as Map<String, dynamic>?,
      ),

      tags: LocalizedText.fromJson(
        json['Tags'] as Map<String, dynamic>?,
      ),

      address: LocalizedText.fromJson(
        json['Address'] as Map<String, dynamic>?,
      ),

      emoji: json['Icon']?.toString() ?? '🏢',

      phone: json['MobileNumber']?.toString() ?? '',

      whatsappNumber:
          json['WhatsappNumber']?.toString() ?? '',

      latitude:
          (location['Latitude'] as num?)?.toDouble() ?? 0,

      longitude:
          (location['Longitude'] as num?)?.toDouble() ?? 0,

      mapUrl:
          location['GoogleMapsUrl']?.toString() ?? '',

      isActive: json['IsActive'] == true,
    );
  }
}