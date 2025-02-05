import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contacts_service/contacts_service.dart';

/// 주소록 상태 클래스
class AddressState {
  final List<Contact> syncedContacts;
  final List<Contact> addedContacts;

  AddressState({
    this.syncedContacts = const [],
    this.addedContacts = const [],
  });

  AddressState copyWith({
    List<Contact>? syncedContacts,
    List<Contact>? addedContacts,
  }) {
    return AddressState(
      syncedContacts: syncedContacts ?? this.syncedContacts,
      addedContacts: addedContacts ?? this.addedContacts,
    );
  }
}

/// 상태 관리 클래스 (StateNotifier)
class AddressNotifier extends StateNotifier<AddressState> {
  AddressNotifier() : super(AddressState());

  /// 연락처 동기화 (핸드폰 주소록에서 가져오기)
  Future<void> syncContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    state = state.copyWith(syncedContacts: contacts.toList());
  }

  /// 선택한 연락처를 주소록에 추가
  void addContacts(List<Contact> selectedContacts) {
    state = state.copyWith(
      addedContacts: [...state.addedContacts, ...selectedContacts],
    );
  }
}

/// Riverpod Provider 설정
final addressProvider =
    StateNotifierProvider<AddressNotifier, AddressState>((ref) {
  return AddressNotifier();
});
