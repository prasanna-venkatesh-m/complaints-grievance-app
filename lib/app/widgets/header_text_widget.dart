import 'package:flutter/material.dart';

class HeaderTextWidget extends StatelessWidget {
  final String text;

  const HeaderTextWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: .3,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFE91E63),
                  Color(0xFFFFC107),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}