import 'package:app_web_multi_store/controllers/category_controller.dart';
import 'package:app_web_multi_store/controllers/subcategory_controller.dart';
import 'package:app_web_multi_store/models/category.dart';
import 'package:app_web_multi_store/views/side_bar_screen/widgets/subcategory_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SubcategoryScreen extends StatefulWidget {
  static const String id = '/subcategory';

  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  final SubcategoryController subcategoryController = SubcategoryController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<List<Category>> futureCategories;
  late String name;
  Category? selectedCategory;
  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategoriess();
  }

  dynamic _image;
  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Danh mục sản phẩm con',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  )),
            ),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            FutureBuilder(
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
                    return DropdownButton<Category>(
                        value: selectedCategory,
                        hint: const Text('Chọn loại sản phẩm'),
                        items: snapshot.data!.map((Category category) {
                          return DropdownMenuItem(
                              value: category, child: Text(category.name));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                          print(selectedCategory!.name);
                        });
                  }
                }),
            Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _image != null
                        ? Image.memory(_image)
                        : const Text('Ảnh loại sản phẩm con'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      onChanged: (value) {
                        name = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập tên loại sản phẩm con';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Nhập tên loại sản phẩm con',
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await subcategoryController.uploadSubcategory(
                          categoryId: selectedCategory!.id,
                          categoryName: selectedCategory!.name,
                          pickedImage: _image,
                          subCategoryName: name,
                          context: context);
                      setState(() {
                        _formKey.currentState!.reset();
                        _image = null;
                      });
                    }
                  },
                  child: const Text(
                    'Lưu',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: const Text('Thêm ảnh'),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            const SubcategoryWidget(),
          ],
        ),
      ),
    );
  }
}
