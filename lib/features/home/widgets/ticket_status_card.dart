import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class TicketStatusCard extends StatelessWidget {
  const TicketStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.confirmation_number_outlined,
                color: AppColors.primary,
              ),

              SizedBox(width: 8),

              Text(
                "Ticket Status",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xffFFF7E8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.assignment, color: Colors.white),
                ),

                SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Road Repair Request",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 4),

                      Text(
                        "Ticket #TN2024001",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                Chip(
                  backgroundColor: Colors.orange,
                  label: Text("Pending", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
