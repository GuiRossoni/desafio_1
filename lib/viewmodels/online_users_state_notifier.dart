import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class OnlineUsersStateNotifier extends StateNotifier<List<User>> {
  OnlineUsersStateNotifier(UserRepository repo)
    : super(repo.fetchInitialUsers());

  void toggleStatus(String userId) {
    final updated = [
      for (final u in state)
        if (u.id == userId) u.copyWith(isOnline: !u.isOnline) else u,
    ];
    state = updated;
  }
}

// Provider do repositório
final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(),
);

// Notifier principal de usuários
final onlineUsersNotifierProvider =
    StateNotifierProvider<OnlineUsersStateNotifier, List<User>>((ref) {
      final repo = ref.watch(userRepositoryProvider);
      return OnlineUsersStateNotifier(repo);
    });

// Provider para termo de busca (estado simples)
final searchTermProvider = StateProvider<String>((_) => '');

// Provider derivado (lista filtrada)
final filteredUsersProvider = Provider<List<User>>((ref) {
  final term = ref.watch(searchTermProvider).toLowerCase();
  final onlyOnline = ref.watch(showOnlyOnlineProvider);
  final users = ref.watch(onlineUsersNotifierProvider);
  Iterable<User> filtered = users;
  if (onlyOnline) {
    filtered = filtered.where((u) => u.isOnline);
  }
  if (term.isNotEmpty) {
    filtered = filtered.where((u) => u.name.toLowerCase().contains(term));
  }
  return filtered.toList();
});

// Provider para controlar exibição somente online
final showOnlyOnlineProvider = StateProvider<bool>((_) => false);
