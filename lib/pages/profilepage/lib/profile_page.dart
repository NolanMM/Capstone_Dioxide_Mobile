import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              icon: Icon(Icons.home, color: Colors.black,),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Navigate to Search Page
              },
            ),
            IconButton(
              icon: Icon(Icons.bar_chart, color: Colors.black),
              onPressed: () {
                // Navigate to Graph Page
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.black),
              onPressed: () {
                // Navigate to Notifications Page
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.black,  size: 28),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 30, bottom: 0, right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Almanac',
                        style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 3.5,      
                        width: 50,     
                        color: Colors.black,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 1,      
                  width: double.infinity,     
                  color: Colors.black,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                ),
                SizedBox(height: 5),
                Text('Wednesday, 8 July',
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 1,      
                  width: double.infinity,     
                  color: Colors.black,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          //backgroundImage: AssetImage('assets/images/profile_picture.png'),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            // Implement profile picture update functionality
                          },
                          child: Icon(Icons.camera_alt, color: Colors.black, size: 26),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60, top: 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Minh Nguyen',
                              style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text('@minhlenguyen',
                              style: TextStyle(fontFamily: 'Roboto', color: Colors.grey, fontSize: 16),
                            ),
                        
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.black),
                            onPressed: () {
                              // Navigate to Edit Profile Page
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 340),
                // Logout Button
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement logout functionality
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(360, 60),
                      backgroundColor: Colors.grey[400],
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Log Out',
                      style: TextStyle(fontFamily: 'Roboto', color: const Color.fromARGB(255, 255, 255, 255), fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
