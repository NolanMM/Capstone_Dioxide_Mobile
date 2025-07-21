import 'package:dioxide_mobile/entities/user.dart';
import 'package:dioxide_mobile/models/news_article_dto.dart';
import 'package:dioxide_mobile/services/notification_service/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  Future<List<NewsArticle>> _articlesFuture = NewsService.fetchArticles(7);
  List<NewsArticle> _allArticles = [];
  int _visibleArticleCount = 5;

  @override
  void initState() {
    super.initState();
    _articlesFuture = NewsService.fetchArticles(7);
  }

  void _loadMoreArticles() {
    setState(() {
      _visibleArticleCount = (_visibleArticleCount + 5).clamp(0, _allArticles.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    user = arguments['user'] as User?;
    final String todayDate = DateFormat('EEEE, d MMMM').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 40,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: FutureBuilder<List<NewsArticle>>(
          future: _articlesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load news: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No news articles found.'));
            } else {
              _allArticles = snapshot.data!;
              final now = DateTime.now();
              final today = DateTime(now.year, now.month, now.day);
              final todaysArticles = _allArticles
                  .where((article) =>
                      article.datetime.year == today.year &&
                      article.datetime.month == today.month &&
                      article.datetime.day == today.day)
                  .toList();
              
              return _buildMainContent(todayDate, todaysArticles);
            }
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(String todayDate, List<NewsArticle> todaysArticles) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 30, bottom: 0, right: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 40),
            _buildDateSection(todayDate),
            const SizedBox(height: 20),
            _buildTodaysArticlesSection(todaysArticles),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'Latest Articles',
                style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),
            ),
            const SizedBox(height: 10),
            _buildLatestArticlesList(),
            const SizedBox(height: 20),
            if (_visibleArticleCount < _allArticles.length)
              _buildLoadMoreButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.black, size: 28),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/search', arguments: {'user': user});
            },
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/graph', arguments: {'user': user});
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/notification', arguments: {'user': user});
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/profile', arguments: {'user': user});
            },
          ),
        ],
      ),
    );
  }

  /// Builds the "Almanac" header.
  Widget _buildHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Almanac',
            style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 3.5,
            width: 50,
            color: Colors.black,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
          ),
        ],
      ),
    );
  }

  /// Builds the section displaying the current date.
  Widget _buildDateSection(String todayDate) {
    return Column(
      children: [
        Container(height: 1, width: double.infinity, color: Colors.black, margin: const EdgeInsets.symmetric(vertical: 8.0)),
        const SizedBox(height: 5),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            todayDate,
            style: const TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
        ),
        const SizedBox(height: 5),
        Container(height: 1, width: double.infinity, color: Colors.black, margin: const EdgeInsets.symmetric(vertical: 8.0)),
      ],
    );
  }

  /// Builds the horizontally scrolling list of today's articles.
  Widget _buildTodaysArticlesSection(List<NewsArticle> todaysArticles) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${todaysArticles.length} New Articles',
              style: const TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
            ),
            const Text(
              'Today',
              style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (todaysArticles.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: todaysArticles.map((article) => _buildHorizontalArticleCard(article)).toList(),
            ),
          )
        else
          Container(
            height: 100,
            alignment: Alignment.center,
            child: const Text("No new articles for today.", style: TextStyle(fontSize: 16)),
          ),
      ],
    );
  }
  
  /// Builds a single card for the horizontal "Today's Articles" list.
  Widget _buildHorizontalArticleCard(NewsArticle article) {
    return GestureDetector(
        onTap: () => NewsService.openInChrome(article.headline),
        child: Container(
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
                    color: const Color(0xFFBBBBBB),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: article.image != null
                        ? Image.network(
                            article.image!,
                            width: 330,
                            height: 250,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => 
                              Image.asset('assets/news_image_placeholder.png', width: 330, height: 250, fit: BoxFit.cover),
                          )
                        : Image.asset(
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
                    border: Border.all(color: Colors.black, width: 2),
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
                      offset: const Offset(0,4),
                    )],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 50,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF999797),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Text(
                          article.symbol,
                          style: const TextStyle(
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
                            article.headline,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
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
                    article.summary,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontSize: 15 ,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
                                  
            ],
          ),
        ),
    );
  }

  /// Builds the vertically stacked list of "Latest Articles".
  Widget _buildLatestArticlesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _visibleArticleCount.clamp(0, _allArticles.length),
      itemBuilder: (context, index) {
        final article = _allArticles[index];
        return _buildVerticalArticleListItem(article);
      },
    );
  }

  /// Builds a single list item for the "Latest Articles" list.
  Widget _buildVerticalArticleListItem(NewsArticle article) {
    return GestureDetector(
      onTap: () => NewsService.openInChrome(article.headline),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black, width: 1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.source,
              style: const TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.headline,
                        style: const TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        article.summary,
                        style: const TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 16),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: (article.image != null
                            ? NetworkImage(article.image!)
                            : const AssetImage('assets/news_image_placeholder.png')) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text(
                  'Updated on: ${DateFormat('d MMMM yyyy').format(article.datetime)}',
                  style: const TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 110),
                if (article.positiveValue >= article.negativeValue && article.positiveValue >= article.neutralValue) ...[
                  const Icon(Icons.arrow_upward, color: Colors.green),
                  Text(' ${article.positiveValue.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                ] else if (article.negativeValue >= article.positiveValue && article.negativeValue >= article.neutralValue) ...[
                  const Icon(Icons.arrow_downward, color: Colors.red),
                  Text(' ${article.negativeValue.toStringAsFixed(2)}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
                ] else ...[
                  const Icon(Icons.horizontal_rule, color: Colors.grey),
                  Text(' ${article.neutralValue.toStringAsFixed(2)}', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16)),
                ]
              ],
            ),
            
            
          ],
        ),
      ),
    );
  }

  /// Builds the "Load More" button.
  Widget _buildLoadMoreButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _loadMoreArticles,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Colors.black),
          ),
        ),
        child: const Text(
          'Load More',
          style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}