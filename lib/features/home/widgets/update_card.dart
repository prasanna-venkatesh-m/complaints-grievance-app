import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class UpdateCard extends StatelessWidget {
  const UpdateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black12)],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xffFFE9A9),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.campaign, color: AppColors.primary),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Latest Update",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 5),

                Text(
                  "Bridge renovation work begins next week in Chennai district.",
                  style: TextStyle(color: Colors.grey, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
