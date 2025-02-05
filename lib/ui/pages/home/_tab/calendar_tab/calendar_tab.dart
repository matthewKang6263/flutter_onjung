import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({super.key});

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // 두 개의 탭: 달력, 내역
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // 뒤로가기 버튼 비활성화
          title: const Text(
            '캘린더',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0, // 그림자 제거
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // 검색 기능 (구현 예정)
              },
            ),
            IconButton(
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.black),
              onPressed: () {
                // 알림 기능 (구현 예정)
              },
            ),
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                // 메뉴 기능 (구현 예정)
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: '달력'), // 달력 탭
              Tab(text: '내역'), // 내역 탭
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
            // 달력 탭 내용
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2099, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              headerVisible: false, // 헤더 숨김
              daysOfWeekVisible: true,
              calendarStyle: const CalendarStyle(
                defaultTextStyle: TextStyle(fontSize: 16),
                todayTextStyle: TextStyle(fontSize: 16, color: Colors.black),
                todayDecoration: BoxDecoration(), // 오늘 날짜의 기본 스타일 제거
                outsideDaysVisible: false,
              ),
            ),
            // 내역 탭 내용
            Center(
              child: Text(
                '내역 탭 내용 추가 예정',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
