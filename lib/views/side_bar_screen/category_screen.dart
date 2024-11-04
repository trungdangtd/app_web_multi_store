import 'package:app_web_multi_store/controllers/category_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = '/category';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CategoryController _categoryController = CategoryController();
  late String name;

  dynamic _bannerImage;
  // ignore: unused_field
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

  pickBannerImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _bannerImage = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Loại sản phẩm',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                )),
          ),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
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
                      : const Text('Ảnh loại sản phẩm'),
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
                        return 'Vui lòng nhập tên loại sản phẩm';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Nhập tên loại sản phẩm',
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Huỷ'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    _categoryController.uploadCategory(pickedImage: _image, pickedBanner: _bannerImage, name: name,context: context);
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
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: _bannerImage != null
                  ? Image.memory(_bannerImage)
                  : const Text(
                      'Ảnh Banner',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                ElevatedButton(onPressed: () {
                  pickBannerImage();
                }, child: const Text('Thêm ảnh')),
          ),
        ],
      ),
    );
  }
}
