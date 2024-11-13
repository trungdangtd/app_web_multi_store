import 'package:app_web_multi_store/controllers/buyer_controller.dart';
import 'package:app_web_multi_store/models/buyer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyerWidget extends StatefulWidget {
  const BuyerWidget({super.key});

  @override
  State<BuyerWidget> createState() => _BuyerWidgetState();
}

class _BuyerWidgetState extends State<BuyerWidget> {
  //holds the list of buyers
  late Future<List<Buyer>> futurebuyers;

  @override
  void initState() {
    super.initState();
    futurebuyers = BuyerController().loadBuyers();
  }

  @override
  Widget build(BuildContext context) {
    Widget buyerData(int flex, Widget widget) {
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
        future: futurebuyers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Lỗi: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Không có buyer nào"),
            );
          } else {
            final buyers = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: buyers.length,
              itemBuilder: (context, index) {
                final buyer = buyers[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      buyerData(
                        1,
                        CircleAvatar(
                          child: Text(
                            buyer.fullname[0],
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      buyerData(
                        3,
                        Text(
                          buyer.fullname,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      buyerData(
                        2,
                        Text(
                          buyer.email,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      buyerData(
                        2,
                        Text(
                          "${buyer.state}, ${buyer.city}",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      buyerData(
                        1,
                        TextButton(
                          onPressed: () {},
                          child: const Text('Xoá'),
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
