import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasework/Providers/ReviewCartProvider.dart';

import 'package:firebasework/Screens/productsDetail.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SeeAllProducts extends StatefulWidget {
  CollectionReference? collection;
  SeeAllProducts({Key? key, this.collection}) : super(key: key);
  @override
  State<SeeAllProducts> createState() => _SeeAllProductsState();
}

class _SeeAllProductsState extends State<SeeAllProducts> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ReviewCartProvider>(context);
    return Scaffold(
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
              stream: widget.collection!.snapshots(),
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
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => ProductsDetail(
                                            productName:
                                                documentSnapshot["Name"],
                                            productImage:
                                                documentSnapshot["Image"],
                                            productPrice: double.parse(
                                                documentSnapshot["Price"]),
                                          )));
                            },
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
                                subtitle:
                                    Text(documentSnapshot["Price"].toString()),
                                trailing: IconButton(
                                  icon: const Icon(
                                      Icons.add_shopping_cart_outlined),
                                  onPressed: () {
                                    double quantity = 1.0;
                                    cartProvider.addToCart(
                                        documentSnapshot["Image"],
                                        documentSnapshot["Name"],
                                        double.parse(documentSnapshot["Price"]),
                                        quantity);
                                    cartProvider.totalBill(double.parse(
                                        documentSnapshot["Price"]));
                                    cartProvider.addCounter();
                                    Fluttertoast.showToast(
                                        msg: "Product added!");
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
      ),
    );
  }
}
