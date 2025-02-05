// join_view_model.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_onjung/core/auth_service.dart';
import 'package:flutter_onjung/data/model/app_user.dart';

class JoinViewModel extends StateNotifier<AsyncValue<AppUser?>> {
  final AuthService _authService;

  JoinViewModel(this._authService) : super(const AsyncValue.data(null));

  Future<void> signUp(String email, String password, String name) async {
    state = const AsyncValue.loading();
    try {
      final user = await _authService.signUp(email, password, name);
      if (user != null) {
        state = AsyncValue.data(user);
      } else {
        state = AsyncValue.error('회원가입 실패', StackTrace.current);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final joinViewModelProvider =
    StateNotifierProvider<JoinViewModel, AsyncValue<AppUser?>>((ref) {
  final authService = ref.watch(authServiceProvider);
  return JoinViewModel(authService);
});
