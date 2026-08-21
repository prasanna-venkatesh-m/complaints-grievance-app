import 'package:url_launcher/url_launcher.dart';

class ContactActionsService {
  const ContactActionsService();

  /// Open phone dialer.
  Future<bool> call(String phoneNumber) async {
    final phone = _cleanPhoneNumber(phoneNumber);

    if (phone.isEmpty) {
      return false;
    }

    final uri = Uri(
      scheme: 'tel',
      path: phone,
    );

    return launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  /// Open WhatsApp chat.
  Future<bool> whatsapp(String phoneNumber) async {
    final phone = _cleanPhoneNumber(phoneNumber);

    if (phone.isEmpty) {
      return false;
    }

    // WhatsApp expects the international number
    // without the '+' sign.
    final whatsappNumber = phone.replaceAll('+', '');

    final uri = Uri.parse(
      'https://wa.me/$whatsappNumber',
    );

    return launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  /// Open the supplied Google Maps URL.
  Future<bool> map({
    required String mapUrl,
    double? latitude,
    double? longitude,
  }) async {
    Uri? uri;

    // Prefer the API-provided Google Maps URL.
    if (mapUrl.trim().isNotEmpty) {
      uri = Uri.tryParse(mapUrl);
    }

    // Fallback to coordinates if mapUrl is unavailable.
    if (uri == null &&
        latitude != null &&
        longitude != null) {
      uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1'
        '&query=$latitude,$longitude',
      );
    }

    if (uri == null) {
      return false;
    }

    return launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  String _cleanPhoneNumber(String value) {
    return value
        .trim()
        .replaceAll(' ', '')
        .replaceAll('-', '')
        .replaceAll('(', '')
        .replaceAll(')', '');
  }
}