import 'package:dioxide_mobile/models/UpdateUsernameDto.dart';
import 'package:dioxide_mobile/models/UpdateNameDto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ProfileService {
  static final _baseUrl = Platform.isAndroid
      ? 'https://capstonedioxiemobileserver-cfgqfudtbea6crd2.canadacentral-01.azurewebsites.net/api/mobiledioxie'
      : 'https://capstonedioxiemobileserver-cfgqfudtbea6crd2.canadacentral-01.azurewebsites.net/api/mobiledioxie';

  static Future<String> updateUsername(int? userId, UpdateUsernameDto dto) async {
    if (userId == null) {
      throw Exception('User ID is null');
    }
    final uri = Uri.parse('$_baseUrl/user/$userId/username');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'] as String;
    } else {
      String msg = 'Unknown error';
      try {
        msg = jsonDecode(response.body)['message'] as String? ?? msg;
      } catch (_) {
      }
      throw Exception(
          'Failed to update username (${response.statusCode}): $msg');
    }
  }

  static Future<String> updateName(int? userId, UpdateNameDto dto) async {
    if (userId == null) {
      throw Exception('User ID is null');
    }
    final uri = Uri.parse('$_baseUrl/user/$userId/name');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'] as String;
    } else {
      String msg = 'Unknown error';
      try {
        msg = jsonDecode(response.body)['message'] as String? ?? msg;
      } catch (_) {
      }
      throw Exception(
          'Failed to update name (${response.statusCode}): $msg');
    }
  }
}