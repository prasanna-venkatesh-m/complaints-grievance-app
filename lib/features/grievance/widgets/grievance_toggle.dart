import 'package:flutter/material.dart';
import 'package:tvk_grievance/features/grievance/grievance_model.dart';

class GrievanceToggle extends StatelessWidget {
  final GrievanceTab selectedTab;
  final ValueChanged<GrievanceTab> onChanged;

  const GrievanceToggle({
    super.key,
    required this.selectedTab,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black87, width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Colors.orange, // yellow shadow
            blurRadius: 0,
            spreadRadius: 0,
            offset: Offset(4, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _item(
              title: "File new",
              selected: selectedTab == GrievanceTab.fileNew,
              onTap: () => onChanged(GrievanceTab.fileNew),
              emoji: "📝",
            ),
          ),
          Expanded(
            child: _item(
              title: "My grievances",
              selected: selectedTab == GrievanceTab.myGrievances,
              onTap: () => onChanged(GrievanceTab.myGrievances),
              emoji: "📋",
            ),
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String title,
    required bool selected,
    required VoidCallback onTap,
    required String emoji,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(11),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFC2185B) // pink
              : Colors.white,
          borderRadius: BorderRadius.circular(11),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
