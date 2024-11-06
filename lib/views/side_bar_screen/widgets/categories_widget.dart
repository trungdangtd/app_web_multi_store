import 'package:app_web_multi_store/controllers/category_controller.dart';
import 'package:app_web_multi_store/models/category.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  late Future<List<Category>> futureCategories;
  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategoriess();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Lỗi: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Không có banner nào"),
            );
          } else {
            final category = snapshot.data!;
            return GridView.builder(
              shrinkWrap: true,
              itemCount: category.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, crossAxisSpacing: 8, mainAxisExtent: 200),
              itemBuilder: (context, index) {
                final categories = category[index];
                return Column(
                  children: [
                    Image.network(
                      categories.image,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 10),
                    Text(categories.name),
                  ],
                );
              },
            );
          }
        });
  }
}
