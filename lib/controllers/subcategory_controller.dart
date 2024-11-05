import 'dart:convert';

import 'package:app_web_multi_store/global_variable.dart';
import 'package:app_web_multi_store/models/subcategory.dart';
import 'package:app_web_multi_store/services/manage_http_respone.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class SubcategoryController {
  uploadSubcategory(
      {required String categoryId,
      required String categoryName,
      required dynamic pickedImage,
      required String subCategoryName,
      required context}) async {
    try {
      final cloudinary = CloudinaryPublic("dprtd493w", "fvsclpi9");

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedImage,
              identifier: 'pickedImage', folder: 'categoryImages'));

      String image = imageResponse.secureUrl;
      Subcategory subcategory = Subcategory(
          id: '',
          categoryId: categoryId,
          categoryName: categoryName,
          image: image,
          subCategoryName: subCategoryName);
      http.Response response = await http.post(
        Uri.parse('$uri/api/subcategories'),
        body: subcategory.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      manageHttpRespone(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Thêm danh mục con thành công');
          });
    } catch (e) {
      print(e);
    }
  }

  //load the uploaded categories
  Future<List<Subcategory>> loadSubCategoriess() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/subcategories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Subcategory> subCategories = data
            .map((subcategory) => Subcategory.fromJson(subcategory))
            .toList();
        return subCategories;
      } else {
        throw Exception('Lỗi khi load danh mục con');
      }
    } catch (e) {
      // ignore: avoid_print
      throw Exception('Lỗi khi load danh mục con: $e');
    }
  }
}
