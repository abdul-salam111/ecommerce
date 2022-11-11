import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasework/Screens/productsDetail.dart';
import 'package:firebasework/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BurgerScreen extends StatefulWidget {
  const BurgerScreen({Key? key}) : super(key: key);
  @override
  State<BurgerScreen> createState() => _BurgerScreenState();
}

class _BurgerScreenState extends State<BurgerScreen> {
  final CollectionReference burgersData =
      FirebaseFirestore.instance.collection("Burgers");
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: StreamBuilder(
        stream: burgersData.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, int index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => ProductsDetail(
                                      productName: documentSnapshot["Name"],
                                      productImage: documentSnapshot["Image"],
                                      productPrice: documentSnapshot["Price"],
                                      index: index,
                                    )));
                      },
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: maincolor, width: 2),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                opacity: 0.5,
                                colorFilter: const ColorFilter.mode(
                                    Colors.black, BlendMode.dstATop),
                                onError: (exception, StackTrace) {
                                  Fluttertoast.showToast(
                                      msg: exception.toString(),
                                      gravity: ToastGravity.TOP,
                                      toastLength: Toast.LENGTH_LONG);
                                },
                                image: NetworkImage(
                                  documentSnapshot["Image"],
                                ),
                                fit: BoxFit.cover)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              documentSnapshot["Name"],
                              style: cardsStyle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              "Rs: " + documentSnapshot["Price"].toString(),
                              style: cardsStyle,
                            ),
                          ],
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
    );
  }
}
