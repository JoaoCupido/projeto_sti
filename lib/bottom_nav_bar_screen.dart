import 'package:flutter/material.dart';
import 'package:projeto_sti/components/search_bar.dart';
import 'package:projeto_sti/wishlist_screen.dart';
import 'category_screen.dart';
import 'home_screen.dart';
import 'order_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      emailName = args as String;
    }
    _screens = [
      HomeScreen(emailName: emailName),
      const CategoryScreen(),
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
    //print(emailName);
    return _screens.isNotEmpty ? Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: SearchBar(emailName: emailName),
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
