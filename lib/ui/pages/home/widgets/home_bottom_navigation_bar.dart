import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      iconSize: 28,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      selectedItemColor: const Color(0xFF0770E9),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: "홈",
          tooltip: "홈",
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person_2),
          activeIcon: Icon(CupertinoIcons.person_2_fill),
          label: "주소록",
          tooltip: "주소록",
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.calendar),
          activeIcon: Icon(CupertinoIcons.calendar), // 변경된 부분
          label: "캘린더",
          tooltip: "캘린더",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          activeIcon: Icon(Icons.favorite),
          label: "온정",
          tooltip: "온정",
        ),
      ],
    );
  }
}
