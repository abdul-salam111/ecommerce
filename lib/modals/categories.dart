class ProductModel {
  String? name;
  String? image;
  double? price;
  ProductModel({this.name, this.image, this.price});
  Map<String, dynamic> toMap() {
    return {"Name": name, "Image": image, "Price": price};
  }
}
