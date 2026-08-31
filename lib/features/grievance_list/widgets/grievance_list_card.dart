import 'package:flutter/material.dart';

import 'package:tvk_grievance/features/grievance/grievance_model.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';

class GrievanceListCard extends StatelessWidget {
  final GrievanceModel grievance;
  final VoidCallback? onTap;

  const GrievanceListCard({
    super.key,
    required this.grievance,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ============================================================
            // TOP ROW
            // ============================================================

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ICON
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xffF2F2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.report_problem_outlined,
                      size: 24,
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // TICKET ID
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        grievance.issueCategory,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        grievance.ticketId,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // STATUS
                _statusBadge(
                  l10n: l10n,
                  status: grievance.status,
                ),
              ],
            ),

            const SizedBox(height: 14),

            // ============================================================
            // DESCRIPTION
            // ============================================================

            Text(
              grievance.description.isNotEmpty
                  ? grievance.description
                  : l10n.noDescriptionAvailable,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            // ============================================================
            // LOCATION
            // ============================================================

            if (_hasLocation(grievance)) ...[
              const SizedBox(height: 12),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 15,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      _locationText(
                        grievance,
                        l10n,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 12),

            // ============================================================
            // BOTTOM INFO
            // ============================================================

            Row(
              children: [
                if (grievance.date.isNotEmpty) ...[
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 13,
                    color: Colors.black45,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    grievance.date,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],

                const Spacer(),

                if (grievance.attachments.isNotEmpty)
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_file,
                        size: 13,
                        color: Colors.black45,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${grievance.attachments.length}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // LOCATION
  // =========================================================================

  bool _hasLocation(GrievanceModel grievance) {
    return grievance.area?.isNotEmpty == true ||
        grievance.street?.isNotEmpty == true ||
        grievance.ward?.isNotEmpty == true ||
        grievance.constituency?.isNotEmpty == true;
  }

  String _locationText(
    GrievanceModel grievance,
    AppLocalizations l10n,
  ) {
    final parts = <String>[];

    if (grievance.area?.isNotEmpty == true) {
      parts.add(grievance.area!);
    }

    if (grievance.street?.isNotEmpty == true) {
      parts.add(grievance.street!);
    }

    if (grievance.ward?.isNotEmpty == true) {
      parts.add('${l10n.ward} ${grievance.ward}');
    }

    if (grievance.constituency?.isNotEmpty == true) {
      parts.add(grievance.constituency!);
    }

    return parts.join(', ');
  }

  // =========================================================================
  // STATUS BADGE
  // =========================================================================

  Widget _statusBadge({
    required AppLocalizations l10n,
    required String status,
  }) {
    final normalizedStatus = status.trim().toUpperCase();

    Color backgroundColor;
    Color borderColor;

    switch (normalizedStatus) {
      case 'RESOLVED':
        backgroundColor = Colors.green.shade700;
        borderColor = Colors.green.shade300;
        break;

      case 'CLOSED':
        backgroundColor = Colors.green.shade700;
        borderColor = Colors.green.shade300;
        break;

      case 'REOPENED':
        backgroundColor = Colors.red.shade700;
        borderColor = Colors.red.shade300;
        break;

      case 'IN PROGRESS':
      case 'IN_PROGRESS':
      case 'FORWARDED':
      case 'UNDER REVIEW':
      case 'UNDER_REVIEW':
      case 'PROCESSING':
        backgroundColor = const Color(0xff8B4D18);
        borderColor = const Color(0xffE2B43C);
        break;

      case 'SUBMITTED':
        backgroundColor = const Color(0xff8A0038);
        borderColor = const Color(0xffD4A72C);
        break;

      case 'REJECTED':
        backgroundColor = Colors.red.shade700;
        borderColor = Colors.red.shade300;
        break;

      default:
        backgroundColor = Colors.grey.shade700;
        borderColor = Colors.grey.shade400;
    }

    return Container(
      constraints: const BoxConstraints(
        minWidth: 75,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Text(
        _displayStatus(
          l10n,
          normalizedStatus,
        ),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }

  String _displayStatus(
    AppLocalizations l10n,
    String status,
  ) {
    switch (status) {
      case 'SUBMITTED':
        return l10n.submitted;

      case 'FORWARDED':
        return l10n.forwarded;

      case 'UNDER REVIEW':
      case 'UNDER_REVIEW':
        return l10n.underReview;

      case 'IN PROGRESS':
      case 'IN_PROGRESS':
      case 'PROCESSING':
        return l10n.inProgress;

      case 'RESOLVED':
        return l10n.resolved;

      case 'CLOSED':
        return l10n.closed;

      case 'REJECTED':
        return l10n.rejected;

      default:
        return status;
    }
  }
}
