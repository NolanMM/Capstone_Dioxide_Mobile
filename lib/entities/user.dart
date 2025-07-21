class User {
  final String message;
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  User({
    required this.message,
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        message: json['message'] as String,
        id: json['id'] as int,
        username: json['username'] as String,
        email: json['email'] as String,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
      );
  
  User copyWith({
    int? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? message,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      message: message ?? this.message,
    );
  }
}