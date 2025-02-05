// repositories/group_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_onjung/data/model/group.dart';

class GroupRepository {
  final _firestore = FirebaseFirestore.instance;

  /// 그룹 저장 (생성 또는 업데이트)
  Future<void> createOrUpdateGroup(Group group) async {
    try {
      await _firestore.collection('groups').doc(group.id).set(group.toJson());
    } catch (e) {
      print('그룹 저장 오류: $e');
    }
  }

  /// 특정 그룹 가져오기
  Future<Group?> getGroup(String id) async {
    try {
      final doc = await _firestore.collection('groups').doc(id).get();
      if (doc.exists) {
        return Group.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      print('그룹 가져오기 오류: $e');
      return null;
    }
  }

  /// 사용자 소유의 모든 그룹 가져오기
  Future<List<Group>> getGroupsForUser(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('groups')
          .where('userId', isEqualTo: userId)
          .get();
      return snapshot.docs.map((doc) => Group.fromJson(doc.data())).toList();
    } catch (e) {
      print('사용자 그룹 가져오기 오류: $e');
      return [];
    }
  }

  /// 그룹 삭제
  Future<void> deleteGroup(String id) async {
    try {
      await _firestore.collection('groups').doc(id).delete();
    } catch (e) {
      print('그룹 삭제 오류: $e');
    }
  }
}
