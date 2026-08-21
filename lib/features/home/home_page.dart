import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tvk_grievance/app/main_layout.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';

import 'home_providers.dart';
import 'widgets/breaking_news.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/home_header.dart';
import 'widgets/latest_updates_section.dart';
import 'widgets/quick_action_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final controller = ref.watch(
      homeControllerProvider,
    );

    final l10n = AppLocalizations.of(context)!;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
    );

    return MainLayout(
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              bottom: 90,
            ),
            child: Column(
              children: [
                const HomeHeader(),

                const BreakingNews(),

                const DashboardCard(),

                const SizedBox(height: 10),

                const LatestUpdatesSection(),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: QuickActionCard(
                          icon: "📝",
                          title: l10n.raiseGrievance,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: QuickActionCard(
                          icon: "📞",
                          title: l10n.deptContacts,
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
