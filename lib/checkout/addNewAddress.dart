import 'package:firebasework/checkout/delivery.dart';
import 'package:firebasework/utilities/constants.dart';
import 'package:flutter/material.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({Key? key}) : super(key: key);

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final namecontroller = TextEditingController();
  final mobilecontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final areacontroller = TextEditingController();
  final streetcontroller = TextEditingController();
  final housecontroller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    mobilecontroller.dispose();
    citycontroller.dispose();
    areacontroller.dispose();
    streetcontroller.dispose();
    housecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (builder) => DeliveryDetails(
                        name: namecontroller.text,
                        mobileno: mobilecontroller.text,
                        city: citycontroller.text,
                        street: streetcontroller.text,
                        area: areacontroller.text,
                        houseno: housecontroller.text,
                      )));
        },
        style: ElevatedButton.styleFrom(
            primary: maincolor,
            minimumSize: const Size(double.infinity, 45),
            shape: const StadiumBorder()),
        child: const Text("Add Address"),
      ),
      appBar: AppBar(
        backgroundColor: maincolor,
        title: const Text("Add New Address"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Enter your address",
              style: TextStyle(
                  color: maincolor, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: namecontroller,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: maincolor),
                  label: Text("Full Name"),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: mobilecontroller,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: maincolor),
                  label: Text("Mobile No:"),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: citycontroller,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: maincolor),
                  label: Text("City"),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: areacontroller,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: maincolor),
                  label: Text("Area"),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: streetcontroller,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: maincolor),
                  label: Text("Street"),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: housecontroller,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: maincolor),
                  label: Text("House No"),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: maincolor)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
