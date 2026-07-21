import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  late UserModel user;
  List<CartProduct> products = [];
  bool isLoading = false;

  String couponCode = '';
  int discountPercentage = 0;

  CartModel(this.user) {
    if(user.isLoggedIn()) {
      _loadCartItems();
    }
  }

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    FirebaseFirestore.instance.collection("users").doc(user.firebaseUser?.uid).collection("cart").add(cartProduct.toMap()).then((doc) {
      cartProduct.cid = doc.id;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    FirebaseFirestore.instance.collection("users").doc(user.firebaseUser?.uid).collection("cart").doc(cartProduct.cid).delete();
    products.remove(cartProduct);

    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;
    FirebaseFirestore.instance.collection("users").doc(user.firebaseUser?.uid).collection("cart").doc(cartProduct.cid).update(cartProduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;
    FirebaseFirestore.instance.collection("users").doc(user.firebaseUser?.uid).collection("cart").doc(cartProduct.cid).update(cartProduct.toMap());
    notifyListeners();
  }

  void SetCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void _loadCartItems() async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection("users").doc(user.firebaseUser?.uid).collection("cart").get();
    // Map documents to CartProduct instances
    products = query.docs.map((doc) => CartProduct.fromDocument(doc)).toList();
    // For each cart product, fetch the related product data from Firestore
    await Future.wait(products.map((cartProduct) async {
      try {
        DocumentSnapshot productSnap = await FirebaseFirestore.instance
            .collection("products")
            .doc(cartProduct.category)
            .collection("items")
            .doc(cartProduct.pid)
            .get();
        if (productSnap.exists) {
          cartProduct.productData = ProductData.fromDocument(productSnap);
        }
      } catch (e) {
        // Optionally handle errors, keep productData null
        debugPrint('Error loading product data for ${cartProduct.pid}: $e');
      }
    }));
    notifyListeners();
  }
}