import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartTile extends StatelessWidget {
  const CartTile(this._cartProduct, {super.key});

  final CartProduct _cartProduct;

  @override
  Widget build(BuildContext context) {

    Widget _buildContent() {
      return Container();
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: _cartProduct.productData == null ?
        FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection("products").doc(_cartProduct.category).collection("items").doc(_cartProduct.pid).get(), 
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              _cartProduct.productData = ProductData.fromDocument(snapshot.data!);
              return _buildContent();
            } else {
              return Container(
                height: 70.0,
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              );
            }
          })
        :
          _buildContent()
          ,
    );
  }
}