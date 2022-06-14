import 'package:flutter/material.dart';

import 'package:intl/intl.dart' show DateFormat;
import 'package:http/http.dart' as http;

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => CreateView();
}

class CreateView extends State<Create> {
  final formState = GlobalKey<FormState>();

  var barang = TextEditingController();
  var stock = TextEditingController();
  var terjual = TextEditingController();
  var jenis = TextEditingController();
  TextEditingController transaksi = TextEditingController();

  Future saveState() async {
    try {
      // dummy
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Barang"),
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          if (formState.currentState!.validate()) {
            saveState();
          }
        },
      ),
    );
  }
}
