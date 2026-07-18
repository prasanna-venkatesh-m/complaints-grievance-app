import 'package:flutter/material.dart';
import 'package:tvk_grievance/app/widgets/header_text_widget.dart';

class LatestUpdatesSection extends StatelessWidget {
  const LatestUpdatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTextWidget(text: "LATEST UPDATES"),
              const SizedBox(height: 12),
            ],
          ),

          const UpdateCard(),
        ],
      ),
    );
  }
}

class UpdateCard extends StatelessWidget {
  const UpdateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black, width: 1.5),
        boxShadow: const [
          BoxShadow(color: Colors.orange, offset: Offset(4, 5), blurRadius: 0),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xff8A0038),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "INFRASTRUCTURE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Saidapet bridge repair — Phase 2 sanctioned",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 17,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "₹4.2 Cr approved. Work starts first week of August.",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
