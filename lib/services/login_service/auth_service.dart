import 'package:dioxide_mobile/entities/user.dart';
import 'package:http/http.dart' as http;
import '../../models/login_dto.dart';
import 'dart:convert';
import 'dart:io';

class AuthService {
  static final _baseUrl = Platform.isAndroid
      ? 'http://10.0.2.2:8000/api'
      : 'http://127.0.0.1:8000/api';

  static Future<User> login(LoginDto dto) async {
    final uri = Uri.parse('$_baseUrl/v2/login/?email=${dto.username}&password=${dto.password}');
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      String msg = 'Unknown error';
      try {
        msg = jsonDecode(response.body)['message'] as String? ?? msg;
      } catch (_) {}
      throw Exception('Login failed (${response.statusCode}): $msg');
    }
  }
}
