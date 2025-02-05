// repositories/contact_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_onjung/data/model/contact.dart';

class ContactRepository {
  final _firestore = FirebaseFirestore.instance;

  /// 연락처 저장 (생성 또는 업데이트)
  Future<void> createOrUpdateContact(Contact contact) async {
    try {
      await _firestore
          .collection('contacts')
          .doc(contact.id)
          .set(contact.toJson());
    } catch (e) {
      print('연락처 저장 오류: $e');
    }
  }

  /// 특정 연락처 가져오기
  Future<Contact?> getContact(String id) async {
    try {
      final doc = await _firestore.collection('contacts').doc(id).get();
      if (doc.exists) {
        return Contact.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      print('연락처 가져오기 오류: $e');
      return null;
    }
  }

  /// 사용자 소유의 모든 연락처 가져오기
  Future<List<Contact>> getContactsForUser(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('contacts')
          .where('userId', isEqualTo: userId)
          .get();
      return snapshot.docs.map((doc) => Contact.fromJson(doc.data())).toList();
    } catch (e) {
      print('사용자 연락처 가져오기 오류: $e');
      return [];
    }
  }

  /// 연락처 삭제
  Future<void> deleteContact(String id) async {
    try {
      await _firestore.collection('contacts').doc(id).delete();
    } catch (e) {
      print('연락처 삭제 오류: $e');
    }
  }
}
