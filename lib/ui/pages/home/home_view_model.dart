import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends StateNotifier<int> {
  HomeViewModel() : super(0); // 첫 번째 탭(홈)이 기본값

  void onIndexChanged(int newIndex) {
    state = newIndex; // 새로운 인덱스로 변경
  }
}

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, int>((ref) {
  return HomeViewModel();
});
