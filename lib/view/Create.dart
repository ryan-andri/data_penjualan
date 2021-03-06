import 'dart:convert';

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

  TextEditingController barang = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController terjual = TextEditingController();
  TextEditingController jenis = TextEditingController();
  TextEditingController transaksi = TextEditingController();

  Future saveState() async {
    try {
      return await http.post(
        Uri.parse("http://192.168.100.49/data_penjualan/api.php?opt=create"),
        body: {
          "nm_brg": barang.text,
          "stock": stock.text,
          "jml_trjl": terjual.text,
          "tgl_trns": transaksi.text,
          "jns_brg": jenis.text,
        },
      ).then((value) {
        var data = jsonDecode(value.body);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      });
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
        content: Text("Semua Kolom harus di isi!"),
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    AlertDialog alert = AlertDialog(
      title: const Text("Tambah Data Barang"),
      content: const Text("Apakah Anda yakin ?"),
      actions: [
        TextButton(
          child: Text('Iya'),
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
          child: ListView(
            children: [
              // Barang
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Nama Barang',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              TextFormField(
                controller: barang,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Stok
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Stock Barang',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              TextFormField(
                controller: stock,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Jumlah Terjual
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Jumlah Terjual',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              TextFormField(
                controller: terjual,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Tanggal Transaksi
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Tanggal Transaksi',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              TextFormField(
                controller: transaksi,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final DateFormat formatter = DateFormat('dd-MM-yyyy');
                  final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  if (date != null) transaksi.text = formatter.format(date);
                },
              ),
              const SizedBox(height: 6),
              // Jenis Barang
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Jenis Barang',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              TextFormField(
                controller: jenis,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
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
