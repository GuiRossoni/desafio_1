import '../models/user.dart';

/// Repositório responsável por fornecer a lista inicial de usuários.
/// Em produção poderia consultar API ou banco local.
class UserRepository {
  /// Retorna a lista inicial (mock).
  List<User> fetchInitialUsers() => [
    User(id: '1', name: 'Anninha', isOnline: true),
    User(id: '2', name: 'Guii'),
    User(id: '3', name: 'Enrique', isOnline: true),
    User(id: '4', name: 'Gigi'),
  ];
}
