import 'package:flutter/material.dart';

class SelectField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final List<String> items;

  const SelectField({
    super.key,
    required this.controller,
    required this.label,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: controller.text.isEmpty ? null : controller.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF338BEF)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          hint: Text(
            '예시) 용인 딥스테이션',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              controller.text = value;
            }
          },
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color.fromRGBO(181, 181, 181, 1),
            size: 20,
          ),
          dropdownColor: Colors.white,
          menuMaxHeight: 300,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ],
    );
  }
}
