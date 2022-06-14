import 'package:flutter/material.dart';

import 'package:intl/intl.dart' show DateFormat;

class Details extends StatefulWidget {
  final String id, nm_brg, stock, terjual, tgl_trn, jns_brg;

  const Details(this.id, this.nm_brg, this.stock, this.terjual, this.tgl_trn,
      this.jns_brg,
      {Key? key})
      : super(key: key);

  @override
  State<Details> createState() => DetailsView();
}

class DetailsView extends State<Details> {
  final formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var barang = TextEditingController();
    var stock = TextEditingController();
    var terjual = TextEditingController();
    var jenis = TextEditingController();
    TextEditingController transaksi = TextEditingController();

    barang.text = widget.nm_brg;
    stock.text = widget.stock;
    terjual.text = widget.terjual;
    jenis.text = widget.jns_brg;
    transaksi.text = widget.tgl_trn;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Barang"),
      ),
      body: Form(
        key: formState,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barang
              TextFormField(
                controller: barang,
                decoration: const InputDecoration(
                  hintText: 'Nama Barang',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama Barang Tidak Boleh Kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              // Stok
              TextFormField(
                controller: stock,
                decoration: const InputDecoration(
                  hintText: 'Stock Barang',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Stock Barang Tidak Boleh Kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              // Jumlah Terjual
              TextFormField(
                controller: terjual,
                decoration: const InputDecoration(
                  hintText: 'Jumlah Terjual',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Jumlah Terjual Tidak Boleh Kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              // Tanggal Transaksi
              TextFormField(
                controller: transaksi,
                decoration: const InputDecoration(
                  hintText: 'Tanggal Transaksi',
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final DateFormat formatter = DateFormat('dd-MM-yyyy');
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));

                  if (date != null) transaksi.text = formatter.format(date);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tanggal Transaksi Tidak Boleh Kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              // Jenis Barang
              TextFormField(
                controller: jenis,
                decoration: const InputDecoration(
                  hintText: 'Jenis Barang',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Jenis Barang Tidak Boleh Kosong!';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
