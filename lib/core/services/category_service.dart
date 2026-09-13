
import 'package:flutter/material.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';

String getCategoryName(
  BuildContext context,
  String category,
) {
  final l10n = AppLocalizations.of(context)!;

  return switch (category.trim()) {
    'Water' => l10n.water,
    'Roads' => l10n.roads,
    'Electricity' => l10n.electricity,
    'Drainage' => l10n.drainage,
    'Garbage' => l10n.garbage,
    'Public Services' => l10n.publicServices,
    'Housing & Welfare' => l10n.housingWelfare,
    'Education & Healthcare' => l10n.educationHealthcare,
    'Other' => l10n.other,
    _ => category,
  };
}
