import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'classes/category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.8),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: _selectedIndex == index
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surface,
                      ),
                      child: Text(
                        animalCategories[index],
                        style: TextStyle(
                          color: _selectedIndex == index
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            GridView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.9,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                final category = categories[index];
                return _buildCategoryItem(category.imageUrl, category.name, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String imageUrl, String name, BuildContext context) {
    Widget imageWidget;
    if (imageUrl.endsWith('.svg')) {
      imageWidget = SvgPicture.asset(
        imageUrl,
        height: 80,
        width: 80,
      );
    } else if (imageUrl.endsWith('.png')) {
      imageWidget = Image.asset(
        imageUrl,
        height: 80,
        width: 80,
      );
    } else {
      throw Exception('Unsupported image type: $imageUrl');
    }

    return GestureDetector(
      onTap: () {
        //TODO: Add navigation to search with results screen
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              imageWidget,
              const SizedBox(height: 10.0),
              Text(
                name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
