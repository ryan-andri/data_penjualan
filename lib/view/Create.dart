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

  void stateButton(BuildContext context, String brg, String stk, String trj,
      String jns, String trn) {
    if (brg.isEmpty ||
        stk.isEmpty ||
        trj.isEmpty ||
        jns.isEmpty ||
        trn.isEmpty) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Semua Kolom harus diisi!"),
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    AlertDialog alert = AlertDialog(
      title: Text("Tambah Data Barang"),
      content: Container(
        child: Text("Apakah Anda yakin ?"),
      ),
      actions: [
        TextButton(
          child: Text('Iya'),
          // Todo : post to API
          onPressed: () => saveState(),
        ),
        TextButton(
          child: Text('Tidak'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alert);
    return;
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
                decoration: InputDecoration(
                  hintText: 'Nama Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                ),
              ),
              const SizedBox(height: 6),
              // Stok
              TextFormField(
                controller: stock,
                decoration: InputDecoration(
                  hintText: 'Stock Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                ),
              ),
              const SizedBox(height: 6),
              // Jumlah Terjual
              TextFormField(
                controller: terjual,
                decoration: InputDecoration(
                  hintText: 'Jumlah Terjual',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                ),
              ),
              const SizedBox(height: 6),
              // Tanggal Transaksi
              TextFormField(
                controller: transaksi,
                decoration: InputDecoration(
                  hintText: 'Tanggal Transaksi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
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
              ),
              const SizedBox(height: 6),
              // Jenis Barang
              TextFormField(
                controller: jenis,
                decoration: InputDecoration(
                  hintText: 'Jenis Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          stateButton(context, barang.text, stock.text, terjual.text,
              jenis.text, transaksi.text);
        },
      ),
    );
  }
}
