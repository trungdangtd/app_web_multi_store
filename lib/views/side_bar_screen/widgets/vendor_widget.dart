import 'package:app_web_multi_store/controllers/vendor_controller.dart';
import 'package:app_web_multi_store/models/vendor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorWidget extends StatefulWidget {
  const VendorWidget({super.key});

  @override
  State<VendorWidget> createState() => _VendorWidgetState();
}

class _VendorWidgetState extends State<VendorWidget> {
  //holds the list of vendors
  late Future<List<Vendor>> futureVendors;

  @override
  void initState() {
    super.initState();
    futureVendors = VendorController().loadVendors();
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
        future: futureVendors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Lỗi: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Không có vendor nào"),
            );
          } else {
            final vendors = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: vendors.length,
              itemBuilder: (context, index) {
                final vendor = vendors[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      buyerData(
                        1,
                        CircleAvatar(
                          child: Text(
                            vendor.fullname[0],
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
                          vendor.fullname,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      buyerData(
                        2,
                        Text(
                          vendor.email,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      buyerData(
                        2,
                        Text(
                          "${vendor.state}, ${vendor.city}",
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