import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquee/marquee.dart';
import 'package:tvk_grievance/app/providers.dart';

import '../home_providers.dart';

class BreakingNews extends ConsumerWidget {
  const BreakingNews({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final controller = ref.watch(
      homeControllerProvider,
    );

    final language = ref.watch(
      languageProvider,
    );

    final isTamil = language.toString().toLowerCase().contains(
          'tamil',
        );

    if (controller.isLoadingAlerts) {
      return Container(
        height: 40,
        width: double.infinity,
        color: const Color(0XFFf2b800),
        child: const Center(
          child: SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.black,
            ),
          ),
        ),
      );
    }

    if (controller.alertErrorMessage != null) {
      return Container(
        height: 40,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        color: const Color(0XFFf2b800),
        child: Row(
          children: [
            const Icon(
              Icons.error_outline,
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                controller.alertErrorMessage!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton(
              onPressed: controller.loadAlerts,
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
              ),
              child: const Text(
                'Retry',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final alerts = controller.alerts;

    if (alerts.isEmpty) {
      return const SizedBox.shrink();
    }

    final messages = alerts
        .map(
          (alert) => alert.message.valueForLanguage(
            isTamil: isTamil,
          ),
        )
        .where((message) => message.isNotEmpty)
        .toList();

    if (messages.isEmpty) {
      return const SizedBox.shrink();
    }

    final marqueeText = messages
        .map(
          (message) => '📢     $message',
        )
        .join('          •          ');

    return Container(
      height: 40,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      decoration: const BoxDecoration(
        color: Color(0XFFf2b800),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          ),
        ],
      ),
      child: Marquee(
        text: marqueeText,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        blankSpace: 80,
        velocity: 40,
        pauseAfterRound: const Duration(
          seconds: 1,
        ),
        startPadding: 10,
        accelerationDuration: const Duration(
          milliseconds: 500,
        ),
        accelerationCurve: Curves.linear,
        decelerationDuration: const Duration(
          milliseconds: 500,
        ),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}