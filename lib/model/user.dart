class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String? gender;
  final List<String>? habits;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.gender,
    this.habits,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      gender: map['gender'],
    );
  }
}