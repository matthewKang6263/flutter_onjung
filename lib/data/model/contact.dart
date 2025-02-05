// models/contact.dart
class Contact {
  final String id;
  final String name;
  final String phone;
  final String? relationshipType; // 가족, 친척, 친구, 지인, 직장, 기타
  final String? relationshipDetail; // 예: 아버지
  final String? solarBirthday; // 양력 생일 (YYYY-MM-DD)
  final String? lunarBirthday; // 음력 생일
  final List<Map<String, String>>? anniversaries; // 기념일 목록
  final List<String>? groupIds; // 이 연락처가 속한 그룹 ID 목록
  final String userId; // 해당 연락처를 등록한 사용자의 uid

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.userId,
    this.relationshipType,
    this.relationshipDetail,
    this.solarBirthday,
    this.lunarBirthday,
    this.anniversaries,
    this.groupIds,
  });

  // JSON 변환 메서드 (옵션)
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      userId: json['userId'],
      relationshipType: json['relationshipType'],
      relationshipDetail: json['relationshipDetail'],
      solarBirthday: json['solarBirthday'],
      lunarBirthday: json['lunarBirthday'],
      anniversaries: (json['anniversaries'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e))
          .toList(),
      groupIds: (json['groupIds'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'userId': userId,
      'relationshipType': relationshipType,
      'relationshipDetail': relationshipDetail,
      'solarBirthday': solarBirthday,
      'lunarBirthday': lunarBirthday,
      'anniversaries': anniversaries,
      'groupIds': groupIds,
    };
  }
}
