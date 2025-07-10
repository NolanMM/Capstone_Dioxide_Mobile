import 'package:dioxide_mobile/models/sign_up_dto.dart';
import 'package:dioxide_mobile/services/register_service.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String  password = '';
  String email = '';
  String first_name = '';
  String last_name = '';

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 40,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //SizedBox(height: 40),
              Text('Sign Up',
                style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 430, 
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    labelText: 'Email',
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
                    suffixIcon: Icon(Icons.email, color: Colors.black),
                  ),
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.black),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 430, 
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    labelText: 'Password',
                    labelStyle: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    suffixIcon: Icon(Icons.lock, color: Colors.black),
                  ),
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.black),
                  obscureText: true,
                  obscuringCharacter: '*',
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 430, 
                child: TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    labelText: 'First Name',
                    labelStyle: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    suffixIcon: Icon(Icons.person, color: Colors.black),
                  ),
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.black),
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 430, 
                child: TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    labelText: 'Last Name',
                    labelStyle: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    suffixIcon: Icon(Icons.person, color: Colors.black),
                  ),
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.black),
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(height: 80),
              
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
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     backgroundColor: Colors.redAccent,
                    //     content: Text('Button pressed! The username is ${usernameController.text}' , style: TextStyle(fontFamily: 'Roboto', color: Colors.white))),
                    // );
                    // setState(() {
                    //   username = usernameController.text;
                    //   password = passwordController.text;
                    // });
                    final register_dto = SignUpDto(
                      username: emailController.text.trim(),
                      password: passwordController.text,
                      email: emailController.text.trim(),
                      first_name: firstNameController.text.trim(),
                      last_name: lastNameController.text.trim(),
                    );
                    try {
                      final data_response = await SignUpService.signup(register_dto);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Registration request sent successful! Please check email ${data_response.username} for the OTP code', style: TextStyle(fontFamily: 'Roboto', color: Colors.white)),
                        ),
                      );
                      //Navigator.pushReplacementNamed(context, '/otp', arguments: register_dto);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text('Registration failed: $e', style: TextStyle(fontFamily: 'Roboto', color: Colors.white)),
                        ),
                      );
                    }
                  },
                  child: Text('Sign Up',
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