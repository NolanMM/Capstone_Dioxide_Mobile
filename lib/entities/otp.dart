class OTPResponse {
  final String message;
  final int id;
  final String username;
  final String email;

  OTPResponse({
    required this.message,
    required this.id,
    required this.username,
    required this.email,
  });

  factory OTPResponse.fromJson(Map<String, dynamic> json) {
    return OTPResponse(
      message: json['message'] as String,
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'id': id,
        'username': username,
        'email': email,
      };
}
