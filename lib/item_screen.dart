import 'package:flutter/material.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_sti/search_bar.dart';
import 'compare_item.dart';
import 'item_description.dart';
import 'item_review.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(children: [
        //const SearchBar(),
        Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          height: 50,
          child: Scaffold(
            appBar: AppBar(
              title: TabBar(
                controller: controller,
                tabs: const [
                  Tab(icon: Icon(Icons.menu)),
                  Tab(icon: Icon(Icons.star)),
                  Tab(icon: Icon(Icons.tune))
                ],
                labelColor: Theme.of(context).colorScheme.primary,
                indicatorColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Colors.blueGrey,
              ),
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
            body: TabBarView(
              controller: controller,
              children: const [
                ItemDescriptionScreen(),
                ItemReviewScreen(),
                CompareItemScreen(),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
