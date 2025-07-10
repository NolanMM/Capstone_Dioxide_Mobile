class RegisterUserResponse {
  final String message;
  final String sessionId;
  final String username;
  final String email;
  final int otpCode;
  final String timestamp;

  RegisterUserResponse({
    required this.message,
    required this.sessionId,
    required this.username,
    required this.email,
    required this.otpCode,
    required this.timestamp,
  });

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) {
    return RegisterUserResponse(
      message: json['message'] as String,
      sessionId: json['sessionId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      otpCode: json['otpCode'] as int,
      timestamp: json['timestamp'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'sessionId': sessionId,
        'username': username,
        'email': email,
        'otpCode': otpCode,
        'timestamp': timestamp,
      };
}
