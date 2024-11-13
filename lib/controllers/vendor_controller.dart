import 'dart:convert';

import 'package:app_web_multi_store/global_variable.dart';
import 'package:app_web_multi_store/models/vendor.dart';
import 'package:http/http.dart' as http;
class VendorController {
  //fetch all banners
  Future<List<Vendor>> loadVendors() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/vendors'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );


      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Vendor> vendors =
            data.map((vendor) => Vendor.fromMap(vendor)).toList();
        return vendors;
      }else{
        throw Exception('Lỗi khi load Vendor');
      }
    } catch (e) {
      // ignore: avoid_print
      throw Exception('Lỗi khi load Vendor: $e');
    }
  }
}