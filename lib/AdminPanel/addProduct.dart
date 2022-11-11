import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasework/AdminPanel/manageProducts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasework/modals/categories.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:path/path.dart' as path;
import '../utilities/constants.dart';

class AddProduc extends StatefulWidget {
  bool? prodUpdate = false;
  String? ref;
  String? productName, productImage, id;
  double? price;
  AddProduc(
      {this.ref,
      this.prodUpdate,
      this.productName,
      this.price,
      this.productImage,
      this.id});

  @override
  State<AddProduc> createState() => _AddProducState();
}

class _AddProducState extends State<AddProduc> {
  @override
  void initState() {
    super.initState();
    isloading = false;
    if (widget.prodUpdate == true) {
      namecontroller.text = widget.productName!;
      priceController.text = widget.price.toString();
      imageController.text = widget.productImage!;
    }
  }

  final namecontroller = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();
  bool? isloading;
  String? filePath;

  File? _imageFile;
  FirebaseStorage _storage = FirebaseStorage.instance;
  final picker = ImagePicker();
  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
    filePath = path.basename(_imageFile!.path);
    imageController.text = filePath!;
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future Addburgers() async {
    setState(() {
      isloading = true;
    });
    Reference reference =
        FirebaseStorage.instance.ref().child("${widget.ref}/$filePath");
    UploadTask uploadTask = reference.putFile(_imageFile!);
    uploadTask.then((res) async {
      try {
        ProductModel productModel = ProductModel();
        productModel.name = namecontroller.text;
        productModel.price = double.parse(priceController.text);
        productModel.image = await res.ref.getDownloadURL();
        await firestore
            .collection(widget.ref!)
            .doc()
            .set(productModel.toMap())
            .then((value) {
          Fluttertoast.showToast(msg: "Product Added").then((value) {
            setState(() {
              isloading = true;
            });
          });
        }).then((value) {
          Navigator.pop(context);
        });
      } on FirebaseException catch (e) {
        Fluttertoast.showToast(msg: e.message!);
      }
    });
  }

  Future update(String id) async {
    await firestore.collection("Burgers").doc(id).update({
      "Name": namecontroller.text,
      "Price": priceController.text,
      "Image": imageController.text
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.prodUpdate);
    return Scaffold(
      body: isloading == true
          ? LoadingOverlay(
              color: Colors.transparent,
              opacity: 0.9,
              isLoading: isloading!,
              child: const Center(
                child: Text("Wait please..."),
              ))
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Enter Product Details",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: maincolor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: namecontroller,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: maincolor),
                      label: Text("Product Name"),
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
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: maincolor),
                      label: Text("Product Price"),
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
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onTap: () {
                      pickImage();
                    },
                    controller: imageController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: maincolor),
                      label: Text("Product Image"),
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
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.prodUpdate!
                          ? update(widget.id!).then((value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => AllProducts()));
                              Fluttertoast.showToast(msg: "Product Updated!");
                            })
                          : Addburgers().then((value) {
                              Fluttertoast.showToast(msg: "Product Added!");
                            });
                    },
                    style: ElevatedButton.styleFrom(
                        primary: maincolor,
                        minimumSize: const Size(double.infinity, 45),
                        shape: const StadiumBorder()),
                    child: Text(
                        widget.prodUpdate! ? "Edit Product" : "Add Product"),
                  ),
                ],
              ),
            ),
    );
  }

  void updateProduct(String id) {
    setState(() {
      isloading = true;
    });
    firestore.collection(widget.ref!).doc(id).update({
      "Name": namecontroller.text,
      "Price": priceController.text,
      "Image": imageController.text
    });
    setState(() {
      isloading = false;
    });
  }
}
