import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_sti/components/search_bar.dart';
import 'package:projeto_sti/compare_item.dart';
import 'package:projeto_sti/item_description.dart';
import 'package:projeto_sti/item_review.dart';

import 'bottom_nav_bar_screen.dart';
import 'buttons.dart';
import 'components/price.dart';

class ItemScreen extends StatefulWidget {
  final Map args;
  const ItemScreen({Key? key, required this.args})
      : super(key: key);

  @override
  _ItemScreenState createState() => _ItemScreenState(args);
}

class _ItemScreenState extends State<ItemScreen>
    with TickerProviderStateMixin {
  late TabController controller;
  Map args;
  _ItemScreenState(this.args);

  late TabController _tabController;

  late String emailName = '';
  late String itemTitle = '';
  late String query = '';
  
   String itemPrice = "";
  String itemDiscount = "";
  bool availableData = false;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);
    _tabController = TabController(length: 5, vsync: this);
    
    readJson();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    emailName = args['emailName'];
    itemTitle = args['itemTitle'];
    query = args['query'];
    controller.index = args['index'];
  }

  @override
  void dispose() {
    controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection(int index) {
    setState(() {
      controller.index = index;
    });
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
  
    Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/produtos.json');

    setState(() {
      final data = json.decode(response);
      itemPrice = data[itemTitle]["itemPrice"];
      itemDiscount = data[itemTitle]["itemDiscount"];

      availableData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !availableData
        ? const CircularProgressIndicator()
        : Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: SearchBar(
        emailName: emailName,
        query: query,
      ),
      body: Stack(children: [
         Column(children: [
        Container(
          margin: const EdgeInsets.all(10),
          color: Theme.of(context).colorScheme.surface,
          child: TabBar(
              controller: controller,
              tabs: const [
                Tab(icon: Icon(Icons.list_outlined)),
                Tab(icon: Icon(Icons.star_outline)),
                Tab(icon: Icon(Icons.compare_arrows_outlined)),
              ],
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Theme.of(context).colorScheme.primary,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
              onTap: _handleTabSelection,
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
                child: Center(
                  child: [
                    ItemDescriptionScreen(itemTitle: itemTitle),
                    ItemReviewScreen(itemTitle: itemTitle),
                    CompareItemScreen(itemTitle: itemTitle, emailName: emailName),
          ][controller.index],
        )))
      ]),
         Visibility(
             visible: _controller.index != 2,
             child: Buttons(
                   textLeft: CalculatePrice(
                   price: itemPrice,
                   discount: itemDiscount,
               ),
                   textRight: "Adicionar ao carrinho",
                   icon: Icons.shopping_cart,
                   onPress: () => {}))
        ]),
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
          controller: _tabController,
          indicator: const BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 0.0,
                color: Colors.transparent,
              ),
            ),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Theme.of(context).colorScheme.onSurface,
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
