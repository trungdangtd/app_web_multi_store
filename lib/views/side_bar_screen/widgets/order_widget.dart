import 'package:app_web_multi_store/controllers/order_controller.dart';
import 'package:app_web_multi_store/currency_formatter.dart';
import 'package:app_web_multi_store/models/order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  //holds the list of orders
  late Future<List<Order>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = OrderController().loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    Widget orderData(int flex, Widget widget) {
      return Expanded(
        flex: flex,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              8,
            ),
            child: widget,
          ),
        ),
      );
    }

    return FutureBuilder(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Lỗi: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Không có order nào"),
            );
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      orderData(
                        1,
                        Image.network(
                          order.image,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      orderData(
                        3,
                        Text(
                          order.productName,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      orderData(
                        2,
                        Text(
                          CurrencyFormatter.formatToVND(order.productPrice),
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      orderData(
                        2,
                        Text(
                          order.category,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      orderData(
                        3,
                        Text(
                          order.fullName,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      orderData(
                        2,
                        Text(
                          order.email,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      orderData(
                        2,
                        Text(
                          order.locality,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      orderData(
                        1,
                        Text(
                          order.delivered == true
                              ? "Đã giao hàng"
                              : order.processing == true
                                  ? "Đang xử lý"
                                  : "Đã hủy",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        });
  }
}
