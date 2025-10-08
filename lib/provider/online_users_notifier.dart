import 'package:flutter/material.dart';
import '../models/user.dart';

/// Notificador (Provider) que gerencia lista mutável de usuários.
/// Inclui suporte a busca simples e alternância de status.
class OnlineUsersNotifier extends ChangeNotifier {
  final List<User> _users = [
    User(id: '1', name: 'Anninha', isOnline: true),
    User(id: '2', name: 'Guii'),
    User(id: '3', name: 'Enrique', isOnline: true),
    User(id: '4', name: 'Gigi'),
  ];

  String _searchTerm = '';

  List<User> get users => _users;
  String get searchTerm => _searchTerm;

  /// Lista derivada aplicando filtro de busca (case-insensitive) sobre [users].
  List<User> get filteredUsers {
    if (_searchTerm.isEmpty) return _users;
    final term = _searchTerm.toLowerCase();
    return _users.where((u) => u.name.toLowerCase().contains(term)).toList();
  }

  /// Atualiza o termo de busca e notifica listeners.
  void updateSearchTerm(String value) {
    _searchTerm = value;
    notifyListeners();
  }

  /// Alterna status online/offline do usuário identificado por [userId].
  void toggleStatus(String userId) {
    final user = _users.firstWhere((u) => u.id == userId);
    user.isOnline = !user.isOnline;
    notifyListeners();
  }
}
