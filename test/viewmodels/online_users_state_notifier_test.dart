import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:desafio_1/viewmodels/online_users_state_notifier.dart';
import 'package:desafio_1/repositories/user_repository.dart';

void main() {
  group('OnlineUsersStateNotifier busca e filtragem', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [userRepositoryProvider.overrideWithValue(UserRepository())],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('Lista inicial contém 4 usuários', () {
      final users = container.read(onlineUsersNotifierProvider);
      expect(users.length, 4);
    });

    test('Filtra por termo parcial (case insensitive)', () {
      // Buscar por "gi" deve retornar Guii e Gigi
      container.read(searchTermProvider.notifier).state = 'gi';
      final filtered = container.read(filteredUsersProvider);
      final names = filtered.map((u) => u.name).toList();
      expect(names, containsAll(['Guii', 'Gigi']));
      expect(names.any((n) => n == 'Chiara'), false);
    });

    test('Filtra termo sem resultados', () {
      container.read(searchTermProvider.notifier).state = 'zzz';
      final filtered = container.read(filteredUsersProvider);
      expect(filtered, isEmpty);
    });

    test('toggleStatus altera estado sem afetar filtro', () {
      container.read(searchTermProvider.notifier).state = 'ann';
      final before = container.read(filteredUsersProvider);
      expect(before.single.name, 'Anninha');
      final notifier = container.read(onlineUsersNotifierProvider.notifier);
      notifier.toggleStatus(before.single.id);
      final after = container.read(filteredUsersProvider);
      expect(after.single.isOnline, !before.single.isOnline);
    });
  });
}
