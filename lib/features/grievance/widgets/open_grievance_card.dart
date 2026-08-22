import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tvk_grievance/features/grievance/grievance_model.dart';

class OpenGrievanceCard extends StatelessWidget {
  final GrievanceModel grievance;

  const OpenGrievanceCard({
    super.key,
    required this.grievance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black87,
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.orange,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Status + Reference Number
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statusBadge(grievance.status),

              Text(
                "#${grievance.ticketId}",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// Title
          Text(
            grievance.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 24),

          /// Dynamic Timeline
          _buildTimeline(),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STATUS BADGE
  // ---------------------------------------------------------------------------

  Widget _statusBadge(String status) {
    final normalizedStatus = status.trim().toUpperCase();

    Color backgroundColor;
    Color borderColor;

    switch (normalizedStatus) {
      case 'RESOLVED':
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
        backgroundColor = const Color(0xff8B4D18);
        borderColor = const Color(0xffE2B43C);
        break;

      default:
        backgroundColor = Colors.grey.shade700;
        borderColor = Colors.grey.shade400;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: borderColor,
          width: 1.5,
        ),
      ),
      child: Text(
        normalizedStatus,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
          letterSpacing: .5,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TIMELINE
  // ---------------------------------------------------------------------------

  Widget _buildTimeline() {
    final history = grievance.progressHistory;

    final hasHistory = history.isNotEmpty;
    final hasDueDate = grievance.dueOn != null;
    final hasResolution = grievance.resolution != null;

    // Nothing to show
    if (!hasHistory && !hasDueDate && !hasResolution) {
      return Text(
        'No progress updates available',
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 14,
        ),
      );
    }

    final List<Widget> tiles = [];

    // -------------------------------------------------------------------------
    // PROGRESS HISTORY
    // -------------------------------------------------------------------------

    for (int i = 0; i < history.length; i++) {
      final progress = history[i];

      final isLastHistoryItem = i == history.length - 1;

      // Whether another timeline item comes after this one.
      final hasNextItem =
          !isLastHistoryItem ||
          grievance.dueOn != null ||
          grievance.resolution != null;

      tiles.add(
        timelineTile(
          color: isLastHistoryItem
              ? Colors.orange
              : const Color(0xffD81B60),
          title: progress.description,
          subtitle: _buildProgressSubtitle(progress),
          showLine: hasNextItem,
        ),
      );
    }

    // -------------------------------------------------------------------------
    // EXPECTED RESOLUTION
    // -------------------------------------------------------------------------

    if (grievance.dueOn != null && !grievance.isResolved) {
      tiles.add(
        timelineTile(
          color: Colors.grey,
          title: 'Resolution & Closure',
          subtitle: 'Expected by ${_formatDate(grievance.dueOn)}',
          showLine: grievance.resolution != null,
        ),
      );
    }

    // -------------------------------------------------------------------------
    // ACTUAL RESOLUTION
    // -------------------------------------------------------------------------

    if (grievance.resolution != null) {
      final resolvedOn = grievance.resolution!.resolvedOn;

      tiles.add(
        timelineTile(
          color: Colors.green,
          title: 'Resolution & Closure',
          subtitle: resolvedOn != null
              ? 'Resolved on ${_formatDate(resolvedOn)}'
              : 'Resolved',
          showLine: false,
        ),
      );
    }

    return Column(
      children: tiles,
    );
  }

  // ---------------------------------------------------------------------------
  // PROGRESS SUBTITLE
  // ---------------------------------------------------------------------------

  String _buildProgressSubtitle(
    ProgressHistoryModel progress,
  ) {
    return _formatDateTime(progress.updatedOn);
  }

  // ---------------------------------------------------------------------------
  // TIMELINE TILE
  // ---------------------------------------------------------------------------

  Widget timelineTile({
    required Color color,
    required String title,
    required String subtitle,
    required bool showLine,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -----------------------------------------------------------------
            // TIMELINE INDICATOR
            // -----------------------------------------------------------------

            Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF8B4D18),
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                ),

                if (showLine)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 14),

            // -----------------------------------------------------------------
            // TIMELINE CONTENT
            // -----------------------------------------------------------------

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 5),

                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // DATE FORMATTERS
  // ---------------------------------------------------------------------------

  String _formatDateTime(DateTime? date) {
    if (date == null) {
      return '';
    }

    return DateFormat(
      'dd MMM, h:mm a',
    ).format(
      date.toLocal(),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }

    return DateFormat(
      'dd MMM yyyy',
    ).format(
      date.toLocal(),
    );
  }
}