import 'package:dioxide_mobile/entities/register_user.dart';
import 'package:http/http.dart' as http;
import '../models/sign_up_dto.dart';
import 'dart:convert';
import 'dart:io';

class SignUpService {
  static final _baseUrl = Platform.isAndroid
      ? 'https://10.0.2.2:7027/api/mobiledioxie'
      : 'https://127.0.0.1:7027/api/mobiledioxie';

  static Future<RegisterUserResponse> signup(SignUpDto signupdto) async {
    final uri = Uri.parse('$_baseUrl/register_user/request');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(signupdto.toJson()),
    );
    if (response.statusCode == 200) {
      return RegisterUserResponse.fromJson(jsonDecode(response.body));
    } else {
      String msg = 'Unknown error';
      try {
        msg = jsonDecode(response.body)['message'] as String? ?? msg;
      } catch (_) {}
      throw Exception('Login failed (${response.statusCode}): $msg');
    }
  }
}
