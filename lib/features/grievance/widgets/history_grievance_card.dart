import 'package:flutter/material.dart';
import 'package:tvk_grievance/features/grievance/grievance_model.dart';

class HistoryGrievanceCard extends StatelessWidget {
  final GrievanceModel grievance;

  const HistoryGrievanceCard({super.key, required this.grievance});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black87, width: 1),
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
              border: Border.all(color: Colors.white, width: 2),
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
                        "#${grievance.id}",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "Resolved in ${grievance.date}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// Issue Title
                Text(
                  grievance.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 10),

                /// Rating
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 3),
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
                              color: index < grievance.rating
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
    );
  }
}
