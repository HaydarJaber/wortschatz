import 'dart:async';
import 'dart:typed_data';
import 'package:pdfx/pdfx.dart';
import 'package:flutter/material.dart';

class PdfLabPage extends StatefulWidget {
  final String name;
  final String titel;

  const PdfLabPage({Key? key, required  this.name, required  this.titel}) : super(key: key);

  @override
  State<PdfLabPage> createState() => _PdfLabPageState();
}

class _PdfLabPageState extends State<PdfLabPage> {

  late PdfControllerPinch pdfController;

  @override
  void initState() {
    pdfController = PdfControllerPinch(
        document: PdfDocument.openAsset(widget.name)
    );
    super.initState();
  }
  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }


  Widget pdfView() => PdfViewPinch(
      controller: pdfController ,
      onDocumentLoaded: (msg) {print(msg.toString());},
      onDocumentError: (error) { print(error.toString());}
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titel),
      ),
      body:
      Center(
        child: pdfView(),
      ),
    );
  }
}