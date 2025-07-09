import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
                Navigator.pushReplacementNamed(context, '/graph');
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.black, size: 28),
              onPressed: () {
                // Navigate to Notifications Page
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.black),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Notifications',
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
                // List of Notifications
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 280,
                      margin: const EdgeInsets.only(bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(0),
                        border: Border(
                          //top: BorderSide(color: Colors.black, width: 1),
                          bottom: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:35, left: 16, right: 16, bottom: 15),
                            child: Text("Author Name",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0, left: 16, right: 0),
                                      child: Text(
                                        'Article ${index + 1}',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5, left: 16, right:0),
                                      child: Text(
                                        'This is a brief description of the article content.',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 0),
                                      child: Text(
                                        'Updated on: 8 July 2023',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage('assets/news_image_placeholder.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
