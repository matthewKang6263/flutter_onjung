import 'package:flutter/material.dart';
import 'package:flutter_onjung/ui/pages/tab/address_tab/add_contact_page.dart';
import 'package:flutter_onjung/ui/pages/tab/address_tab/address_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressTab extends ConsumerWidget {
  const AddressTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressState = ref.watch(addressProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            '주소록',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: '개인'),
              Tab(text: '그룹'),
            ],
            labelColor: Colors.black, // 선택된 탭 텍스트 색상
            unselectedLabelColor: Colors.black54, // 선택되지 않은 탭 텍스트 색상
            indicatorColor: Colors.black, // 인디케이터 색상
            indicatorWeight: 3, // 인디케이터 두께
            indicatorSize: TabBarIndicatorSize.tab, // 탭의 전체 길이 사용
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: addressState.addedContacts.length,
              itemBuilder: (context, index) {
                final contact = addressState.addedContacts[index];
                return ListTile(
                  title: Text(contact.displayName ?? '이름 없음'),
                  subtitle: Text(contact.phones?.isNotEmpty == true
                      ? contact.phones!.first.value ?? ''
                      : '전화번호 없음'),
                );
              },
            ),
            const Center(child: Text('그룹 연락처 리스트')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddContactPage()),
            );
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
