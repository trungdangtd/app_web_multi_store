import 'package:app_web_multi_store/views/side_bar_screen/widgets/buyer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyerScreen extends StatelessWidget {
  static const String id = '/buyerscreen';
  const BuyerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget rowHeader(int flex, String text) {
      return Expanded(
        flex: flex,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
            color: const Color(
              0xff3c55ef,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              8,
            ),
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Quản lý người mua',
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                rowHeader(1, 'Ảnh'),
                rowHeader(3, 'Họ và Tên'),
                rowHeader(2, 'Email'),
                rowHeader(2, 'Địa chỉ'),
                rowHeader(1, 'Xoá'),
              ],
            ),
            const BuyerWidget(),
          ],
        ),
      ),
    );
  }
}
