import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_sti/components/search_bar.dart';
import 'package:projeto_sti/compare_item.dart';
import 'package:projeto_sti/item_description.dart';
import 'package:projeto_sti/item_review.dart';

class ItemScreen extends StatefulWidget {
  final String emailName;
  const ItemScreen({Key? key, required this.emailName}) : super(key: key);

  @override
  _ItemScreenState createState() => _ItemScreenState(emailName);
}

class _ItemScreenState extends State<ItemScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  String emailName;
  _ItemScreenState(this.emailName);

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
      body: ListView(children: [
        SearchBar(
          emailName: emailName,
          query: '',
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
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
        Center(
          child: [
            const ItemDescriptionScreen(),
            const ItemReviewScreen(),
            const CompareItemScreen(),
          ][controller.index],
        )
      ]),
    );
  }
}
