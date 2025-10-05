import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

class OnlineUsersStateNotifier extends StateNotifier<List<User>> {
  OnlineUsersStateNotifier()
    : super([
        User(id: '1', name: 'Alice', isOnline: true),
        User(id: '2', name: 'Bob'),
        User(id: '3', name: 'Charlie', isOnline: true),
        User(id: '4', name: 'Diana'),
      ]);

  void toggleStatus(String userId) {
    final newUsers = [...state];
    final idx = newUsers.indexWhere((u) => u.id == userId);
    if (idx == -1) return;
    final user = newUsers[idx];
    newUsers[idx] = user.copyWith(isOnline: !user.isOnline);
    state = newUsers;
  }
}

final onlineUsersNotifierProvider =
    StateNotifierProvider<OnlineUsersStateNotifier, List<User>>(
      (ref) => OnlineUsersStateNotifier(),
    );
