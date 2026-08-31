import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tvk_grievance/app/router/app_routes.dart';
import 'package:tvk_grievance/app/widgets/header_text_widget.dart';
import 'package:tvk_grievance/features/grievance/widgets/history_grievance_card.dart';
import 'package:tvk_grievance/features/grievance/widgets/open_grievance_card.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';

import '../grievance_model.dart';

class GrievanceList extends StatelessWidget {
  final List<GrievanceModel> grievances;

  final bool isLoading;

  final String? errorMessage;

  final VoidCallback onRetry;

  const GrievanceList({
    super.key,
    required this.grievances,
    required this.isLoading,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // ==========================
    // LOADING
    // ==========================

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    // ==========================
    // ERROR
    // ==========================

    if (errorMessage != null && grievances.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(errorMessage!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      );
    }

    // ==========================
    // DATA
    // ==========================

    final openList = grievances.where((e) => !e.isResolved).toList();

    final history = grievances.where((e) => e.isResolved).toList();

    // ==========================
    // EMPTY
    // ==========================

    if (openList.isEmpty && history.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Text('No grievances found.', textAlign: TextAlign.center),
        ),
      );
    }

    // ==========================
    // SUCCESS
    // ==========================

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (openList.isNotEmpty) ...[
            HeaderActionWidget(
              title: l10n.open,
              actionText: l10n.viewMore,
              onTap: () {
                context.push(AppRoutes.getAllGrievances);
              },
            ),
            const SizedBox(height: 10),

            ...openList.map(
              (grievance) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: OpenGrievanceCard(grievance: grievance),
              ),
            ),
          ],

          if (history.isNotEmpty) ...[
            const SizedBox(height: 20),

            HeaderActionWidget(
              title: l10n.history,
              actionText: l10n.viewMore,
              onTap: () {
                context.push(AppRoutes.getAllGrievances);
              },
            ),
            const SizedBox(height: 5),

            ...history.map(
              (grievance) => HistoryGrievanceCard(grievance: grievance),
            ),
          ],
        ],
      ),
    );
  }
}
