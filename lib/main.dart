import 'package:dioxide_mobile/routing.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class _DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? ctx) {
    return super.createHttpClient(ctx)
      ..badCertificateCallback = (_, __, ___) => true;
  }
}

void main() {
  HttpOverrides.global = _DevHttpOverrides();
  runApp(AppRouting());
}