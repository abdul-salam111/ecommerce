import 'package:firebasework/Providers/ReviewCartProvider.dart';
import 'package:firebasework/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatefulWidget {
  const ReviewCart({Key? key}) : super(key: key);

  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  @override
  Widget build(BuildContext context) {
    final reviewcartprovider =
        Provider.of<ReviewCartProvider>(context, listen: false);
    return Scaffold(
      body: Consumer<ReviewCartProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "My Cart",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${value.cartlist.length}  Items",
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: value.cartlist.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 8),
                            child: Consumer<ReviewCartProvider>(
                              builder: (context, value, child) {
                                return Dismissible(
                                  key: UniqueKey(),
                                  onDismissed: (DismissDirection direction) {
                                    value.removeCounter();
                                    reviewcartprovider.RemoveBill(
                                        reviewcartprovider
                                                .cartlist[index].cartPrice! *
                                            reviewcartprovider
                                                .cartlist[index].cartQauntity!);
                                    value.removeFromCart(index);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Deleted')));
                                  },
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
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 60,
                                              width: 100,
                                              child: Image.network(
                                                value.cartlist[index].image!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.cartlist[index].name
                                                      .toString(),
                                                  style: cardsStyle,
                                                ),
                                                Text(
                                                    "Rs: ${value.cartlist[index].cartPrice}")
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      value.addQuantity(index);
                                                      value.totalBill(value
                                                          .cartlist[index]
                                                          .cartPrice!);
                                                    },
                                                    icon:
                                                        const Icon(Icons.add)),
                                                Consumer<ReviewCartProvider>(
                                                  builder:
                                                      (context, value, child) {
                                                    return Text(value
                                                        .cartlist[index]
                                                        .cartQauntity
                                                        .toString());
                                                  },
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      if (value.cartlist[index]
                                                              .cartQauntity! <=
                                                          1) {
                                                      } else {
                                                        reviewcartprovider
                                                            .removeQuantity(
                                                                index);
                                                        reviewcartprovider
                                                            .RemoveBill(value
                                                                .cartlist[index]
                                                                .cartPrice!);
                                                      }
                                                    },
                                                    icon: const Icon(
                                                        Icons.remove)),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ));
                      })),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(220, 66, 64, 64),
                          offset: Offset(1, 1),
                          blurRadius: 1,
                          spreadRadius: 5)
                    ],
                    color: const Color.fromARGB(220, 40, 39, 39)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Total Bill",
                              style: paymentstyle,
                            ),
                            Consumer<ReviewCartProvider>(
                              builder: (context, value, child) {
                                return Text(
                                  reviewcartprovider.totalPrice.toString(),
                                  style: amountStyle,
                                );
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "Discounts%",
                              style: paymentstyle,
                            ),
                            Text(
                              "5",
                              style: amountStyle,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "Dilvery",
                              style: paymentstyle,
                            ),
                            Text(
                              "99",
                              style: amountStyle,
                            )
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Grand total",
                              style: paymentstyle,
                            ),
                            Text(
                              ((value.TotalBill + 99).toString()),
                              style: amountStyle,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (reviewcartprovider.cartlist.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "No Cart Data Found");
                              } else {
                                Navigator.pushNamed(context, "DeliveryDetail");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                primary: maincolor,
                                minimumSize: const Size(200, 40)),
                          
                            child: Text("CheckOut"))
                      ]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
