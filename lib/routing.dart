import 'package:flutter/material.dart';

class AppRouting extends StatefulWidget {
  const AppRouting({super.key});

  @override
  State<AppRouting> createState() => _AppRoutingState();
}

class _AppRoutingState extends State<AppRouting> {
  @override
  Widget build(BuildContext context) {    
    return MaterialApp(
      title: 'The Almanac | Predictions Application',
      initialRoute: '/',
      routes: {
        '/': (context) => LogoPage(),
      },
    );
  }
}