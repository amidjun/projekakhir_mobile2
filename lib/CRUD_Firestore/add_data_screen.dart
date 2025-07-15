import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  TextEditingController namaBarang = TextEditingController();
  TextEditingController hargaBarang = TextEditingController();
  TextEditingController tujuanBarang = TextEditingController();
  int? lasIdWishList;

  void addWishList() async {
    try {
      int? lastIdWishList = await getLastIdWishList();
      int newId = (lastIdWishList ?? 0) + 1;

      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('wishlist')
          .doc(newId.toString());

      Map<String, dynamic> newWishList = {
        "kode_barang": newId,
        "barang": namaBarang.text,
        "harga": hargaBarang.text,
        "tujuan": tujuanBarang.text,
      };

      await documentReference.set(newWishList);

      print("Berhasil menambahkan ${namaBarang.text} ke Wishlist");
      Navigator.pop(context);
    } catch (e) {
      print("Gagal menambahkan data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan saat menambahkan data')),
      );
    }
  }

  Future<int?> getLastIdWishList() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('wishlist')
        .orderBy('kode_barang')
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first['kode_barang'];
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getLastIdWishList().then((value) {
      setState(() {
        lasIdWishList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Wishlist")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              "Nama Barang",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: namaBarang,
              decoration: InputDecoration(labelText: "Nama Barang"),
            ),
            Text(
              "Harga Barang",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: hargaBarang,
              decoration: InputDecoration(labelText: "Harga Barang"),
            ),
            Text(
              "Tujuan",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: tujuanBarang,
              decoration: InputDecoration(labelText: "Tujuan"),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: addWishList,
              child: Text("Tambah Ke Wishlist"),
            ),
          ],
        ),
      ),
    );
  }
}
