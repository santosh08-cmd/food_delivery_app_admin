import 'package:flutter/material.dart';
import 'package:food_delivery_app_admin/screens/HomeScreen.dart';
import 'package:food_delivery_app_admin/screens/admin_users.dart';
import 'package:food_delivery_app_admin/screens/category_screen.dart';
import 'package:food_delivery_app_admin/screens/login_screen.dart';
import 'package:food_delivery_app_admin/screens/manage_banners.dart';
import 'package:food_delivery_app_admin/screens/notification_screen.dart';
import 'package:food_delivery_app_admin/screens/order_screen.dart';
import 'package:food_delivery_app_admin/screens/settings_screen.dart';
import 'package:food_delivery_app_admin/screens/vendor_screen.dart';
import 'package:food_delivery_app_admin/services/firebase_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home/Hygenic Food App Admin DashBoard',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: AuthService().handleAuth(),
      routes: {
        HomePage.id: (context) => HomePage(),
        LoginScreen.id: (context) => LoginScreen(),
        // BannerScreen.id: (context) => BannerScreen(),
        CategoryScreen.id: (context) => CategoryScreen(),
        //OrderScreen.id: (context) => OrderScreen(),
        //  NotificationScreen.id: (context) => NotificationScreen(),
//AdminUsers.id: (context) => AdminUsers(),
        // SettingScreen.id: (context) => SettingScreen(),
        vendorScreen.id: (context) => vendorScreen(),
      },
    );
  }
}
