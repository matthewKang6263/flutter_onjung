import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class SyncContactListPage extends StatefulWidget {
  final List<Contact> contacts; // 가져온 연락처 리스트를 전달받음

  const SyncContactListPage({super.key, required this.contacts});

  @override
  State<SyncContactListPage> createState() => _SyncContactListPageState();
}

class _SyncContactListPageState extends State<SyncContactListPage> {
  final Set<Contact> _selectedContacts = {}; // 선택된 연락처 저장

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '주소록 동기화',
          style: TextStyle(color: Colors.black),
        ),
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
            // 상단 정보 박스
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '추가 인원을 선택해주세요',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '신규 등록하는 온정인: ${widget.contacts.length}명',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const Text(
                    '중복 등록하는 온정인: 0명', // 중복 여부 체크는 추가 구현 가능
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
            // 연락처 리스트
            Expanded(
              child: ListView.builder(
                itemCount: widget.contacts.length,
                itemBuilder: (context, index) {
                  final contact = widget.contacts[index];
                  final isSelected = _selectedContacts.contains(contact);
                  return ListTile(
                    title: Text(contact.displayName ?? '이름 없음'),
                    subtitle: Text(contact.phones!.isNotEmpty
                        ? contact.phones!.first.value ?? ''
                        : '전화번호 없음'),
                    trailing: Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _selectedContacts.add(contact);
                          } else {
                            _selectedContacts.remove(contact);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            // 확인 버튼
            ElevatedButton(
              onPressed: () {
                // 선택된 연락처 반환
                Navigator.pop(context, _selectedContacts.toList());
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: Colors.black,
              ),
              child: const Text('확정', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
