import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const HomeBottomNav({super.key, this.currentIndex = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      elevation: 12,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),

        BottomNavigationBarItem(
          icon: Icon(Icons.campaign_rounded), // or Icons.report_problem_rounded
          label: "Grievances",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.support_agent_rounded),
          label: "Helpdesk",
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.person_outline),
        //   label: "Profile",
        // ),
      ],
    );
  }
}
