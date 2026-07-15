import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tvk_grievance/core/constants/app_colors.dart';

import 'widgets/breaking_news.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/home_bottom_nav.dart';
import 'widgets/home_header.dart';
import 'widgets/latest_updates_section.dart';
import 'widgets/quick_action_card.dart';
import 'widgets/ticket_status_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.red,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 90),
          child: Column(
            children: [
              const HomeHeader(),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                child: Row(
                  children: const [
                    Expanded(
                      child: QuickActionCard(
                        icon: Icons.assignment_outlined,
                        title: "Raise\nComplaint",
                      ),
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: QuickActionCard(
                        icon: Icons.search,
                        title: "Track\nComplaint",
                      ),
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: QuickActionCard(
                        icon: Icons.description_outlined,
                        title: "My\nComplaints",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const BreakingNews(),
              const SizedBox(height: 18),
              const DashboardCard(),
              const SizedBox(height: 18),
              const TicketStatusCard(),
              const SizedBox(height: 18),
              const LatestUpdatesSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,

        elevation: 5,

        onPressed: () {
          // Raise complaint action
        },

        child: const Icon(Icons.add, color: Colors.white),
      ),

      bottomNavigationBar: HomeBottomNav(
        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
