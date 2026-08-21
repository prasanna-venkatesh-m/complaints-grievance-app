import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tvk_grievance/app/main_layout.dart';
import 'package:tvk_grievance/app/widgets/tvk_quote_widget.dart';
import 'package:tvk_grievance/features/grievance/grievance_providers.dart';
import 'package:tvk_grievance/features/grievance/widgets/grievance_form.dart';
import 'package:tvk_grievance/features/grievance/widgets/grievance_header.dart';
import 'package:tvk_grievance/features/grievance/widgets/grievance_list.dart';
import 'package:tvk_grievance/features/grievance/widgets/grievance_toggle.dart';
import 'package:tvk_grievance/features/grievance/grievance_model.dart';

class GrievancePage extends ConsumerStatefulWidget {
  const GrievancePage({super.key});

  @override
  ConsumerState<GrievancePage> createState() =>
      _GrievancePageState();
}

class _GrievancePageState
    extends ConsumerState<GrievancePage> {
  static const String _userId =
      '6a8733a429a6a5514344e183';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller =
          ref.read(grievanceControllerProvider);

      controller.loadGrievances(
        userId: _userId,
      );

      // Load only the Ward API.
      controller.loadWards();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        ref.watch(grievanceControllerProvider);

    return MainLayout(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
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
                  duration:
                      const Duration(milliseconds: 300),
                  child: controller.selectedTab ==
                          GrievanceTab.fileNew
                      ? GrievanceForm(
                          key: const ValueKey('form'),
                          controller: controller,
                          userId: _userId,
                        )
                      : GrievanceList(
                          key: const ValueKey('list'),
                          grievances:
                              controller.grievances,
                          isLoading:
                              controller.isLoadingGrievances,
                          errorMessage:
                              controller.grievanceErrorMessage,
                          onRetry: () {
                            controller.loadGrievances(
                              userId: _userId,
                            );
                          },
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