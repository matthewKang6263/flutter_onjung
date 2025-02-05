import 'package:flutter/material.dart';

class ManualRegisterStep3 extends StatelessWidget {
  final String name;
  final DateTime birthday;

  const ManualRegisterStep3(
      {super.key, required this.name, required this.birthday});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('인원 추가', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const LinearProgressIndicator(value: 3 / 3, color: Colors.black),
            const SizedBox(height: 16),
            const Text('관계를 선택하세요'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('추가 완료'),
                        ElevatedButton(
                          onPressed: () => Navigator.popUntil(
                              context, (route) => route.isFirst),
                          child: const Text('돌아가기'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('완료'),
            ),
          ],
        ),
      ),
    );
  }
}
