// repositories/user_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_onjung/data/model/app_user.dart';

class UserRepository {
  final _firestore = FirebaseFirestore.instance;

  /// Firestore에 유저 정보 저장 (uid도 함께 저장)
  Future<void> createUser(AppUser user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'name': user.name,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('유저 생성 오류: $e');
    }
  }

  /// Firestore에서 유저 정보 가져오기
  Future<AppUser?> getUser(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return AppUser.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      print('유저 정보 가져오기 오류: $e');
      return null;
    }
  }
}
