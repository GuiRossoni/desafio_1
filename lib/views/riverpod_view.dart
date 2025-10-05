import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/online_users_state_notifier.dart';
import '../widgets/user_tile.dart';

class RiverpodView extends ConsumerWidget {
  const RiverpodView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(filteredUsersProvider);
    final searchTerm = ref.watch(searchTermProvider);
    final showOnlyOnline = ref.watch(showOnlyOnlineProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lista de Usuários (Riverpod)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Buscar usuário',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) =>
              ref.read(searchTermProvider.notifier).state = value,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text('Somente online'),
            const SizedBox(width: 8),
            Switch(
              value: showOnlyOnline,
              onChanged: (val) =>
                  ref.read(showOnlyOnlineProvider.notifier).state = val,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return UserTile(
                user: user,
                onTap: () => ref
                    .read(onlineUsersNotifierProvider.notifier)
                    .toggleStatus(user.id),
              );
            },
          ),
        ),
        if (users.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Nenhum resultado para "$searchTerm"',
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ),
      ],
    );
  }
}
