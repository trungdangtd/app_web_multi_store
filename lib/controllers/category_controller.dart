import 'package:app_web_multi_store/global_variable.dart';
import 'package:app_web_multi_store/models/category.dart';
import 'package:app_web_multi_store/services/manage_http_respone.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  uploadCategory(
      {required dynamic pickedImage,
      required dynamic pickedBanner,
      required String name,
      required context}) async {
    try {
      //Upload the image and banner to the server
      final cloudinary = CloudinaryPublic("dprtd493w", "fvsclpi9");

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedImage,
              identifier: 'pickedImage', folder: 'categoryImages'));

      String image = imageResponse.secureUrl;

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedBanner,
            identifier: 'pickedBanner', folder: 'categoryBanners'),
      );
      String banner = bannerResponse.secureUrl;

      Category category = Category(
        id: '',
        name: name,
        image: image,
        banner: banner,
      );
      http.Response response = await http.post(
        Uri.parse('$uri/api/categories'),
        body: category.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      manageHttpRespone(response: response, context: context, onSuccess: () {
        showSnackBar(context, 'Thêm loại sản phẩm thành công');
      });
    } catch (e) {
      // ignore: avoid_print
      print('Lỗi khi upload ảnh lên clouditionary: $e');
    }
  }
}