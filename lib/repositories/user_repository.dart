import '../models/user.dart';

class UserRepository {
  List<User> fetchInitialUsers() => [
    User(id: '1', name: 'Anninha', isOnline: true),
    User(id: '2', name: 'Guii'),
    User(id: '3', name: 'Chiara', isOnline: true),
    User(id: '4', name: 'Gigi'),
  ];
}
