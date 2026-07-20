import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartProduct {

  String cid = "";
  String category = "";
  String pid = "";
  int quantity = 0;
  String size = "";

  late ProductData productData;

  CartProduct.fromDocument(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>?;
    cid = document.id;
    category = data?["category"];
    pid = data?["pid"];
    quantity = data?["quantity"];
    size = data?["size"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "product": productData.toResumedMap(),
    };
  }

}