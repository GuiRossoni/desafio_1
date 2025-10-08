import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/online_users_notifier.dart';
import '../widgets/user_tile.dart';

/// View (Provider) demonstrando busca + filtro local "somente online".
/// Mantém estado interno (_onlyOnline) e delega busca ao notifier.

class ProviderView extends StatefulWidget {
  const ProviderView({super.key});

  @override
  State<ProviderView> createState() => _ProviderViewState();
}

class _ProviderViewState extends State<ProviderView> {
  bool _onlyOnline = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<OnlineUsersNotifier>(
      builder: (context, onlineUsers, child) {
        final list = _onlyOnline
            ? onlineUsers.filteredUsers.where((u) => u.isOnline).toList()
            : onlineUsers.filteredUsers;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lista de Usuários (Provider)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar usuário',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: onlineUsers.updateSearchTerm,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Somente online'),
                const SizedBox(width: 8),
                Switch(
                  value: _onlyOnline,
                  onChanged: (v) => setState(() => _onlyOnline = v),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final user = list[index];
                  return UserTile(
                    user: user,
                    onTap: () => onlineUsers.toggleStatus(user.id),
                  );
                },
              ),
            ),
            if (list.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Nenhum resultado',
                  style: const TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
