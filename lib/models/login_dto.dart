class LoginDto  {
  String? username;
  String? password;

  LoginDto({this.username, this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory LoginDto.fromJson(Map<String, dynamic> json) {
    return LoginDto(
      username: json['username'],
      password: json['password'],
    );
  }

  // Parse the json response from the server
  static LoginDto fromResponse(Map<String, dynamic> response) {
    return LoginDto(
      username: response['username'],
      password: response['password'],
    );
  }
}