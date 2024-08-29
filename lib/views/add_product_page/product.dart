import 'package:flutter/material.dart';
import 'package:invoice_generator/utils/extensions.dart';
import 'package:invoice_generator/utils/globals.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Map> allProd = [
    {},
  ];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product Details"),
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('pdf_page');
            },
            icon: Icon(Icons.picture_as_pdf_rounded),
            color: Colors.black,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: allProd
                    .map(
                      (e) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  e['id'] = val;
                                },

                                // onSaved: (val) {
                                //   e['id'] = val;
                                // },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Product Id",
                                  labelText: "Enter Product Id",
                                  prefixIcon: Icon(Icons.numbers_rounded),
                                ),
                              ),
                              8.h,
                              TextFormField(
                                onChanged: (val) {
                                  e['name'] = val;
                                },
                                // onSaved: (val) {
                                //   e['name'] = val;
                                // },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Product Name",
                                  labelText: "Enter Product Name",
                                  prefixIcon: Icon(Icons.shopping_cart),
                                ),
                              ),
                              8.h,
                              TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  e['qty'] = val;
                                },
                                // onSaved: (val) {
                                //   e['qty'] = val;
                                // },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Product Quantity",
                                    labelText: "Enter Quantity",
                                    prefixIcon: Icon(Icons.shopify_rounded)),
                              ),
                              8.h,
                              TextFormField(
                                onChanged: (val) {
                                  e['price'] = val;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Product Price",
                                  labelText: "Enter Price",
                                  prefixIcon: Icon(Icons.price_change_rounded),
                                ),
                              ),
                              10.h,
                              ElevatedButton.icon(
                                onPressed: () {
                                  // allProd.clear();\
                                  allProd.removeAt(
                                    allProd.indexOf(e),
                                  );

                                  setState(() {});
                                },
                                icon: Icon(Icons.clear),
                                label: Text("Reset"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              20.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      allProd.add({});
                      setState(() {});
                    },
                    icon: Icon(Icons.add),
                    label: Text("Add Product"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Globals.productDetails.clear();
                      Globals.productDetails = allProd;
                    },
                    icon: Icon(Icons.save),
                    label: Text("Save"),
                  ),
                ],
              ),
              // Text("${Globals.productDetails}")
            ],
          ),
        ),
      ),
    );
  }
}
