import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'crud_screen.dart';

class EditWishlistScreen extends StatefulWidget {
  final int kodeBarang;
  final String? barang;
  final String? harga;
  final String? tujuan;

  EditWishlistScreen({
    required this.kodeBarang,
    this.barang,
    this.harga,
    this.tujuan,
  });

  @override
  State<EditWishlistScreen> createState() => _EditWishlistScreenState();
}

class _EditWishlistScreenState extends State<EditWishlistScreen> {
  TextEditingController barangController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController tujuanController = TextEditingController();

  void updateWishlist() async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('wishlist')
        .doc(widget.kodeBarang.toString());

    Map<String, dynamic> updatedData = {
      "kode_barang": widget.kodeBarang,
      "barang": barangController.text,
      "harga": hargaController.text,
      "tujuan": tujuanController.text,
    };

    await documentReference.update(updatedData);
    print("Data ${widget.kodeBarang} berhasil diperbarui");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => CrudScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void deleteWishlist() async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('wishlist')
        .doc(widget.kodeBarang.toString());

    await documentReference.delete();
    print("Data ${widget.kodeBarang} berhasil dihapus");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => CrudScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void konfirmasiHapus() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Apakah anda yakin ingin menghapus '${widget.barang}'?"),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
            child: Text("HAPUS", style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.pop(context); // tutup dialog
              deleteWishlist();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(foregroundColor: Colors.green),
            child: Text("BATAL", style: TextStyle(color: Colors.black)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    barangController.text = widget.barang ?? "";
    hargaController.text = widget.harga ?? "";
    tujuanController.text = widget.tujuan ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Wishlist")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              "Edit Data Wishlist",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 24),
            TextFormField(
              readOnly: true,
              initialValue: widget.kodeBarang.toString(),
              decoration: InputDecoration(labelText: "Kode Barang"),
            ),
            TextFormField(
              controller: barangController,
              decoration: InputDecoration(labelText: "Nama Barang"),
            ),
            TextFormField(
              controller: hargaController,
              decoration: InputDecoration(labelText: "Harga Barang"),
            ),
            TextFormField(
              controller: tujuanController,
              decoration: InputDecoration(labelText: "Tujuan"),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.orange,
                  ),
                  onPressed: updateWishlist,
                  child: Text("Ubah"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: konfirmasiHapus,
                  child: Text("Hapus"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
