import 'package:dioxide_mobile/pages/searchpage/widgets/general_knowledge_card.dart';
import 'package:dioxide_mobile/pages/searchpage/widgets/investment_advice_card.dart';
import 'package:dioxide_mobile/pages/searchpage/widgets/ticker_analysis_card.dart';
import 'package:dioxide_mobile/services/search_services/search_service.dart';
import 'package:dioxide_mobile/entities/GeneralKnowledgeResponse.dart';
import 'package:dioxide_mobile/entities/InvestmentAdviceResponse.dart';
import 'package:dioxide_mobile/models/search_analysis_response.dart';
import 'package:dioxide_mobile/entities/TickerAnalysisResponse.dart';
import 'package:dioxide_mobile/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  SearchAnalysisApiResponse? _apiResponse;
  bool _isLoading = false;
  String? _error;
  User? _user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      _user = arguments['user'] as User?;
    }
  }

  Future<void> _handleSearch(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _apiResponse = null;
    });

    try {
      final response = await SearchService.analyzeQuery(query);
      setState(() {
        _apiResponse = response;
      });
    } catch (e) {
      setState(() {
        _error = 'An error occurred: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String currentDate = DateFormat('EEEE, d MMMM').format(DateTime.now());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF8F9FA),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Search',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
            Container(
              height: 3.5,
              width: 50,
              color: Colors.black,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.black),
            Text(currentDate,
              style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.black),
            const SizedBox(height: 16),
            // Search Bar
            TextField(
              controller: _searchController,
              onSubmitted: _handleSearch,
              decoration: InputDecoration(
                hintText: 'Ask about stocks, finance, or investments...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _buildResults(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildResults() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(_error!, style: const TextStyle(color: Colors.red)));
    }
    if (_apiResponse == null) {
      return const Center(
        child: Text(
          'Enter a query to start your financial analysis.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return SingleChildScrollView(
      child: switch (_apiResponse) {
        TickerAnalysisResponse r => TickerAnalysisCard(data: r.data),
        GeneralKnowledgeResponse r => GeneralKnowledgeCard(data: r.data),
        InvestmentAdviceResponse r => InvestmentAdviceCard(data: r.data),
        _ => const Center(child: Text('Unsupported response type.')),
      },
    );
  }

  /// Builds the bottom navigation bar.
  Widget _buildBottomNavBar() {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navBarItem(Icons.home_outlined, 'Home', '/home'),
          _navBarItem(Icons.search, 'Search', '/search', isActive: true),
          _navBarItem(Icons.bar_chart_outlined, 'Graph', '/graph'),
          _navBarItem(Icons.notifications_outlined, 'Notifications', '/notification'),
          _navBarItem(Icons.person_outline, 'Profile', '/profile'),
        ],
      ),
    );
  }

  /// Helper for creating a navigation bar item.
  Widget _navBarItem(IconData icon, String label, String route, {bool isActive = false}) {
    final color = isActive ? Theme.of(context).primaryColor : Colors.grey[600];
    return IconButton(
      icon: Icon(icon, color: color, size: 28),
      onPressed: () {
        if (!isActive) {
          Navigator.pushReplacementNamed(context, route, arguments: {'user': _user});
        }
      },
      tooltip: label,
    );
  }
}