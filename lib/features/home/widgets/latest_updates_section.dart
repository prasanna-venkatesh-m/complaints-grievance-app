import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import 'update_card.dart';

class LatestUpdatesSection extends StatelessWidget {
  const LatestUpdatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.newspaper, color: AppColors.primary),

              SizedBox(width: 8),

              Text(
                "Latest Updates",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),

          const SizedBox(height: 16),

          const UpdateCard(),

          const UpdateCard(),
        ],
      ),
    );
  }
}
