import 'package:badges/badges.dart';

import 'package:firebasework/Providers/ReviewCartProvider.dart';

import 'package:firebasework/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductsDetail extends StatefulWidget {
  int? index;
  String? productImage;
  String? productName;
  double? productPrice;
  ProductsDetail(
      {this.productImage, this.productName, this.productPrice, this.index});

  @override
  State<ProductsDetail> createState() => _ProductsDetailState();
}

class _ProductsDetailState extends State<ProductsDetail> {
  double Quantity = 1;

  @override
  Widget build(BuildContext context) {
    final cartProvider =
        Provider.of<ReviewCartProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: maincolor,
                  minimumSize:
                      Size(MediaQuery.of(context).size.width / 2.2, 50)),
              onPressed: () {
                cartProvider.addToCart(widget.productImage!,
                    widget.productName!, widget.productPrice!, Quantity);
                Fluttertoast.showToast(
                  msg: "Added to the cart",
                );
                cartProvider.addCounter();
                cartProvider.totalBill(widget.productPrice! * Quantity);
                Navigator.pushNamed(context, "CartPage");
              },
              child: const Text("Add To Cart"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  minimumSize:
                      Size(MediaQuery.of(context).size.width / 2.2, 50)),
              onPressed: () {
                cartProvider.addToCart(widget.productImage!,
                    widget.productName!, widget.productPrice!, Quantity);
                Fluttertoast.showToast(
                  msg: "Add Delivery Address",
                );
                cartProvider.addCounter();
                cartProvider.totalBill(widget.productPrice! * Quantity);
                Navigator.pushNamed(context, "DeliveryDetail");
              },
              child: const Text("Buy Now"),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  image: DecorationImage(
                      image: NetworkImage(widget.productImage!),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: maincolor,
                        )),
                    Badge(
                      badgeContent: Consumer<ReviewCartProvider>(
                          builder: (context, value, child) {
                        return Text(cartProvider.Counter.toString());
                      }),
                      child: const Icon(
                        Icons.shopping_cart,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  Quantity++;
                                });
                              },
                              icon: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white)),
                                  child: const Icon(Icons.add))),
                          Consumer<ReviewCartProvider>(
                            builder: (context, value, child) {
                              return Text(
                                Quantity.toString(),
                                style: const TextStyle(fontSize: 17),
                              );
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                if (Quantity <= 1) {
                                } else {
                                  setState(() {
                                    Quantity--;
                                  });
                                }
                              },
                              icon: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white)),
                                  child: const Icon(Icons.remove))),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Consumer<ReviewCartProvider>(
                                    builder: (context, value, child) {
                                      return Text(
                                          "Total Bill: ${Quantity * widget.productPrice!}");
                                    },
                                  ))),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.productName!,
                          style: const TextStyle(
                            wordSpacing: 1,
                            letterSpacing: 1,
                            color: maincolor,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "\$${widget.productPrice}",
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              color: maincolor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
