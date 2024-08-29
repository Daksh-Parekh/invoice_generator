import 'package:flutter/material.dart';
import 'package:invoice_generator/views/add_business_page/business_page.dart';
import 'package:invoice_generator/views/add_product_page/product.dart';
import 'package:invoice_generator/views/homepage/home_page.dart';
import 'package:invoice_generator/views/pdf_page/pdf_page.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        'add_business': (context) => BusinessPage(),
        'add_product': (context) => ProductPage(),
        'pdf_page': (context) => PdfPage(),
      },
    );
  }
}
