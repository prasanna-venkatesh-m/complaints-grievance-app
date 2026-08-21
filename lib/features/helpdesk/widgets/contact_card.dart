import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tvk_grievance/app/providers.dart';
import 'package:tvk_grievance/core/services/contact_action_services.dart';
import 'package:tvk_grievance/shared/enums/app_language.dart';

import '../helpdesk_model.dart';

class ContactCard extends ConsumerWidget {
  final HelpdeskContact contact;

  const ContactCard({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);

    final isTamil = language == AppLanguage.tamil;

    final title = contact.name.getValue(isTamil);
    final subtitle = contact.tags.getValue(isTamil);
    final address = contact.address.getValue(isTamil);

    const actions = ContactActionsService();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black,
          width: 1.4,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.orange,
            offset: Offset(3, 3),
            blurRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ICON
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xffF2F2F2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                contact.emoji,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.red,
                    ),

                    const SizedBox(width: 4),

                    Expanded(
                      child: Text(
                        address,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ACTIONS
          Column(
            children: [
              // CALL
              _ActionButton(
                text: isTamil ? 'அழைப்பு' : 'CALL',
                icon: FontAwesomeIcons.phone,
                backgroundColor:
                    const Color(0xffC2185B),
                textColor: Colors.white,
                onTap: () async {
                  final success = await actions.call(
                    contact.phone,
                  );

                  if (!success && context.mounted) {
                    _showError(
                      context,
                      isTamil
                          ? 'அழைப்பைத் தொடங்க முடியவில்லை'
                          : 'Unable to make the call',
                    );
                  }
                },
              ),

              const SizedBox(height: 8),

              // WHATSAPP
              _ActionButton(
                text: isTamil
                    ? 'வாட்ஸ்அப்'
                    : 'WHATSAPP',
                icon: FontAwesomeIcons.whatsapp,
                backgroundColor:
                    const Color(0xFF25D366),
                textColor: Colors.white,
                onTap: () async {
                  final success =
                      await actions.whatsapp(
                    contact.whatsappNumber,
                  );

                  if (!success && context.mounted) {
                    _showError(
                      context,
                      isTamil
                          ? 'வாட்ஸ்அப்பைத் திறக்க முடியவில்லை'
                          : 'Unable to open WhatsApp',
                    );
                  }
                },
              ),

              const SizedBox(height: 8),

              // MAP
              _ActionButton(
                text: isTamil ? 'வரைபடம்' : 'MAP',
                icon: FontAwesomeIcons.locationDot,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                onTap: () async {
                  final success = await actions.map(
                    mapUrl: contact.mapUrl,
                    latitude: contact.latitude,
                    longitude: contact.longitude,
                  );

                  if (!success && context.mounted) {
                    _showError(
                      context,
                      isTamil
                          ? 'வரைபடத்தைத் திறக்க முடியவில்லை'
                          : 'Unable to open map',
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showError(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.text,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 100,
        height: 30,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 12,
              color: textColor,
            ),
            const SizedBox(width: 3),
            Text(
              text,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}