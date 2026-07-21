import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(14),

        border: Border.all(
          color: Colors.black87,
          width: 1.5,
        ),

        boxShadow: const [
          BoxShadow(
            color: Color(0xffffc107),
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),

            decoration: BoxDecoration(
              color: const Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(6),
            ),

            child: Text(
              label,

              style: const TextStyle(
                color: Color(0xffA00037),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),


          const SizedBox(width: 12),


          Expanded(
            child: DropdownButtonHideUnderline(

              child: DropdownButton<String>(

                value: value,

                hint: Text(
                  hint,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),

                isExpanded: true,

                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xffA00037),
                ),


                items: items.map((item) {

                  return DropdownMenuItem<String>(

                    value: item,

                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                  );

                }).toList(),


                onChanged: onChanged,

              ),

            ),
          ),

        ],
      ),
    );
  }
}