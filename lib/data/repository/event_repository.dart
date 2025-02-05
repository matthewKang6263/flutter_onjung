// repositories/event_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_onjung/data/model/event.dart';

class EventRepository {
  final _firestore = FirebaseFirestore.instance;

  /// 경조사 내역 저장 (생성 또는 업데이트)
  Future<void> createOrUpdateEvent(EventRecord event) async {
    try {
      await _firestore.collection('events').doc(event.id).set(event.toJson());
    } catch (e) {
      print('경조사 내역 저장 오류: $e');
    }
  }

  /// 특정 경조사 내역 가져오기
  Future<EventRecord?> getEvent(String id) async {
    try {
      final doc = await _firestore.collection('events').doc(id).get();
      if (doc.exists) {
        return EventRecord.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      print('경조사 내역 가져오기 오류: $e');
      return null;
    }
  }

  /// 사용자 소유의 모든 경조사 내역 가져오기
  Future<List<EventRecord>> getEventsForUser(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('events')
          .where('userId', isEqualTo: userId)
          .get();
      return snapshot.docs
          .map((doc) => EventRecord.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('사용자 경조사 내역 가져오기 오류: $e');
      return [];
    }
  }

  /// 경조사 내역 삭제
  Future<void> deleteEvent(String id) async {
    try {
      await _firestore.collection('events').doc(id).delete();
    } catch (e) {
      print('경조사 내역 삭제 오류: $e');
    }
  }
}
