class DashboardStat {
  final String title;
  final String value;

  DashboardStat({
    required this.title,
    required this.value,
  });
}

// =======================
// LOCALIZED TEXT
// =======================

class LocalizedText {
  final String en;
  final String ta;

  const LocalizedText({
    this.en = '',
    this.ta = '',
  });

  factory LocalizedText.fromJson(dynamic json) {
    if (json is! Map) {
      return const LocalizedText();
    }

    return LocalizedText(
      en: json['en']?.toString() ?? '',
      ta: json['ta']?.toString() ?? '',
    );
  }

  String valueForLanguage({
    required bool isTamil,
  }) {
    if (isTamil) {
      return ta.isNotEmpty ? ta : en;
    }

    return en.isNotEmpty ? en : ta;
  }
}

// =======================
// CONTENT ATTACHMENT
// =======================

class ContentAttachment {
  final String id;
  final String type;
  final String url;
  final String thumbnailUrl;
  final LocalizedText title;
  final int sortOrder;

  const ContentAttachment({
    required this.id,
    required this.type,
    required this.url,
    required this.thumbnailUrl,
    required this.title,
    required this.sortOrder,
  });

  factory ContentAttachment.fromJson(
    Map<String, dynamic> json,
  ) {
    return ContentAttachment(
      id: json['_id']?.toString() ?? '',
      type: json['Type']?.toString() ?? '',
      url: json['Url']?.toString() ?? '',
      thumbnailUrl: json['ThumbnailUrl']?.toString() ?? '',
      title: LocalizedText.fromJson(json['Title']),
      sortOrder: _toInt(json['SortOrder']),
    );
  }
}

// =======================
// CONTENT
// =======================

class Content {
  final String id;
  final String contentId;
  final String type;
  final String category;
  final String slug;

  final LocalizedText title;
  final LocalizedText shortDescription;
  final LocalizedText description;

  final DateTime? eventStartDate;
  final DateTime? eventEndDate;

  final LocalizedText venue;
  final LocalizedText address;

  final String? registrationUrl;

  final List<ContentAttachment> attachments;

  final DateTime? publishedOn;

  final String status;
  final bool isActive;
  final bool isDeleted;

  final int version;

  const Content({
    required this.id,
    required this.contentId,
    required this.type,
    required this.category,
    required this.slug,
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.venue,
    required this.address,
    required this.registrationUrl,
    required this.attachments,
    required this.publishedOn,
    required this.status,
    required this.isActive,
    required this.isDeleted,
    required this.version,
  });

  factory Content.fromJson(
    Map<String, dynamic> json,
  ) {
    final attachmentsJson = json['Attachments'];

    return Content(
      id: json['_id']?.toString() ?? '',
      contentId: json['ContentId']?.toString() ?? '',
      type: json['Type']?.toString() ?? '',
      category: json['Category']?.toString() ?? '',
      slug: json['Slug']?.toString() ?? '',
      title: LocalizedText.fromJson(json['Title']),
      shortDescription: LocalizedText.fromJson(
        json['ShortDescription'],
      ),
      description: LocalizedText.fromJson(
        json['Description'],
      ),
      eventStartDate: _parseDate(json['EventStartDate']),
      eventEndDate: _parseDate(json['EventEndDate']),
      venue: LocalizedText.fromJson(json['Venue']),
      address: LocalizedText.fromJson(json['Address']),
      registrationUrl: _nullableString(
        json['RegistrationUrl'],
      ),
      attachments: attachmentsJson is List
          ? attachmentsJson
              .whereType<Map>()
              .map(
                (item) => ContentAttachment.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList()
          : const [],
      publishedOn: _parseDate(json['PublishedOn']),
      status: json['Status']?.toString() ?? '',
      isActive: json['IsActive'] == true,
      isDeleted: json['IsDeleted'] == true,
      version: _toInt(json['__v']),
    );
  }

  List<String> get imageUrls {
    return attachments
        .where(
          (attachment) =>
              attachment.type.toUpperCase() == 'IMAGE',
        )
        .map((attachment) => attachment.url)
        .where((url) => url.isNotEmpty)
        .toList();
  }

  List<String> get videoUrls {
    return attachments
        .where(
          (attachment) =>
              attachment.type.toUpperCase() == 'VIDEO',
        )
        .map((attachment) => attachment.url)
        .where((url) => url.isNotEmpty)
        .toList();
  }

  List<String> get attachmentUrls {
    return attachments
        .map((attachment) => attachment.url)
        .where((url) => url.isNotEmpty)
        .toList();
  }
}

// =======================
// ALERT
// =======================

class Alert {
  final String id;
  final LocalizedText message;
  final DateTime? expiresOn;
  final bool isActive;
  final int version;

  const Alert({
    required this.id,
    required this.message,
    required this.expiresOn,
    required this.isActive,
    required this.version,
  });

  factory Alert.fromJson(
    Map<String, dynamic> json,
  ) {
    return Alert(
      id: json['_id']?.toString() ?? '',
      message: LocalizedText.fromJson(
        json['Message'],
      ),
      expiresOn: _parseDate(json['ExpiresOn']),
      isActive: json['IsActive'] == true,
      version: _toInt(json['__v']),
    );
  }

  bool get isCurrentlyActive {
    if (!isActive) {
      return false;
    }

    if (expiresOn == null) {
      return true;
    }

    return expiresOn!.isAfter(DateTime.now());
  }
}

// =======================
// HELPERS
// =======================

DateTime? _parseDate(dynamic value) {
  if (value == null) {
    return null;
  }

  final stringValue = value.toString();

  if (stringValue.isEmpty) {
    return null;
  }

  return DateTime.tryParse(stringValue);
}

String? _nullableString(dynamic value) {
  if (value == null) {
    return null;
  }

  final stringValue = value.toString();

  if (stringValue.isEmpty) {
    return null;
  }

  return stringValue;
}

int _toInt(dynamic value) {
  if (value is int) {
    return value;
  }

  return int.tryParse(value?.toString() ?? '') ?? 0;
}