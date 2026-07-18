import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tvk_grievance/app/main_layout.dart';
import 'widgets/breaking_news.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/home_header.dart';
import 'widgets/latest_updates_section.dart';
import 'widgets/quick_action_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white),
    );
    return MainLayout(
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 90),
            child: Column(
              children: [
                const HomeHeader(),
                const BreakingNews(),
                const DashboardCard(),
                const SizedBox(height: 10),
                const LatestUpdatesSection(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: const [
                      Expanded(
                        child: QuickActionCard(
                          icon: "📝",
                          title: "Raise Grievance",
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: QuickActionCard(
                          icon: "📞",
                          title: "Dept. Contacts",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
