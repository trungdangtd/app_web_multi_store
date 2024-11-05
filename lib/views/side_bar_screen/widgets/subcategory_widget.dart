import 'package:app_web_multi_store/controllers/subcategory_controller.dart';
import 'package:app_web_multi_store/models/subcategory.dart';
import 'package:flutter/material.dart';

class SubcategoryWidget extends StatefulWidget {
  const SubcategoryWidget({super.key});

  @override
  State<SubcategoryWidget> createState() => _SubCategoriesWidgetState();
}

class _SubCategoriesWidgetState extends State<SubcategoryWidget> {
  late Future<List<Subcategory>> futureSubCategories;
  @override
  void initState() {
    super.initState();
    futureSubCategories = SubcategoryController().loadSubCategoriess();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureSubCategories,
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
            final subcategory = snapshot.data!;
            return GridView.builder(
              shrinkWrap: true,
              itemCount: subcategory.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, crossAxisSpacing: 8, mainAxisExtent: 200),
              itemBuilder: (context, index) {
                final subcategories = subcategory[index];
                return Column(
                  children: [
                    Image.network(
                      subcategories.image,
                      height: 100,
                      width: 100,
                    ),
                    Text(subcategories.categoryName)
                  ],
                );
              },
            );
          }
        });
  }
}
