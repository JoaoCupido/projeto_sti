import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_sti/search_bar.dart';
import 'package:projeto_sti/compare_item.dart';
import 'package:projeto_sti/item_description.dart';
import 'package:projeto_sti/item_review.dart';

class ItemScreen extends StatefulWidget {
  final String emailName;
  final String itemTitle;
  const ItemScreen({Key? key, required this.emailName, required this.itemTitle})
      : super(key: key);

  @override
  _ItemScreenState createState() => _ItemScreenState(emailName, itemTitle);
}

class _ItemScreenState extends State<ItemScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  String emailName;
  String itemTitle;
  _ItemScreenState(this.emailName, this.itemTitle);

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);
    controller.addListener((_handleTabSelection));
  }

  _handleTabSelection() {
    if (controller.indexIsChanging) {
      setState(() {});
    }
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
      appBar: SearchBar(
        emailName: emailName,
      ),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: AppBar(
            title: TabBar(
              controller: controller,
              tabs: const [
                Tab(icon: Icon(Icons.menu)),
                Tab(icon: Icon(Icons.star)),
                Tab(icon: Icon(Icons.tune)),
              ],
              labelColor: Theme.of(context).colorScheme.primary,
              indicatorColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.blueGrey,
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
                child: Center(
          child: [
            ItemDescriptionScreen(itemTitle: itemTitle),
            ItemReviewScreen(itemTitle: itemTitle),
            CompareItemScreen(),
          ][controller.index],
        )))
      ]),
    );
  }
}
