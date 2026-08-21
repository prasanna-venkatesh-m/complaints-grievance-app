import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final String hint;
  final List<T> items;
  final String Function(T item) itemLabel;
  final ValueChanged<T?> onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.hint,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final int? selectedIndex = value == null
        ? null
        : items.indexWhere(
            (item) => item == value,
          );

    final int? validSelectedIndex =
        selectedIndex != null && selectedIndex >= 0
            ? selectedIndex
            : null;

    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
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
            offset: Offset(4, 4),
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
              child: DropdownButton<int>(
                value: validSelectedIndex,

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

                items: List.generate(
                  items.length,
                  (index) {
                    final item = items[index];

                    return DropdownMenuItem<int>(
                      value: index,
                      child: Text(
                        itemLabel(item),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),

                onChanged: (index) {
                  if (index == null) {
                    onChanged(null);
                    return;
                  }

                  if (index < 0 ||
                      index >= items.length) {
                    onChanged(null);
                    return;
                  }

                  onChanged(items[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String? value;
  final String hint;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.label,
    required this.value,
    required this.hint,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
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
            offset: Offset(4, 4),
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
            child: TextField(
              controller: TextEditingController(
                text: value,
              )..selection = TextSelection.collapsed(
                  offset: value?.length ?? 0,
                ),
              onChanged: onChanged,
              keyboardType: keyboardType,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}