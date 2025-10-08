/// Modelo de domínio que representa um usuário da aplicação.
/// Mantém apenas dados. A mutabilidade controlada
/// do campo [isOnline] é útil na versão Provider que altera diretamente o objeto.
class User {
  final String id;
  final String name;
  bool isOnline;

  /// Cria um [User]. Por padrão inicia offline.
  User({required this.id, required this.name, this.isOnline = false});

  /// Retorna uma nova instância copiando valores, permitindo sobrepor campos.
  User copyWith({String? id, String? name, bool? isOnline}) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    isOnline: isOnline ?? this.isOnline,
  );
}
