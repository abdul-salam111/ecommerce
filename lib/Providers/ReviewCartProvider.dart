import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasework/modals/reviewCart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ReviewCartProvider with ChangeNotifier {
  ReviewCartModal reviewCartModal = ReviewCartModal();
  List<ReviewCartModal> cartlist = [];
  List<ReviewCartModal> newcartList = [];
  void addToCart(String image, String name, double price, double quantity) {
    reviewCartModal = ReviewCartModal(
        image: image, name: name, cartPrice: price, cartQauntity: quantity);
    newcartList.add(reviewCartModal);
    cartlist = newcartList;
    notifyListeners();
  }

  void removeFromCart(int index) {
    cartlist.removeAt(index);
    notifyListeners();
  }

  double quantity = 1;
  double get Quantity => quantity;
  addQuantity(int index) {
    cartlist[index].cartQauntity = cartlist[index].cartQauntity! + 1;
    notifyListeners();
  }

  void removeQuantity(int index) {
    cartlist[index].cartQauntity = cartlist[index].cartQauntity! - 1;
    notifyListeners();
  }

  int Counter = 0;
  int get counter => Counter;
  void addCounter() {
    Counter++;
    notifyListeners();
  }

  void removeCounter() {
    Counter--;
    notifyListeners();
  }

  get throwcartList {
    return cartlist;
  }

  final CollectionReference cartdata =
      FirebaseFirestore.instance.collection("ReviewCart");
  double totalPrice = 0.0;
  double get TotalBill => totalPrice;
  void totalBill(double productPrice) {
    totalPrice = totalPrice + productPrice;
    notifyListeners();
  }

  void RemoveBill(double productPrice) {
    totalPrice = totalPrice - productPrice;
    notifyListeners();
  }
}
