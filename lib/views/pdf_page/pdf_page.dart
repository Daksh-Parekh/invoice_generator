import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:invoice_generator/utils/globals.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  void initState() {
    Globals.totalBill = 0.0;
    double total = 0.0;
    Globals.productDetails.map((e) {
      total = int.parse(e['qty']) * double.parse(e['price']);
      Globals.totalBill += total;
    }).toList();

    super.initState();
  }

  Future<Uint8List> getPDF() async {
    pw.Document pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context cn) => pw.Column(
          children: [
            pw.Container(
              padding: pw.EdgeInsets.all(16),
              color: PdfColors.blue300,
              alignment: pw.Alignment.topLeft,
              child: pw.Row(
                children: [
                  pw.ClipRRect(
                    verticalRadius: 70,
                    horizontalRadius: 70,
                    child: pw.Image(
                      pw.MemoryImage(
                        Globals.image!.readAsBytesSync(),
                      ),
                      fit: pw.BoxFit.cover,
                      height: 150,
                      width: 150,
                    ),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    "${Globals.name}\n${Globals.add}\n${Globals.contact}",
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Expanded(
              child: pw.Container(
                color: PdfColors.white,
                padding: pw.EdgeInsets.all(16),
                child: pw.Column(
                  children: [
                    pw.Divider(
                      thickness: 2,
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Text(
                            "Id",
                            style: pw.TextStyle(
                              fontSize: 23,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text(
                            "Product Name",
                            style: pw.TextStyle(
                              fontSize: 23,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            "Qty",
                            style: pw.TextStyle(
                              fontSize: 23,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            "Price",
                            style: pw.TextStyle(
                              fontSize: 23,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.Divider(
                      thickness: 2,
                    ),
                    ...Globals.productDetails
                        .map(
                          (e) => pw.Row(
                            children: [
                              pw.Expanded(
                                child: pw.Text(
                                  "${e['id']}",
                                  style: pw.TextStyle(fontSize: 20),
                                ),
                              ),
                              pw.Expanded(
                                flex: 3,
                                child: pw.Text(
                                  "${e['name']}",
                                  style: pw.TextStyle(fontSize: 20),
                                  maxLines: 2,
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Text(
                                  "${e['qty']}",
                                  style: pw.TextStyle(fontSize: 20),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Text(
                                  "${e['price']}",
                                  style: pw.TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                    pw.Spacer(),
                    pw.Container(
                      color: PdfColors.blue300,
                      height: 50,
                      padding: pw.EdgeInsets.all(10),
                      child: pw.Row(
                        children: [
                          pw.Expanded(
                            child: pw.Text(
                              "Total",
                              style: pw.TextStyle(fontSize: 20),
                            ),
                          ),
                          pw.Spacer(),
                          pw.Text("${Globals.totalBill}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Page"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: PdfPreview(
        build: (format) => getPDF(),
      ),
    );
  }
}
