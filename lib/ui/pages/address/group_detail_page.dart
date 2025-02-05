import 'package:flutter/material.dart';

class GroupDetailPage extends StatefulWidget {
  final String groupName;

  const GroupDetailPage({super.key, required this.groupName});

  @override
  State<GroupDetailPage> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // 두 탭: 그룹 프로필, 경조사 내역
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
        title:
            Text(widget.groupName, style: const TextStyle(color: Colors.black)),
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
              Tab(text: '그룹 프로필'),
              Tab(text: '경조사 내역'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 그룹 프로필 탭 (예시)
                Center(child: Text('${widget.groupName}의 프로필')),
                // 경조사 내역 탭 (예시)
                Center(child: Text('${widget.groupName}과 주고받은 경조사 내역')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
