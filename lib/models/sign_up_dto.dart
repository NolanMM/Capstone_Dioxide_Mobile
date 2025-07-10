class SignUpDto  {
  String? username;
  String? password;
  String? email;
  String? first_name;
  String? last_name;

  SignUpDto({this.username, this.password, this.email, this.first_name, this.last_name});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
    };
  }

  factory SignUpDto.fromJson(Map<String, dynamic> json) {
    return SignUpDto(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
    );
  }

  static SignUpDto fromResponse(Map<String, dynamic> response) {
    return SignUpDto(
      username: response['username'],
      password: response['password'],
      email: response['email'],
      first_name: response['first_name'],
      last_name: response['last_name'],
    );
  }
}