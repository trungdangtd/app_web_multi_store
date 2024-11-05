import 'package:app_web_multi_store/controllers/banner_controller.dart';
import 'package:app_web_multi_store/models/banner.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  //holds the list of banners
  late Future<List<BannerModel>> futureBanners;

  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureBanners,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Lỗi: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Không có banner nào"),
            );
          } else {
            final banners = snapshot.data!;
            return GridView.builder(
              shrinkWrap: true,
              itemCount: banners.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, crossAxisSpacing: 8, mainAxisExtent: 200),
              itemBuilder: (context, index) {
                final banner = banners[index];
                return Image.network(
                  banner.image,
                  height: 100,
                  width: 100,
                );
              },
            );
          }
        });
  }
}
