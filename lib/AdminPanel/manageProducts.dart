import 'package:firebasework/AdminPanel/addProduct.dart';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AllProducts extends StatefulWidget {
  String? collection;
  AllProducts({this.collection});
  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final productId = FirebaseFirestore.instance.collection("Burgers").doc().id;
  CollectionReference? products;
  @override
  void initState() {
    super.initState();
    products = FirebaseFirestore.instance.collection(widget.collection!);
    process = false;
  }

  bool? process;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => AddProduc(
                          prodUpdate: false,
                          ref: widget.collection,
                        )));
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: SizedBox(
                height: 45,
                child: TextField(
                  onChanged: (value) {},
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    fillColor: Color.fromARGB(170, 104, 103, 103),
                    filled: true,
                    focusColor: Colors.white,
                    label: Text("Search"),
                    prefixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                stream: products!.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        physics: const ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, int index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Dismissible(
                              key: UniqueKey(),
                              onDismissed: ((DismissDirection direction) async {
                                await delete(documentSnapshot.id).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Deleted')));
                                });
                              }),
                              background: Container(
                                color: Colors.red,
                                child: Row(
                                  children: const [
                                    Icon(Icons.delete),
                                    Text("Move to trash")
                                  ],
                                ),
                              ),
                              child: Card(
                                child: ListTile(
                                  leading: SizedBox(
                                    width: 100,
                                    child: Image.network(
                                      documentSnapshot["Image"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(documentSnapshot["Name"]),
                                  subtitle: Text(
                                      documentSnapshot["Price"].toString()),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) => AddProduc(
                                                    prodUpdate: true,
                                                    productName:
                                                        documentSnapshot[
                                                            "Name"],
                                                    price: double.tryParse(
                                                        documentSnapshot[
                                                            "Price"]),
                                                    productImage:
                                                        documentSnapshot[
                                                            "Image"],
                                                    id: documentSnapshot.id,
                                                  )));
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ));
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future delete(String id) async {
    await firestore.collection(widget.collection!).doc(id).delete();
  }
}
