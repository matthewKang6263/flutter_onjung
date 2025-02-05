import 'package:flutter/material.dart';
import 'package:flutter_onjung/ui/pages/tab/address_tab/manual_contact_add_page/manual_register_step_3.dart';

class ManualRegisterStep2 extends StatelessWidget {
  final String name;
  final String phone;

  const ManualRegisterStep2(
      {super.key, required this.name, required this.phone});

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();

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
            const LinearProgressIndicator(value: 2 / 3, color: Colors.black),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  selectedDate = pickedDate;
                }
              },
              child: const Text('생일 선택'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManualRegisterStep3(
                      name: name,
                      birthday: selectedDate,
                    ),
                  ),
                );
              },
              child: const Text('다음'),
            ),
          ],
        ),
      ),
    );
  }
}
