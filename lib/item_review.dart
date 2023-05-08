import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'carousel.dart';

class ItemReviewScreen extends StatefulWidget {
  final String itemTitle;

  const ItemReviewScreen({Key? key, required this.itemTitle}) : super(key: key);

  @override
  _ItemReviewScreenState createState() => _ItemReviewScreenState(itemTitle);
}

class _ItemReviewScreenState extends State<ItemReviewScreen>
    with SingleTickerProviderStateMixin {
  String itemTitle;
  bool availableData = false;
  String _itemBrand = "";
  String _itemReview = "";
  List<ReviewPercentage> _reviewPercentage = [];
  List<ItemComment> _itemComments = [];
  _ItemReviewScreenState(this.itemTitle);

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/produtos.json');

    setState(() {
      final data = json.decode(response);
      _itemBrand = data[itemTitle]["itemBrand"];
      _itemReview = data[itemTitle]["itemReview"];
      for (var review in data[itemTitle]["allReviewPercentage"]) {
        _reviewPercentage.add(ReviewPercentage(
            type: review["type"], percentage: review["percentage"]));
      }
      for (var comment in data[itemTitle]["itemComments"]) {
        List<String> images = [];
        for (var img in comment["images"]) {
          images.add(img);
        }
        _itemComments.add(ItemComment(
            userName: comment["userName"],
            review: comment["comment"],
            stars: comment["stars"],
            images: images));
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
        : Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: 360,
                  height: 212,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary)),
                  child: const Carousel()),
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
                padding: const EdgeInsets.only(
                    left: 40, right: 40, bottom: 15, top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(_itemBrand,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.blueGrey))),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Row(children: [
                          Container(
                              padding: const EdgeInsets.only(right: 5),
                              child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(_itemReview,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.blueGrey)))),
                          Container(
                              child: const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20,
                          ))
                        ]),
                      )
                    ]),
              ),
              Container(
                padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text("${_itemComments.length} comentários"),
              ),
              Column(
                  children: _reviewPercentage
                      .map((review) => Container(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, bottom: 10),
                          alignment: Alignment.centerLeft,
                          child: Row(children: [
                            Container(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(review.type)),
                            const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 20,
                                )),
                            Container(
                              width: 280,
                              height: 20.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.topLeft,
                                widthFactor: double.parse(review.percentage),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            )
                          ])))
                      .toList()),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                  color: Theme.of(context).colorScheme.surface,
                ),
                margin: const EdgeInsets.only(
                    left: 25, right: 25, bottom: 20, top: 20),
                child: Column(children: [
                  Row(children: [
                    Padding(
                        padding:
                            const EdgeInsets.only(right: 20, top: 10, left: 10),
                        child: Icon(Icons.account_circle,
                            size: 40,
                            color: Theme.of(context).colorScheme.primary)),
                    Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("Cesar De Deus",
                                style: TextStyle(color: Colors.black87))),
                        Row(
                          children: <Widget>[
                            for (int i = 0; i < 5; i++)
                              const Icon(
                                Icons.star,
                                color: Colors.grey,
                                size: 20,
                              )
                          ],
                        )
                      ],
                    )
                  ]),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, bottom: 10),
                    height: 50,
                    child: const Text("Inserir comentário... "),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    alignment: Alignment.center,
                    height: 100,
                    width: 100,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: const Icon(
                      Icons.image_search,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                ]),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 40, left: 40),
                child: RichText(
                    text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                        children: [
                      const TextSpan(text: "Todos os comentários de "),
                      TextSpan(
                        text: itemTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ])),
              ),
              Column(
                  children: _itemComments
                      .map(
                        (comment) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.secondary),
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          margin: const EdgeInsets.only(
                              left: 25, right: 25, bottom: 20, top: 20),
                          child: Column(children: [
                            Row(children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, top: 10, left: 10),
                                  child: Icon(Icons.account_circle,
                                      size: 40,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                              Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(comment.userName,
                                          style: const TextStyle(
                                              color: Colors.black87))),
                                  Row(
                                    children: <Widget>[
                                      for (int i = 1; i < 6; i++)
                                        Icon(
                                          Icons.star,
                                          color: i > int.parse(comment.stars)
                                              ? Colors.grey
                                              : Colors.yellow,
                                          size: 20,
                                        )
                                    ],
                                  )
                                ],
                              )
                            ]),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, bottom: 10, right: 20),
                              child: Text(comment.review),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                alignment: Alignment.center,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: comment.images
                                        .map((img) => Container(
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.only(
                                                right: 10, left: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: SvgPicture.asset(img,
                                                width: 100, height: 100)))
                                        .toList(),
                                  ),
                                )),
                          ]),
                        ),
                      )
                      .toList()),
            ],
          );
  }
}

class ItemComment {
  final String userName;
  final String review;
  final String stars;
  List<String> images;

  ItemComment(
      {required this.userName,
      required this.review,
      required this.stars,
      required this.images});
}

class ReviewPercentage {
  final String type;
  final String percentage;

  ReviewPercentage({required this.type, required this.percentage});
}
