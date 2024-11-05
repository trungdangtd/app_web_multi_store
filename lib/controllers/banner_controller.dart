import 'dart:convert';

import 'package:app_web_multi_store/global_variable.dart';
import 'package:app_web_multi_store/models/banner.dart';
import 'package:app_web_multi_store/services/manage_http_respone.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class BannerController {
  uploadBanner({required dynamic pickedImage, required context}) async {
    try {
      final cloudinary = CloudinaryPublic("dprtd493w", "fvsclpi9");
      CloudinaryResponse imageRespone = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedImage,
              identifier: 'pickedImage', folder: 'banners'));
      String image = imageRespone.secureUrl;

      BannerModel bannerModel = BannerModel(id: '', image: image);

      http.Response response = await http.post(
        Uri.parse("$uri/api/banner"),
        body: bannerModel.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      manageHttpRespone(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Thêm banner thành công');
          });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  //fetch all banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      }else{
        throw Exception('Lỗi khi load banner');
      }
    } catch (e) {
      // ignore: avoid_print
      throw Exception('Lỗi khi load banner: $e');
    }
  }
}
