import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  final List<Map<String, dynamic>> data = [
    {
      "id": 1,
      "nm_brg": "Kopi",
      "stock": 100,
      "jml_tjl": 10,
      "tgl_trn": "01-05-2021",
      "jns_brg": "Konsumsi"
    },
    {
      "id": 2,
      "nm_brg": "Teh",
      "stock": 100,
      "jml_tjl": 19,
      "tgl_trn": "05-05-2021",
      "jns_brg": "Konsumsi"
    },
  ];

  List<Map<String, dynamic>> loadData = [];

  @override
  initState() {
    loadData = data;
    super.initState();
  }

  void searchFunc(String search) {
    List<Map<String, dynamic>> results = [];
    if (search.isEmpty) {
      results = data;
    } else {
      results = data
          .where((user) =>
              user["nm_brg"].toLowerCase().contains(search.toLowerCase()))
          .toList();
    }

    setState(() {
      loadData = results;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Penjualan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => searchFunc(value),
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Expanded(
              child: loadData.isNotEmpty
                  ? ListView.builder(
                      itemCount: loadData.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(loadData[index]["id"]),
                        color: Color.fromARGB(255, 213, 213, 213),
                        child: ListTile(
                          title: Text(
                            loadData[index]['nm_brg'],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Stock: ${loadData[index]["stock"].toString()}'),
                              Text(
                                  'Jumlah Terjual: ${loadData[index]["jml_tjl"].toString()}'),
                              Text(
                                  'Tanggal Transaksi: ${loadData[index]["tgl_trn"].toString()}'),
                              Text(
                                  'Jenis Barang: ${loadData[index]["jns_brg"].toString()}'),
                            ],
                          ),
                          onTap: () => ScaffoldMessenger.of(ctx).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      loadData[index]["nm_brg"].toString()))),
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
