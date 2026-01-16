class UserModel {
  final int? id;
  final String name;
  final String email;

  UserModel({
    this.id,
    required this.name,
    required this.email,
  });

  // Convert object → Map (for database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  // Convert Map → object (from database)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }
}
