import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String  username = '';
  String  password = '';

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 40),
              Text('Sign In',
                style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 430, 
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    labelText: 'Username',
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
                    suffixIcon: Icon(Icons.person, color: Colors.black),
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
                  onPressed: () {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     backgroundColor: Colors.redAccent,
                    //     content: Text('Button pressed! The username is ${usernameController.text}' , style: TextStyle(fontFamily: 'Roboto', color: Colors.white))),
                    // );
                    setState(() {
                      username = usernameController.text;
                      password = passwordController.text;
                    });
                  },
                  child: Text('Sign In',
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
                    Text('Don\'t have an account?',
                      style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to the registration page
                      },
                      child: Text('Sign Up',
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