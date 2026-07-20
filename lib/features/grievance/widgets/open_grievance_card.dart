import 'package:flutter/material.dart';
import 'package:tvk_grievance/features/grievance/grievance_model.dart';

class OpenGrievanceCard extends StatelessWidget {
  final GrievanceModel grievance;

  const OpenGrievanceCard({super.key, required this.grievance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black87, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.orange,
            offset: const Offset(4, 4),
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff8B4D18),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xffE2B43C),
                    width: 1.5,
                  ),
                ),
                child: const Text(
                  "IN PROGRESS",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    letterSpacing: .5,
                  ),
                ),
              ),
              Text(
                "#${grievance.id}",
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

          timelineTile(
            color: const Color(0xffD81B60),
            title: "Received by MLA office",
            subtitle: "08 Jul, 6:12 PM",
            showLine: true,
          ),

          timelineTile(
            color: Colors.orange,
            title: "Forwarded to TNEB Saidapet",
            subtitle: "09 Jul, 10:30 AM",
            showLine: true,
          ),

          timelineTile(
            color: Colors.grey,
            title: "Resolution & Closure",
            subtitle: "Expected by 16 Jul",
            showLine: false,
          ),
        ],
      ),
    );
  }

  Widget timelineTile({
    required Color color,
    required String title,
    required String subtitle,
    required bool showLine,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Timeline
            Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF8B4D18), // Maroon
                      width: 2, // Thin border
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
                    child: Container(width: 2, color: Colors.grey.shade300),
                  ),
              ],
            ),

            const SizedBox(width: 14),

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
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
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
