import 'package:dioxide_mobile/entities/user.dart';
import 'package:http/http.dart' as http;
import '../../models/login_dto.dart';
import 'dart:convert';
import 'dart:io';

class AuthService {
  static final _baseUrl = Platform.isAndroid
      ? 'https://capstonedioxiemobileserver-cfgqfudtbea6crd2.canadacentral-01.azurewebsites.net/api/mobiledioxie'
      : 'https://capstonedioxiemobileserver-cfgqfudtbea6crd2.canadacentral-01.azurewebsites.net/api/mobiledioxie';

  static Future<User> login(LoginDto dto) async {
    final uri = Uri.parse('$_baseUrl/login_user');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dto.toJson()),
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
