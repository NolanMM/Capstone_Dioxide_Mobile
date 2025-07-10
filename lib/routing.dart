import 'package:dioxide_mobile/pages/graphpage/lib/graph_page.dart';
import 'package:dioxide_mobile/pages/homepage/lib/home_page.dart';
import 'package:dioxide_mobile/pages/loginpage/lib/login_page.dart';
import 'package:dioxide_mobile/pages/logopage/lib/logo_page.dart';
import 'package:dioxide_mobile/pages/notificationpage/lib/notification_page.dart';
import 'package:dioxide_mobile/pages/otppage/lib/otp_page.dart';
import 'package:dioxide_mobile/pages/profilepage/lib/profile_page.dart';
import 'package:dioxide_mobile/pages/signuppage/lib/sign_up_page.dart';
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
        '/login' : (context) => LoginPage(),
        '/signup' : (context) => SignUpPage(),
        '/home' : (context) => HomePage(),
        '/profile' : (context) => ProfilePage(),
        '/notification' : (context) => NotificationPage(),
        '/graph' : (context) => const StockChartPage(),
        '/otp' : (context) => const OTPPage(),
      },
    );
  }
}