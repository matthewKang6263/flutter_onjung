// models/group.dart
class Group {
  final String id;
  final String userId; // 그룹 생성자(사용자)의 uid
  final String groupName;
  final String? description;
  final List<String>? contactIds; // 그룹에 포함된 연락처 ID 목록

  Group({
    required this.id,
    required this.userId,
    required this.groupName,
    this.description,
    this.contactIds,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      userId: json['userId'],
      groupName: json['groupName'],
      description: json['description'],
      contactIds: (json['contactIds'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'groupName': groupName,
      'description': description,
      'contactIds': contactIds,
    };
  }
}
