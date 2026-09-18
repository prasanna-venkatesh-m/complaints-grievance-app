import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tvk_grievance/app/router/app_routes.dart';
import 'package:tvk_grievance/core/services/translation_controller.dart';
import 'package:tvk_grievance/features/grievance/grievance_model.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';

class HistoryGrievanceCard extends ConsumerWidget {
  final GrievanceModel grievance;

  const HistoryGrievanceCard({
    super.key,
    required this.grievance,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final l10n = AppLocalizations.of(context)!;

    // =========================================================================
    // ML TRANSLATIONS
    // =========================================================================

    final translatedArea = ref.watch(
      translationProvider(
        grievance.area ?? '',
      ),
    );

    final translatedStreet = ref.watch(
      translationProvider(
        grievance.street ?? '',
      ),
    );

    final translatedDescription = ref.watch(
      translationProvider(
        grievance.title ?? '',
      ),
    );

    // =========================================================================
    // TRANSLATION HELPER
    // =========================================================================

    String getTranslatedText(
      AsyncValue<String> value,
      String original,
    ) {
      return value.when(
        loading: () => original,
        error: (_, __) => original,
        data: (translatedText) {
          if (translatedText.trim().isEmpty) {
            return original;
          }

          return translatedText;
        },
      );
    }

    // =========================================================================
    // TRANSLATED VALUES
    // =========================================================================

    final area = getTranslatedText(
      translatedArea,
      grievance.area ?? '',
    );

    final street = getTranslatedText(
      translatedStreet,
      grievance.street ?? '',
    );

    final description = getTranslatedText(
      translatedDescription,
      grievance.title ?? '',
    );

    String _getCategoryName(
      BuildContext context,
      String category,
    ) {
      return switch (category) {
        'Water' => l10n.water,
        'Roads' => l10n.roads,
        'Electricity' => l10n.electricity,
        'Sanitation' => l10n.sanitation,
        'Public Services' => l10n.publicServices,
        'Housing & Welfare' => l10n.housingWelfare,
        'Education & Healthcare' =>
          l10n.educationHealthcare,
        'Other' => l10n.other,
        _ => category,
      };
    }

    return GestureDetector(
      onTap: () {
        context.push(
          '${AppRoutes.grievanceDetails}/${grievance.id}',
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.black87,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Tick Icon
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(.3),
                    blurRadius: 6,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.done_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Reference Number + Status
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "#${grievance.ticketId}",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "${l10n.resolved} ${grievance.date}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// Issue Category • Ward • Area • Street
                  Text(
                    '${_getCategoryName(
                      context,
                      grievance.issueCategory ?? '',
                    )}'
                    ' • ${l10n.ward} ${grievance.ward}'
                    ' • $area'
                    ' • $street',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// Issue Description
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Rating
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.only(
                            right: 3,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.black,
                              ),
                              Icon(
                                Icons.star,
                                size: 16,
                                color: index <
                                        grievance.ratingValue
                                    ? Colors.amber
                                    : Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
