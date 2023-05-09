import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'carousel.dart';

class ItemDescriptionScreen extends StatefulWidget {
  final String itemTitle;

  const ItemDescriptionScreen({Key? key, required this.itemTitle})
      : super(key: key);

  @override
  _ItemDescriptionScreenState createState() =>
      _ItemDescriptionScreenState(itemTitle);
}

class _ItemDescriptionScreenState extends State<ItemDescriptionScreen>
    with SingleTickerProviderStateMixin {
  String itemTitle;
  bool availableData = false;
  String _itemBrand = "";
  String _itemDescription = "";
  String _itemDetails = "";
  String _itemSpecs = "";
  String _itemMoreInfo = "";
  List<ItemInfo> _itemInfo = [];
  List<String> _imagesList = [];
  _ItemDescriptionScreenState(this.itemTitle);

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/produtos.json');

    setState(() {
      final data = json.decode(response);
      _itemBrand = data[itemTitle]["itemBrand"];
      _itemDescription = data[itemTitle]["itemDescription"];
      _itemDetails = data[itemTitle]["itemDetails"];
      _itemSpecs = data[itemTitle]["itemSpecs"];
      _itemMoreInfo = data[itemTitle]["itemMoreInfo"];
      _itemInfo = [
        ItemInfo(name: "Detalhes", info: _itemDetails),
        ItemInfo(name: "Especificações", info: _itemSpecs),
        ItemInfo(name: "Mais Informação", info: _itemMoreInfo)
      ];
      for (var img in data[itemTitle]["itemImages"]) {
        _imagesList.add(img);
      }
      availableData = true;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !availableData
        ? const CircularProgressIndicator()
        : Column(children: [
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                width: 360,
                height: 212,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.secondary)),
                child: Carousel(imagesList: _imagesList)),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
              child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(itemTitle,
                      style: const TextStyle(
                          fontSize: 30, color: Colors.black87))),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                  left: 40, right: 40, bottom: 20, top: 10),
              child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(_itemBrand,
                      style: const TextStyle(
                          fontSize: 14, color: Colors.blueGrey))),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 15, left: 30, right: 30),
              child: Text(
                _itemDescription,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: ExpansionPanelList(
                expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 0),
                expansionCallback: (index, isExpanded) {
                  setState(() {
                    _itemInfo[index].isExpanded = !isExpanded;
                  });
                },
                animationDuration: const Duration(milliseconds: 600),
                children: _itemInfo
                    .map((item) => ExpansionPanel(
                          canTapOnHeader: true,
                          backgroundColor: item.isExpanded == true
                              ? Colors.white60
                              : Theme.of(context).colorScheme.surface,
                          headerBuilder: (_, isExpanded) => Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              child: Text(
                                item.name,
                                style: const TextStyle(fontSize: 20),
                              )),
                          body: Container(
                            color: Theme.of(context).colorScheme.surface,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            child: Text(item.info),
                          ),
                          isExpanded: item.isExpanded,
                        ))
                    .toList(),
              ),
            ),
          ]);
  }
}

class ItemInfo {
  final String name;
  final String info;
  bool isExpanded = false;

  ItemInfo({required this.name, required this.info});
}
