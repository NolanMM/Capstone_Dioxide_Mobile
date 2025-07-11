import 'package:dioxide_mobile/entities/user.dart';
import 'package:dioxide_mobile/models/news_article_dto.dart';
import 'package:dioxide_mobile/services/notification_service/notification_services.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<NewsArticle>> _newsFuture;
  final int numberOfDays = 2;
  
  @override
  void initState() {
    super.initState();
    _newsFuture = NewsService.fetchArticles(numberOfDays);
  }

  User? user;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    user = arguments['user'] as User?;
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
                Navigator.pushReplacementNamed(context, '/home', arguments: {
                  'user': user,
                });
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
                Navigator.pushReplacementNamed(context, '/profile', arguments: {
                  'user': user,
                });
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<NewsArticle>>(
          future: _newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No notifications available.'));
            }

            final articles = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.only(top: 10, left: 30, bottom: 20, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Notifications',
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 3.5,
                    width: 50,
                    color: Colors.black,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                  ),

                  const SizedBox(height: 40),
                  Divider(color: Colors.black, thickness: 1),
                  const SizedBox(height: 5),
                  Text(
                    'Wednesday, 8 July',
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Divider(color: Colors.black, thickness: 1),

                  // Articles list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return GestureDetector(
                        onTap: () => NewsService.openInChrome(article.headline),
                        child: Container(
                          width: double.infinity,
                          height: 280,
                          margin: const EdgeInsets.only(bottom: 0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(color: Colors.black, width: 1),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 35, left: 16, right: 16, bottom: 15),
                                child: Text(
                                  article.source,
                                  style: const TextStyle(
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
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Text(
                                            article.headline,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: 'Roboto',
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5, left: 16),
                                          child: Text(
                                            article.summary,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: 'Roboto',
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
                                          child: Text(
                                            'Updated on: ${article.datetime.day}/${article.datetime.month}/${article.datetime.year}',
                                            style: const TextStyle(
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
                                    margin: const EdgeInsets.only(right: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: article.image != null
                                            ? NetworkImage(article.image!)
                                            : const AssetImage('assets/news_image_placeholder.png') as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),

    );
  }
}
