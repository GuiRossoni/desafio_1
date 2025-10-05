class User {
  final String id;
  final String name;
  bool isOnline;

  User({required this.id, required this.name, this.isOnline = false});

  User copyWith({String? id, String? name, bool? isOnline}) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    isOnline: isOnline ?? this.isOnline,
  );
}
