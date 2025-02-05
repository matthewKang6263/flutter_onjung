import 'package:flutter/material.dart';

class DayBottomModal extends StatelessWidget {
  final DateTime date;

  const DayBottomModal({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${date.year}년 ${date.month}월 ${date.day}일',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '보냄: 4회 (40,000원)',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '받음: 3회 (30,000원)',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
