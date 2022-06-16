import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:data_penjualan/exfab.dart';

import 'Create.dart';
import 'Details.dart';
import 'Daterange.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeView createState() => HomeView();
}

class HomeView extends State<Home> {
  List storedData = [];
  List loadData = [];

  @override
  initState() {
    super.initState();
    observeData();
  }

  Future observeData() async {
    try {
      final response = await http.get(
          Uri.parse("http://192.168.100.49/data_penjualan/api.php?opt=list"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          loadData = data;
          storedData = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void searchFunc(String search) async {
    List results = [];

    if (search.isEmpty) {
      results = storedData;
    } else {
      results = storedData
          .where((data) =>
              data["nm_brg"].toLowerCase().contains(search.toLowerCase()) |
              data["tgl_trns"].contains(search) |
              data["jns_brg"].toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
    setState(() {
      loadData = results;
    });
  }

  void daterange() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      currentDate: DateTime.now(),
      saveText: 'Cari',
    );

    if (result != null) {
      print(result.start);
      print(result.end);
      if (!mounted) return;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Daterange(storedData, result.start, result.end)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Penjualan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              autofocus: false,
              onChanged: (value) => searchFunc(value),
              decoration: InputDecoration(
                hintText: 'Nama barang / Tanggal transaksi / Jenis Barang',
                labelStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.all(15),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: storedData.isNotEmpty
                  ? ListView.builder(
                      itemCount: loadData.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(loadData[index]["id_brg"]),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          title: Text(
                            loadData[index]['nm_brg'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Stock: ${loadData[index]["stk_brg"].toString()}'),
                              Text(
                                  'Jumlah Terjual: ${loadData[index]["jml_trjl"].toString()}'),
                              Text(
                                  'Tanggal Transaksi: ${loadData[index]["tgl_trns"].toString()}'),
                              Text(
                                  'Jenis Barang: ${loadData[index]["jns_brg"].toString()}'),
                            ],
                          ),
                          onTap: () {
                            String id = loadData[index]["id_brg"].toString();
                            String nm_brg =
                                loadData[index]["nm_brg"].toString();
                            String stock =
                                loadData[index]["stk_brg"].toString();
                            String terjual =
                                loadData[index]["jml_trjl"].toString();
                            String tgl_trn =
                                loadData[index]["tgl_trns"].toString();
                            String jns_brg =
                                loadData[index]["jns_brg"].toString();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Details(id, nm_brg,
                                        stock, terjual, tgl_trn, jns_brg)));
                          },
                        ),
                      ),
                    )
                  : const Text(
                      'Data Tidak Ditemukan',
                      style: TextStyle(fontSize: 15),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: ExpandableFab(
        distance: 80,
        children: [
          ActionButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Create())),
            icon: const Icon(Icons.add, color: Colors.white),
          ),
          ActionButton(
            onPressed: daterange,
            icon: const Icon(Icons.date_range, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
