import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_onjung/core/auth_service.dart';
import 'package:flutter_onjung/data/model/app_user.dart';

// LoginViewModel
class LoginViewModel extends StateNotifier<AsyncValue<AppUser?>> {
  final AuthService _authService;

  LoginViewModel(this._authService) : super(const AsyncValue.data(null));

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _authService.signIn(email, password);
      if (user != null) {
        state = AsyncValue.data(user);
      } else {
        state = AsyncValue.error('로그인 실패', StackTrace.current);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AsyncValue<AppUser?>>((ref) {
  final authService = ref.read(authServiceProvider);
  return LoginViewModel(authService);
});
