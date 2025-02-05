// models/event_record.dart
class EventRecord {
  final String id;
  final String userId; // 이벤트 등록한 사용자 uid
  final String direction; // "sent" 또는 "received"
  final String targetType; // "contact" 또는 "group"
  final String targetId; // 대상 연락처 또는 그룹의 ID
  final int amount;
  final String eventType; // 경조사 종류 (결혼식, 돌잔치, 장례식, 생일, 명절, 개업, 기타)
  final String date; // YYYY-MM-DD
  final bool visited;
  final Map<String, dynamic>? gift; // 예: {"amount": 30000, "detail": "선물 설명"}
  final String? memo;

  EventRecord({
    required this.id,
    required this.userId,
    required this.direction,
    required this.targetType,
    required this.targetId,
    required this.amount,
    required this.eventType,
    required this.date,
    required this.visited,
    this.gift,
    this.memo,
  });

  factory EventRecord.fromJson(Map<String, dynamic> json) {
    return EventRecord(
      id: json['id'],
      userId: json['userId'],
      direction: json['direction'],
      targetType: json['targetType'],
      targetId: json['targetId'],
      amount: json['amount'],
      eventType: json['eventType'],
      date: json['date'],
      visited: json['visited'],
      gift: json['gift'],
      memo: json['memo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'direction': direction,
      'targetType': targetType,
      'targetId': targetId,
      'amount': amount,
      'eventType': eventType,
      'date': date,
      'visited': visited,
      'gift': gift,
      'memo': memo,
    };
  }
}
