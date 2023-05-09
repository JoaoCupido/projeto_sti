import 'package:flutter/material.dart';
import 'package:projeto_sti/components/search_bar.dart';
import 'package:projeto_sti/wishlist_screen.dart';
import 'category_screen.dart';
import 'home_screen.dart';
import 'order_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  final Map args;

  const BottomNavBarScreen({Key? key, required this.args}) : super(key: key);

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState(args);
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Map args;
  _BottomNavBarScreenState(this.args);

  late List<Widget> _screens = [];
  late String emailName = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    emailName = args['emailName'];
    _tabController.index = args['index'];
    _screens = [
      HomeScreen(emailName: emailName),
      CategoryScreen(emailName: emailName),
      HomeScreen(emailName: emailName),
      WishlistScreen(emailName: emailName),
      OrderScreen(emailName: emailName),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void handleTabTap(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _screens.isNotEmpty ? Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: SearchBar(emailName: emailName, query: ''),
      body: TabBarView(
        controller: _tabController,
        children: _screens,
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
    ) : const Scaffold();
  }

}
