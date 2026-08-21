import 'package:flutter/material.dart';

import 'package:tvk_grievance/app/widgets/header_text_widget.dart';
import 'package:tvk_grievance/features/grievance/grievance_controller.dart';
import 'package:tvk_grievance/features/grievance/grievance_model.dart';
import 'package:tvk_grievance/features/grievance/widgets/category_card.dart';
import 'package:tvk_grievance/features/grievance/widgets/custom_drop_down_field.dart';
import 'package:tvk_grievance/features/grievance/widgets/custom_text_area.dart';
import 'package:tvk_grievance/features/grievance/widgets/grievance_media_section.dart';
import 'package:tvk_grievance/features/location_picker/widgets/location_map.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';

class GrievanceForm extends StatefulWidget {
  final GrievanceController controller;

  // Logged-in user's ID from local storage.
  final String userId;

  const GrievanceForm({
    super.key,
    required this.controller,
    required this.userId,
  });

  @override
  State<GrievanceForm> createState() => _GrievanceFormState();
}

class _GrievanceFormState extends State<GrievanceForm> {
  final TextEditingController descriptionController = TextEditingController();

  final List<(String, String)> categories = [
    ('Water', '💧'),
    ('Roads', '🛣️'),
    ('Electricity', '💡'),
    ('Sanitation', '🗑️'),
  ];

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void showMessage(BuildContext context, String message, bool success) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        backgroundColor: success
            ? const Color(0xff2E7D32)
            : const Color(0xffC62828),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: Row(
          children: [
            Icon(
              success ? Icons.check_circle : Icons.error,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final controller = widget.controller;
    final l10n = AppLocalizations.of(context)!;

    if (controller.selectedCategory == null) {
      showMessage(context, l10n.please_choose_category, false);
      return;
    }

    if (controller.selectedWard == null) {
      showMessage(context, l10n.select_location_details, false);
      return;
    }

    final area = controller.selectedArea?.trim() ?? '';
    final street = controller.selectedStreet?.trim() ?? '';
    final description = descriptionController.text.trim();

    if (area.isEmpty || street.isEmpty) {
      showMessage(context, l10n.select_location_details, false);
      return;
    }

    if (description.isEmpty) {
      showMessage(context, 'Please enter a description.', false);
      return;
    }

    if (controller.isSubmittingGrievance) {
      return;
    }

    final success = await controller.submitGrievance(
      userId: widget.userId,
      description: description,
    );

    if (!mounted) {
      return;
    }

    if (success) {
      descriptionController.clear();

      controller.clearGrievanceForm();

      await controller.refreshGrievances(userId: widget.userId);

      if (!mounted) {
        return;
      }

      showMessage(context, l10n.grievance_registered_successfully, true);
    } else {
      showMessage(
        context,
        controller.submitGrievanceErrorMessage ??
            'Unable to submit grievance. Please try again.',
        false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (_, __) {
        final isSubmitting = widget.controller.isSubmittingGrievance;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTextWidget(text: l10n.chooseCategory),

              const SizedBox(height: 18),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 1.4,
                ),
                itemBuilder: (_, index) {
                  return CategoryCard(
                    title: categories[index].$1,
                    emoji: categories[index].$2,
                    selected: widget.controller.selectedCategory == index,
                    onTap: () {
                      widget.controller.selectCategory(index);
                    },
                  );
                },
              ),

              const SizedBox(height: 28),

              HeaderTextWidget(text: l10n.locationDetails),

              const SizedBox(height: 18),

              // ==================================================
              // WARD
              // ==================================================
              CustomDropdownField<WardModel>(
                label: l10n.ward,
                value: widget.controller.selectedWard,
                hint: l10n.selectWard,
                items: widget.controller.wards,
                itemLabel: (ward) => ward.displayName,
                onChanged: widget.controller.changeWard,
              ),

              const SizedBox(height: 16),

              // ==================================================
              // AREA - FREE TEXT
              // ==================================================
              CustomTextField(
                label: l10n.area,
                value: widget.controller.selectedArea,
                hint: l10n.selectArea,
                onChanged: widget.controller.changeAreaText,
              ),

              const SizedBox(height: 16),

              // ==================================================
              // STREET - FREE TEXT
              // ==================================================
              CustomTextField(
                label: l10n.street,
                value: widget.controller.selectedStreet,
                hint: l10n.selectStreet,
                onChanged: widget.controller.changeStreetText,
              ),

              const SizedBox(height: 16),

              // ==================================================
              // LOCATION
              // ==================================================
              SizedBox(
                height: 450,
                child: LocationMap(
                  onLocationSelected: (location) {
                    widget.controller.setLocation(location);

                    showMessage(
                      context,
                      'Location selected successfully',
                      true,
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // DESCRIPTION
              // ==================================================
              HeaderTextWidget(text: l10n.describe),

              const SizedBox(height: 18),

              CustomTextArea(controller: descriptionController),

              const SizedBox(height: 30),

              // ==================================================
              // ATTACHMENTS
              // ==================================================
              HeaderTextWidget(text: l10n.uploadEvidence),

              const SizedBox(height: 18),

              GrievanceMediaSection(controller: widget.controller),

              const SizedBox(height: 30),

              // ==================================================
              // SUBMIT
              // ==================================================
              SizedBox(
                width: double.infinity,
                height: 58,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffA00037),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.black87, width: 1.5),
                    boxShadow: const [
                      BoxShadow(color: Color(0xffffc107), offset: Offset(4, 4)),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: isSubmitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: isSubmitting
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            l10n.submit,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
