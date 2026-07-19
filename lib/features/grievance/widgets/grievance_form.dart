import 'package:flutter/material.dart';

import 'package:tvk_grievance/app/widgets/header_text_widget.dart';
import 'package:tvk_grievance/features/grievance/grievance_controller.dart';
import 'package:tvk_grievance/features/grievance/widgets/category_card.dart';
import 'package:tvk_grievance/features/grievance/widgets/custom_drop_down_field.dart';
import 'package:tvk_grievance/features/grievance/widgets/custom_text_area.dart';

class GrievanceForm extends StatefulWidget {
  final GrievanceController controller;

  const GrievanceForm({super.key, required this.controller});

  @override
  State<GrievanceForm> createState() => _GrievanceFormState();
}

class _GrievanceFormState extends State<GrievanceForm> {
  final descriptionController = TextEditingController();
  final categories = [
    ("Water", "💧"),
    ("Roads", "🛣️"),
    ("Electricity", "💡"),
    ("Sanitation", "🗑️"),
  ];

  @override
  void dispose() {
    descriptionController.dispose();

    super.dispose();
  }

  void showMessage(BuildContext context, String message, bool success) {
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,

      builder: (_, __) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const HeaderTextWidget(text: "CHOOSE CATEGORY"),

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

              const HeaderTextWidget(text: "LOCATION DETAILS"),

              const SizedBox(height: 18),

              CustomDropdownField(
                label: "WARD",

                value: widget.controller.selectedWard,

                hint: "Select Ward",

                items: widget.controller.wards,

                onChanged: widget.controller.changeWard,
              ),

              const SizedBox(height: 16),

              CustomDropdownField(
                label: "AREA",

                value: widget.controller.selectedArea,

                hint: "Select Area",

                items: widget.controller.areas,

                onChanged: widget.controller.changeArea,
              ),

              const SizedBox(height: 16),

              CustomDropdownField(
                label: "STREET",

                value: widget.controller.selectedStreet,

                hint: "Select Street",

                items: widget.controller.streets,

                onChanged: widget.controller.changeStreet,
              ),

              const SizedBox(height: 28),

              const HeaderTextWidget(text: "DESCRIBE"),

              const SizedBox(height: 18),

              CustomTextArea(controller: descriptionController),

              const SizedBox(height: 30),

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
                    onPressed: () {
                      if (widget.controller.selectedCategory == null) {
                        showMessage(context, "Please choose category", false);

                        return;
                      }

                      if (widget.controller.selectedWard == null ||
                          widget.controller.selectedArea == null ||
                          widget.controller.selectedStreet == null) {
                        showMessage(
                          context,

                          "Please select location details",

                          false,
                        );

                        return;
                      }

                      // widget.controller.submitGrievance();

                      showMessage(
                        context,
                        "Grievance registered successfully",
                        true,
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,

                      elevation: 0,

                      shadowColor: Colors.transparent,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),

                    child: const Text(
                      "SUBMIT",

                      style: TextStyle(
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
