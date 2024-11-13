import 'dart:convert';

import 'package:app_web_multi_store/global_variable.dart';
import 'package:app_web_multi_store/models/order.dart';
import 'package:http/http.dart' as http;

class OrderController {
  Future<List<Order>> loadOrders() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<Order> orders = data.map((order) => Order.fromJson(order)).toList();
        return orders;
      }else{
        throw Exception('Lỗi khi load Order');
      }
    } catch (e) {
      throw Exception('Lỗi khi load Order: $e');
    }
  }
}
