import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: selected ? const Color(0xffA00037) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.black87, width: 1.5),
          boxShadow: const [
            BoxShadow(color: Colors.orange, offset: Offset(4, 4)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
