import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import 'stat_card.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [BoxShadow(blurRadius: 12, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.dashboard_customize, color: AppColors.primary),

              SizedBox(width: 8),

              Text(
                "Grievance Dashboard",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                child: StatCard(number: "1284", title: "Resolved"),
              ),

              SizedBox(width: 12),

              Expanded(
                child: StatCard(number: "46", title: "Pending"),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                child: StatCard(number: "16", title: "Today"),
              ),

              SizedBox(width: 12),

              Expanded(
                child: StatCard(number: "4.2", title: "Avg Days"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
