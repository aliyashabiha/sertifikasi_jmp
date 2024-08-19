import 'package:flutter/material.dart';
import 'package:sertifikasi_jmp/screens/home_screen.dart';
import 'package:sertifikasi_jmp/screens/checkout_screen.dart';
import 'package:sertifikasi_jmp/login_page.dart';
import 'package:sertifikasi_jmp/screens/order_screen.dart';
import 'package:sertifikasi_jmp/screens/product_detail_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (ctx) => LoginPage(),
        '/home': (ctx) => HomeScreen(),
        '/product-detail': (ctx) => ProductDetailScreen(),
        '/checkout': (ctx) => CheckoutScreen(),
        '/order': (ctx) => OrderScreen(),
      },
    );
  }
}
