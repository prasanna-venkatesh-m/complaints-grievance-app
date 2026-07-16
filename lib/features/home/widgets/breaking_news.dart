import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class BreakingNews extends StatelessWidget {
  const BreakingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14),
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
        text:
            "📢     New Water pipeline works begin in Ward 171 - Road closed. Please use alternate routes.",
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        blankSpace: 80,
        velocity: 40,
        pauseAfterRound: const Duration(seconds: 1),
        startPadding: 10,
        accelerationDuration: const Duration(milliseconds: 500),
        accelerationCurve: Curves.linear,
        decelerationDuration: const Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}