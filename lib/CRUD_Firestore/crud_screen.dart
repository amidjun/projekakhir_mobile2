import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:projekakhir/CRUD_Firestore/update_data_screen.dart";
import 'add_data_screen.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List Data Wishlist")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => AddDataScreen()),
        ),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("wishlist").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];

                  return Column(
                    children: [
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditWishlistScreen(
                                  kodeBarang: documentSnapshot['kode_barang'],
                                  barang: documentSnapshot['barang'],
                                  harga: documentSnapshot['harga'],
                                  tujuan: documentSnapshot['tujuan'],
                                ),
                          ),
                        ),
                        child: Card(
                          child: ListTile(
                            leading: Icon(Icons.production_quantity_limits),
                            title: Text(documentSnapshot['barang']),
                            subtitle: Text(documentSnapshot['tujuan']),
                            trailing: Text(documentSnapshot['harga']),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(backgroundColor: Colors.black),
            );
          }
        },
      ),
    );
  }
}
