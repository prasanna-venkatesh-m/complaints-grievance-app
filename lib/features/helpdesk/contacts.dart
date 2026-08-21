import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tvk_grievance/app/main_layout.dart';
import 'package:tvk_grievance/app/widgets/tvk_quote_widget.dart';
import 'package:tvk_grievance/features/helpdesk/helpdesk_controller.dart';
import 'package:tvk_grievance/features/helpdesk/helpdesk_providers.dart';
import 'package:tvk_grievance/features/helpdesk/widgets/contact_card.dart';
import 'package:tvk_grievance/features/helpdesk/widgets/helpdesk_card_shimmer.dart';
import 'package:tvk_grievance/features/helpdesk/widgets/helpdesk_header.dart';

class HelpDeskPage extends ConsumerStatefulWidget {
  const HelpDeskPage({super.key});

  @override
  ConsumerState<HelpDeskPage> createState() =>
      _HelpDeskPageState();
}

class _HelpDeskPageState extends ConsumerState<HelpDeskPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(helpdeskControllerProvider)
          .loadContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        ref.watch(helpdeskControllerProvider);

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
                // -----------------------------
                // STATIC UI
                // -----------------------------

                const HelpDeskHeader(),

                TVKQuoteWidget(),

                const SizedBox(height: 12),

                // -----------------------------
                // API / DYNAMIC UI
                // -----------------------------

                _buildContactSection(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection(
    HelpdeskController controller,
  ) {
    // ----------------------------------------
    // LOADING
    // ----------------------------------------

    if (controller.isLoading) {
      return ListView.separated(
        itemCount: 5,
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        separatorBuilder: (_, __) =>
            const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return const HelpdeskCardShimmer();
        },
      );
    }

    // ----------------------------------------
    // ERROR
    // ----------------------------------------

    if (controller.errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 40,
        ),
        child: Column(
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.redAccent,
            ),

            const SizedBox(height: 12),

            Text(
              controller.errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                ref
                    .read(helpdeskControllerProvider)
                    .loadContacts();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    // ----------------------------------------
    // EMPTY
    // ----------------------------------------

    if (controller.contacts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 40,
        ),
        child: Column(
          children: [
            Icon(
              Icons.contact_support_outlined,
              size: 48,
              color: Colors.black45,
            ),

            SizedBox(height: 12),

            Text(
              'No helpdesk contacts available',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      );
    }

    // ----------------------------------------
    // SUCCESS
    // ----------------------------------------

    return ListView.separated(
      itemCount: controller.contacts.length,
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      separatorBuilder: (_, __) =>
          const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return ContactCard(
          contact: controller.contacts[index],
        );
      },
    );
  }
} 