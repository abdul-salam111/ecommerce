
import 'package:firebasework/Providers/ReviewCartProvider.dart';
import 'package:firebasework/utilities/constants.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';



// ignore: must_be_immutable
class DeliveryDetails extends StatefulWidget {
  String? name = "AbdulSalam";
  String? mobileno = "03115308116";
  String? city = "hangu";
  String? area = "jawar ghundi";
  String? street = "12A";
  String? houseno = "179";
  DeliveryDetails(
      {Key? key, this.name,
      this.mobileno,
      this.city,
      this.area,
      this.street,
      this.houseno}) : super(key: key);

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  @override
  Widget build(BuildContext context) {
    final cartprovider =
        Provider.of<ReviewCartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        title: const Text("Delivery Details"),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "NavigationBar");
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.red,
                minimumSize: Size(MediaQuery.of(context).size.width / 2.2, 45)),
            child: const Text("Cancel Order"),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize: Size(MediaQuery.of(context).size.width / 2.2, 45)),
            child: const Text("Confirm Order"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.location_pin),
                  Text("Deliver to"),
                ],
              ),
              TextButton(onPressed: () {}, child: const Text("Change"))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color.fromARGB(255, 53, 52, 52),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 70, 69, 69),
                        offset: Offset(2, 2),
                        spreadRadius: 5,
                        blurRadius: 5),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(text: "Name: ", children: <TextSpan>[
                          TextSpan(
                              text: widget.name ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  letterSpacing: 1))
                        ]),
                      ),
                      const Divider(
                        height: 0,
                        color: Colors.white,
                      ),
                      RichText(
                        text: TextSpan(text: "From: ", children: <TextSpan>[
                          TextSpan(
                              text: widget.city ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  letterSpacing: 1))
                        ]),
                      ),
                      RichText(
                        text: TextSpan(text: "Area: ", children: <TextSpan>[
                          TextSpan(
                              text: widget.area ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  letterSpacing: 1))
                        ]),
                      ),
                      RichText(
                        text:
                            TextSpan(text: "Street No: ", children: <TextSpan>[
                          TextSpan(
                              text: widget.street ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  letterSpacing: 1))
                        ]),
                      ),
                      RichText(
                        text: TextSpan(text: "House No: ", children: <TextSpan>[
                          TextSpan(
                              text: widget.houseno ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  letterSpacing: 1))
                        ]),
                      ),
                      const Divider(
                        height: 0,
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "Total Items: ",
                                children: <TextSpan>[
                                  TextSpan(
                                      text: cartprovider.cartlist.length
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          letterSpacing: 1))
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Grand Total: ",
                                children: <TextSpan>[
                                  TextSpan(
                                      text: cartprovider.TotalBill.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          letterSpacing: 1))
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
                primary: maincolor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "AddNewAddress");
              },
              child: const Text("Add Address"),
            ),
          ),
        ]),
      ),
    );
  }
}
