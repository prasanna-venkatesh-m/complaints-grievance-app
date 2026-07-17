import 'package:flutter/material.dart';
import 'package:tvk_grievance/app/main_layout.dart';
import 'package:tvk_grievance/app/widgets/tvk_quote_widget.dart';
import 'package:tvk_grievance/features/helpdesk/helpdesk_controller.dart';
import 'package:tvk_grievance/features/helpdesk/helpdesk_repository.dart';
import 'package:tvk_grievance/features/helpdesk/widgets/contact_card.dart';
import 'package:tvk_grievance/features/helpdesk/widgets/helpdesk_header.dart';
class HelpDeskPage extends StatefulWidget {
  const HelpDeskPage({super.key});

  @override
  State<HelpDeskPage> createState() => _HelpDeskPageState();
}

class _HelpDeskPageState extends State<HelpDeskPage> {
  late HelpdeskController controller;

  @override
  void initState() {
    super.initState();

    controller = HelpdeskController(
      HelpdeskRepository(),
    );

    controller.loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: SafeArea(
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 90),
                child: Column(
                  children: [
                    const HelpDeskHeader(),
                    TVKQuoteWidget(),
                    const SizedBox(height: 12),

                    ListView.separated(
                      itemCount: controller.contacts.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return ContactCard(
                          contact: controller.contacts[index],
                        );
                      },
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