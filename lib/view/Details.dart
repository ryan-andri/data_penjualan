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
          // Todo : post to API
          onPressed: () => Navigator.of(context).pop(),
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
              const SizedBox(height: 30),
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
              const SizedBox(height: 20),
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
