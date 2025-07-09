import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              icon: Icon(Icons.home, color: Colors.black, size: 28,),
              onPressed: () {
                // Navigate to Home Page
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('8 New Articles',
                      style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                    ),
                    Text('Today',
                      style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // List of cards for articles horizontally
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(8, (index) {
                      return Container(
                        width: 350,
                        height: 500,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: 20,
                              left: 10,
                              child: Container(
                                width: 330,
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Color(0xFFBBBBBB),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/news_image_placeholder.png',
                                    width: 330,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 255,
                              left: 10,
                              child: Container(
                                height: 220,
                                width: 330,
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFA9A4A4),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 175,
                              left: 10,
                              child: Container(
                                width: 325,
                                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,                          
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: Offset(0,4),
                                  )],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // make background color invisible
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 35,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF999797),
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      child: Text(
                                        '0${index + 1}',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 350,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF6F6),
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Title of the article goes here. This is a brief description of the article content.',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 365,
                              left: 25,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 2,      
                                width: 295,     
                                color: Colors.black,
                                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                              ),
                            ),  
                            Positioned(
                              top: 370,
                              left: 10,
                              child: Container(
                                width: 325,
                                height: 100,
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Description of the article goes here. This is a brief description of the article content.',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.black,
                                    fontSize: 15 ,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),                    
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Text('Latest Articles',
                    style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  ),
                ),
                SizedBox(height: 10),
                // List of articles Vertically
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 300,
                      margin: const EdgeInsets.only(bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(0),
                        border: Border(
                          top: BorderSide(color: Colors.black, width: 1),
                          //bottom: BorderSide(color: Colors.black, width: 1),
                          // left and right are omitted → no border there
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
                SizedBox(height: 20),
                // Load more button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Load more articles
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Load More',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),                
              ],
            ),
          ),
        )       
      ),
    );
  }
}
