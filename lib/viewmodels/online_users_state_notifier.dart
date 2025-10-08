import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

/// Gerencia a lista de usuários usando estado imutável.
/// Cada alteração gera uma nova lista, facilitando testes e evitando efeitos colaterais.
class OnlineUsersStateNotifier extends StateNotifier<List<User>> {
  OnlineUsersStateNotifier(UserRepository repo)
    : super(repo.fetchInitialUsers());

  /// Alterna o status online/offline de um usuário pelo [userId].
  /// A estratégia cria uma nova lista para manter a imutabilidade.
  void toggleStatus(String userId) {
    final updated = [
      for (final u in state)
        if (u.id == userId) u.copyWith(isOnline: !u.isOnline) else u,
    ];
    state = updated;
  }
}

/// Provider do repositório de usuários. Permite trocar facilmente a fonte de dados.
final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(),
);

/// Exponibiliza a lista de usuários e permite alternar status.
final onlineUsersNotifierProvider =
    StateNotifierProvider<OnlineUsersStateNotifier, List<User>>((ref) {
      final repo = ref.watch(userRepositoryProvider);
      return OnlineUsersStateNotifier(repo);
    });

/// Termo de busca digitado pelo usuário (case-insensitive).
final searchTermProvider = StateProvider<String>((_) => '');

/// Lista filtrada resultante de compor os filtros "somente online" e busca textual.
/// Ordem aplicada: 1) online somente (se ativo) 2) termo de busca.
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

/// Define se somente usuários online devem ser exibidos.
final showOnlyOnlineProvider = StateProvider<bool>((_) => false);
