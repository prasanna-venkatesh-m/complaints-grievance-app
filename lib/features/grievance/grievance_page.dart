import 'package:flutter/material.dart';
import 'package:tvk_grievance/app/main_layout.dart';
import 'package:tvk_grievance/app/widgets/tvk_quote_widget.dart';
import 'package:tvk_grievance/features/grievance/grievance_controller.dart';
import 'package:tvk_grievance/features/grievance/grievance_model.dart';
import 'package:tvk_grievance/features/grievance/grievance_repository.dart';
import 'package:tvk_grievance/features/grievance/widgets/grievance_form.dart';
import 'package:tvk_grievance/features/grievance/widgets/grievance_header.dart';
import 'package:tvk_grievance/features/grievance/widgets/grievance_list.dart';
import 'package:tvk_grievance/features/grievance/widgets/grievance_toggle.dart';

class GrievancePage extends StatefulWidget {
  const GrievancePage({super.key});

  @override
  State<GrievancePage> createState() => _GrievancePageState();
}

class _GrievancePageState extends State<GrievancePage> {
  late GrievanceController controller;

  @override
  void initState() {
    super.initState();

    controller = GrievanceController(GrievanceRepository());

    controller.loadGrievances();
    controller.loadDropdowns();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: SafeArea(
        child: Scaffold(
          body: ListenableBuilder(
            listenable: controller,
            builder: (_, __) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    GrievanceHeader(),
                    TVKQuoteWidget(),
                    const SizedBox(height: 10),
                    GrievanceToggle(
                      selectedTab: controller.selectedTab,
                      onChanged: controller.changeTab,
                    ),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: controller.selectedTab == GrievanceTab.fileNew
                          ? GrievanceForm(
                              key: const ValueKey("form"),
                              controller: controller,
                            )
                          : GrievanceList(
                              key: const ValueKey("list"),
                              grievances: controller.grievances,
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
