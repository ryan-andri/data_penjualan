import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String data;

  const Details(this.data, {Key? key}) : super(key: key);

  @override
  State<Details> createState() => DetailsView();
}

class DetailsView extends State<Details> {
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Barang"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(widget.data)],
        ),
      ),
    );
  }
}
