import 'package:dioxide_mobile/models/login_dto.dart';
import 'package:flutter/material.dart';
import 'package:dioxide_mobile/entities/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  late TextEditingController fnameController;
  late TextEditingController usernameController;

  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
      user = arguments['user'] as User?;

      final String fullName = '${user?.lastName ?? ''} ${user?.firstName ?? ''}';
      final String emailSymbol = '@${user?.email.split('@').first ?? ''}';

      fnameController = TextEditingController(text: fullName.trim());
      usernameController = TextEditingController(text: emailSymbol);

      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    fnameController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 40,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home', arguments: {
                  'user': user,
                });
              },
            ),
            IconButton(icon: Icon(Icons.search, color: Colors.black), onPressed: () {}),
            IconButton(icon: Icon(Icons.bar_chart, color: Colors.black), onPressed: () {
              Navigator.pushReplacementNamed(context, '/graph');
            }),
            IconButton(icon: Icon(Icons.notifications, color: Colors.black), onPressed: () {
              Navigator.pushReplacementNamed(context, '/notification', arguments: {
                'user': user,
              });
            }),
            IconButton(icon: Icon(Icons.person, color: Colors.black, size: 28), onPressed: () {
              Navigator.pushReplacementNamed(context, '/profile', arguments: {
                'user': user,
              });
            }),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, left: 30, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Profile',
                style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 3.5,
                width: 50,
                color: Colors.black,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
              ),
              const SizedBox(height: 40),
              Divider(color: Colors.black),
              const Text('Wednesday, 8 July',
                style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(color: Colors.black),
              const SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircleAvatar(radius: 50, backgroundColor: Colors.grey[300]),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.camera_alt, color: Colors.black, size: 26),
                      ),
                    ],
                  ),
                  const SizedBox(width: 60),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: fnameController,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(border: InputBorder.none),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: usernameController,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          decoration: const InputDecoration(border: InputBorder.none),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black),
                          onPressed: () {
                            // Navigate to Edit Profile Page
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 340),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login', arguments: {
                      'login_dto': LoginDto(username: '', password: ''),
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(360, 60),
                    backgroundColor: Colors.grey[400],
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Log Out',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
