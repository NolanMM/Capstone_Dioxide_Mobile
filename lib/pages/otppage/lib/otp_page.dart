import 'package:dioxide_mobile/models/otp_dto.dart';
import 'package:dioxide_mobile/models/sign_up_dto.dart';
import 'package:dioxide_mobile/services/register_service/register_service.dart';
import 'package:flutter/material.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {

  Map<String, dynamic>? arguments = {};

  SignUpDto? register_dto;

  String  otp_code = '';
  String session_id = '';

  final TextEditingController otp_codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    if (arguments != null) {
      register_dto = arguments!['register_dto'] as SignUpDto?;
      session_id = arguments!['session_id'] as String? ?? '';
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 40,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black, weight: 800, size: 30),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/signup', arguments: {
                'register_dto': register_dto,
              });
            },
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Email Verification',
                style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text('Please enter the OTP code sent to your email address.',
                style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 430, 
                child: TextField(
                  controller: otp_codeController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    labelText: 'OTP Codes',
                    labelStyle: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      //borderRadius: BorderRadius.circular(40.0),
                    ),
                    suffixIcon: Icon(Icons.password_rounded, color: Colors.black),
                  ),
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.black),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 20),
              // Resend OTP button
              TextButton(
                onPressed: () {
                  try{
                    // final data_response = await SignUpService.signup(register_dto);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('OTP code resent to user', style: TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 18)),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to resend OTP code: $e', style: TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 18)),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
                child: Text('Resend OTP',
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.deepPurple, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 50),
              SizedBox(
                width: 400,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async{
                    if (otp_codeController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text('Please enter the OTP code', style: TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 18)),
                        ),
                      );
                      return;
                    }
                    final otp_dto = OtpDto(
                      OTP_Number: otp_codeController.text.trim(),
                      SessionID: session_id,
                    );
                    try {
                      final data_response = await SignUpService.verifyOTP(otp_dto);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('${data_response.message}, Please log in using username ${data_response.username}!', style: TextStyle(fontFamily: 'Roboto', color: Colors.white)),
                        ),
                      );
                      await Future.delayed(Duration(seconds: 4));
                      Navigator.pushReplacementNamed(context, '/login');
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text('Registration failed: $e', style: TextStyle(fontFamily: 'Roboto', color: Colors.white)),
                        ),
                      );
                      Navigator.pushReplacementNamed(context, '/signup', arguments: {
                        'register_dto': register_dto,
                      });
                    }
                  },
                  child: Text('Verify',
                    style: TextStyle(fontFamily: 'Roboto', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Text('Username: $username',
              //   style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 16),
              // ),
              // SizedBox(height: 10),
              // Text('Password: $password',
              //   style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 16),
              // ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                      style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text('Sign In',
                        style: TextStyle(fontFamily: 'Roboto', color: Colors.deepPurple, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}