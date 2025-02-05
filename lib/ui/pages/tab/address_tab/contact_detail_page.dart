// screens/address/contact_detail_page.dart
import 'package:flutter/material.dart';

class AddressDetailPage extends StatefulWidget {
  final String name;

  const AddressDetailPage({super.key, required this.name});

  @override
  State<AddressDetailPage> createState() => _AddressDetailPageState();
}

class _AddressDetailPageState extends State<AddressDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name, style: const TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.black,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: '프로필'),
              Tab(text: '경조사 내역'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(child: Text('${widget.name}의 프로필 상세정보')),
                Center(child: Text('${widget.name}과 주고받은 경조사 내역')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
