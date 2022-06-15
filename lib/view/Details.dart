import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
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

  var barang = TextEditingController();
  var stock = TextEditingController();
  var terjual = TextEditingController();
  var jenis = TextEditingController();
  var transaksi = TextEditingController();

  Future updateOrDelete(bool update) async {
    try {
      // singkat dengan ternari
      var target = update
          ? await http.post(
              Uri.parse(
                  "http://192.168.100.49/data_penjualan/api.php?opt=update"),
              body: {
                "id": widget.id,
                "nm_brg": barang.text,
                "stock": stock.text,
                "jml_trjl": terjual.text,
                "tgl_trns": transaksi.text,
                "jns_brg": jenis.text,
              },
            ).then((value) {
              var data = jsonDecode(value.body);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            })
          : await http.post(
              Uri.parse(
                  "http://192.168.100.49/data_penjualan/api.php?opt=delete"),
              body: {
                "id": widget.id,
              },
            ).then((value) {
              var data = jsonDecode(value.body);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            });
      return target;
    } catch (e) {
      print(e);
    }
  }

  void stateButton(BuildContext context, String id, String brg, String stk,
      String trj, String jns, String trn, bool update) {
    if (update &&
        (id.isEmpty ||
            brg.isEmpty ||
            stk.isEmpty ||
            trj.isEmpty ||
            jns.isEmpty ||
            trn.isEmpty)) {
      const snackBar = SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Semua Kolom harus diisi!"),
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    AlertDialog alert = AlertDialog(
      title: update ? Text("Update Barang") : Text("Hapus Barang"),
      content: Container(
        child: Text("Apakah Anda yakin ?"),
      ),
      actions: [
        TextButton(
          child: Text('Iya'),
          onPressed: () => updateOrDelete(update),
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));

                  if (date != null) {
                    String picked = DateFormat('yyyy-MM-dd').format(date);
                    setState(() {
                      transaksi.text = picked;
                    });
                  }
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
              const SizedBox(height: 35),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Align(
                    alignment: Alignment.center,
                    child:
                        Text("Update", style: TextStyle(color: Colors.white))),
                onPressed: () {
                  stateButton(context, widget.id, barang.text, stock.text,
                      terjual.text, jenis.text, transaksi.text, true);
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Align(
                    alignment: Alignment.center,
                    child:
                        Text("Hapus", style: TextStyle(color: Colors.white))),
                onPressed: () {
                  stateButton(context, widget.id, barang.text, stock.text,
                      terjual.text, jenis.text, transaksi.text, false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
