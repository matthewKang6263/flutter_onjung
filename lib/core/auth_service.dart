// auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_onjung/data/model/app_user.dart';
import 'package:flutter_onjung/data/repository/user_repositry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository _userRepository = UserRepository();

  /// 회원가입: Firebase Auth에 사용자 생성 후 Firestore에 사용자 정보 저장
  Future<AppUser?> signUp(String email, String password, String name) async {
    try {
      // Firebase Auth에 사용자 생성
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        // 생성된 사용자의 UID를 포함한 AppUser 객체 생성
        final newUser = AppUser(
          uid: userCredential.user!.uid,
          email: email,
          name: name,
        );
        // Firestore에 사용자 정보 저장 (uid도 저장됨)
        await _userRepository.createUser(newUser);
        return newUser;
      }
      return null;
    } catch (e) {
      print('회원가입 오류: $e');
      return null;
    }
  }

  /// 로그인: Firebase Auth로 로그인 후, Firestore에서 사용자 정보 가져오기
  Future<AppUser?> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return await _userRepository.getUser(userCredential.user!.uid);
      }
      return null;
    } catch (e) {
      print('로그인 오류: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
