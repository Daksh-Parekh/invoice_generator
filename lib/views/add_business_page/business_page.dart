import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice_generator/utils/extensions.dart';
import 'package:invoice_generator/utils/globals.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({super.key});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Details"),
        backgroundColor: Colors.lightBlueAccent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                width: double.infinity,
                height: size.height * 0.8,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 75,
                            foregroundImage: Globals.image != null
                                ? FileImage(Globals.image!)
                                : null,
                          ),
                          FloatingActionButton.small(
                            onPressed: () async {
                              ImagePicker picker = ImagePicker();

                              XFile? file = await picker.pickImage(
                                  source: ImageSource.gallery);

                              if (file != null) {
                                log("Image Received");
                                Globals.image = File(file.path);
                                setState(() {});
                              } else {
                                log("Image not Received !!");
                              }
                            },
                            child: Icon(Icons.add_a_photo),
                          ),
                        ],
                      ),
                      10.h,
                      TextFormField(
                        initialValue: Globals.name,
                        onSaved: (val) {
                          Globals.name = val;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Business Name",
                          labelText: "Enter Company Name",
                          prefixIcon: Icon(Icons.add_business_rounded),
                        ),
                      ),
                      8.h,
                      TextFormField(
                        initialValue: Globals.add,
                        onSaved: (val) {
                          Globals.add = val;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Address",
                          labelText: "Enter Address",
                          prefixIcon: Icon(Icons.location_on),
                        ),
                        maxLines: 3,
                      ),
                      8.h,
                      TextFormField(
                        initialValue: Globals.contact,
                        keyboardType: TextInputType.phone,
                        onSaved: (val) {
                          Globals.contact = val;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Contact Number",
                          labelText: "Enter Contact Number",
                          prefixIcon: Icon(Icons.phone),
                        ),
                        maxLength: 10,
                      ),
                      10.h,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              formKey.currentState!.reset();
                              Globals.name = Globals.add =
                                  Globals.contact = Globals.image = null;
                              setState(() {});
                            },
                            child: Text("Reset"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              formKey.currentState!.save();
                              setState(() {});
                            },
                            child: Text("Save"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('add_product');
        },
        backgroundColor: Colors.lightBlueAccent.shade100,
        icon: Icon(Icons.add),
        label: Text("Add Product"),
      ),
    );
  }
}
