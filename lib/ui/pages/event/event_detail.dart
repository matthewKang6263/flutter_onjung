import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  final String eventId; // 선택한 경조사 내역의 ID (또는 다른 식별자)

  const EventDetailPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('경조사 내역 상세', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Text('Event Detail for $eventId'),
      ),
    );
  }
}
