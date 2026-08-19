import 'package:flutter/material.dart';
import 'package:tvk_grievance/app/widgets/header_text_widget.dart';
import 'package:tvk_grievance/features/grievance/widgets/history_grievance_card.dart';
import 'package:tvk_grievance/features/grievance/widgets/open_grievance_card.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';

import '../grievance_model.dart';

class GrievanceList extends StatelessWidget {
  final List<GrievanceModel> grievances;

  const GrievanceList({super.key, required this.grievances});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final openList = grievances.where((e) => e.status != "Resolved").toList();

    final history = grievances.where((e) => e.status == "Resolved").toList();

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTextWidget(text: l10n.open),
            const SizedBox(height: 10),
            ...openList.map((e) => OpenGrievanceCard(grievance: e)),
            const SizedBox(height: 20),
            HeaderTextWidget(text: l10n.history),
            ...history.map((e) => HistoryGrievanceCard(grievance: e)),
          ],
        ),
      ),
    );
  }
}
