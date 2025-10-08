import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

/// Versão inicial do `OnlineUsersStateNotifier` antes da refatoração para
/// a pasta `viewmodels/`. Mantida apenas para referência histórica ou comparação.
class OnlineUsersStateNotifier extends StateNotifier<List<User>> {
  /// Inicializa com uma lista estática de usuários (imutabilidade por cópia de lista).
  OnlineUsersStateNotifier()
    : super([
        User(id: '1', name: 'Anninha', isOnline: true),
        User(id: '2', name: 'Guii'),
        User(id: '3', name: 'Enrique', isOnline: true),
        User(id: '4', name: 'Gigi'),
      ]);

  /// Alterna o status online/offline recriando a lista (boa prática para StateNotifier).
  void toggleStatus(String userId) {
    final newUsers = [...state];
    final idx = newUsers.indexWhere((u) => u.id == userId);
    if (idx == -1) return;
    final user = newUsers[idx];
    newUsers[idx] = user.copyWith(isOnline: !user.isOnline);
    state = newUsers;
  }
}

/// Provider legacy correspondente.
final onlineUsersNotifierProvider =
    StateNotifierProvider<OnlineUsersStateNotifier, List<User>>(
      (ref) => OnlineUsersStateNotifier(),
    );
