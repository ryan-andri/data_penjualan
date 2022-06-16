import 'package:flutter/material.dart';

import 'package:intl/intl.dart' show DateFormat;

class Daterange extends StatefulWidget {
  List? data;
  DateTime? start, end;
  Daterange(this.data, this.start, this.end, {Key? key}) : super(key: key);

  @override
  State<Daterange> createState() => _WidgetDaterange();
}

class _WidgetDaterange extends State<Daterange> {
  final formState = GlobalKey<FormState>();

  List searchData = [];
  List storedData = [];

  @override
  void initState() {
    super.initState();
    searchData = dateSearch(widget.data, widget.start, widget.end);
  }

  List dateSearch(
    List? dates,
    DateTime? start,
    DateTime? end,
  ) {
    List output = [];
    var dateFormat = DateFormat('y-MM-dd');
    for (var i = 0; i < dates!.length; i += 1) {
      var date = dateFormat.parse(dates[i]['tgl_trns'], true);
      if (date.compareTo(start!) >= 0 && date.compareTo(end!) <= 0) {
        output.add(dates[i]);
      }
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pencarian tanggal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: searchData.isNotEmpty
                  ? ListView.builder(
                      itemCount: searchData.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(searchData[index]["id_brg"]),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          title: Text(
                            searchData[index]['nm_brg'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Stock: ${searchData[index]["stk_brg"].toString()}'),
                              Text(
                                  'Jumlah Terjual: ${searchData[index]["jml_trjl"].toString()}'),
                              Text(
                                  'Tanggal Transaksi: ${searchData[index]["tgl_trns"].toString()}'),
                              Text(
                                  'Jenis Barang: ${searchData[index]["jns_brg"].toString()}'),
                            ],
                          ),
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
    );
  }
}
