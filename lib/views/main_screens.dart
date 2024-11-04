import 'package:app_web_multi_store/views/side_bar_screen/buyer_screen.dart';
import 'package:app_web_multi_store/views/side_bar_screen/category_screen.dart';
import 'package:app_web_multi_store/views/side_bar_screen/order_screen.dart';
import 'package:app_web_multi_store/views/side_bar_screen/product_screen.dart';
import 'package:app_web_multi_store/views/side_bar_screen/upload_banner_screen.dart';
import 'package:app_web_multi_store/views/side_bar_screen/vendor_sreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  Widget _selectedScreen = const VendorSreen();

  screenSelector(item) {
    switch (item.route) {
      case BuyerScreen.id:
        setState(() {
          _selectedScreen = const BuyerScreen();
        });
        break;

      case VendorSreen.id:
        setState(() {
          _selectedScreen = const VendorSreen();
        });
        break;

      case OrderScreen.id:
        setState(() {
          _selectedScreen = const OrderScreen();
        });
        break;

      case CategoryScreen.id:
        setState(() {
          _selectedScreen = const CategoryScreen();
        });
        break;

      case UploadBannerScreen.id:
        setState(() {
          _selectedScreen = const UploadBannerScreen();
        });
        break;

      case ProductScreen.id:
        setState(() {
          _selectedScreen = const ProductScreen();
        });
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Quản lý"),
      ),
      body: _selectedScreen,
      sideBar: SideBar(
        header: Container(
          height: 50,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.black),
          child: const Center(
            child: Text(
              'Multi Vendor Admin',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.7),
            ),
          ),
        ),
        items: const [
          AdminMenuItem(
              title: 'Nhà cung cấp',
              route: VendorSreen.id,
              icon: CupertinoIcons.person_3),
          AdminMenuItem(
              title: 'Người mua',
              route: BuyerScreen.id,
              icon: CupertinoIcons.person),
          AdminMenuItem(
              title: 'Đơn hàng',
              route: OrderScreen.id,
              icon: CupertinoIcons.shopping_cart),
          AdminMenuItem(
              title: 'Danh mục',
              route: CategoryScreen.id,
              icon: Icons.category),
          AdminMenuItem(
              title: 'Thêm Banner',
              route: UploadBannerScreen.id,
              icon: Icons.upload),
          AdminMenuItem(
              title: 'Sản phẩm', route: ProductScreen.id, icon: Icons.store),
        ],
        selectedRoute: VendorSreen.id,
        onSelected: (item) {
          screenSelector(item);
        },
      ),
    );
  }
}
