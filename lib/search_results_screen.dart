import 'package:flutter/material.dart';
import 'package:projeto_sti/components/search_bar.dart';

import 'bottom_nav_bar_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  final Map args;

  const SearchResultsScreen({Key? key, required this.args}) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState(args);
}

class _SearchResultsScreenState extends State<SearchResultsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Map args;
  _SearchResultsScreenState(this.args);

  late String emailName = '';
  late String query = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    emailName = args['emailName'];
    query = args['query'];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void handleTabTap(int index) {
    Navigator.popUntil(context, (route) => !Navigator.canPop(context));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                BottomNavBarScreen(
                    args: {'index': index, 'emailName': emailName}
                )
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: SearchBar(emailName: emailName, query: query),
      body: const Center(
        child: Text('This is a test.'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 2.0,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
          tabs: const [
            Tab(icon: Icon(Icons.home_outlined)),
            Tab(icon: Icon(Icons.menu_outlined)),
            Tab(icon: Icon(Icons.shopping_cart_outlined)),
            Tab(icon: Icon(Icons.favorite_outline)),
            Tab(icon: Icon(Icons.delivery_dining_outlined)),
          ],
          onTap: handleTabTap,
        ),
      ),
    );
  }
}
