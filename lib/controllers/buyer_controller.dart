import 'dart:convert';

import 'package:app_web_multi_store/global_variable.dart';
import 'package:app_web_multi_store/models/buyer.dart';
import 'package:http/http.dart' as http;

class BuyerController {
  //fetch all banners
  Future<List<Buyer>> loadBuyers() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Buyer> buyers =
            data.map((buyer) => Buyer.fromMap(buyer)).toList();
        return buyers;
      }else{
        throw Exception('Lỗi khi load Buyer');
      }
    } catch (e) {
      // ignore: avoid_print
      throw Exception('Lỗi khi load Buyer: $e');
    }
  }
}