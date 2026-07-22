import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/models/cart_model.dart';

class CartTile extends StatelessWidget {
  const CartTile(this._cartProduct, {super.key});

  final CartProduct _cartProduct;

  @override
  Widget build(BuildContext context) {

    Widget _buildContent() {
      CartModel.of(context).updatePrices();

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            width: 120.0,
            child: (_cartProduct.productData?.images?.isEmpty ?? true)
              ? const Center(child: Icon(Icons.image_not_supported))
              : Image.network(
                  _cartProduct.productData!.images[0],
                  fit: BoxFit.cover,
                ),        
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _cartProduct.productData?.title ?? '',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                  ),
                  Text(
                    "Tamanho: ${_cartProduct.size}",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "R\$ ${_cartProduct.productData?.price.toStringAsFixed(2)}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Theme.of(context).primaryColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                        onPressed: _cartProduct.quantity > 1 ? (){
                          CartModel.of(context).decProduct(_cartProduct);
                        } : null, 
                      ),
                      Text(_cartProduct.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          CartModel.of(context).incProduct(_cartProduct);
                        }, 
                      ),
                      ElevatedButton(
                        child: Text("Remover", style: TextStyle(color: Colors.grey[500]),),
                        onPressed: () {
                          CartModel.of(context).removeCartItem(_cartProduct);
                        }, 
                        
                      )
                    ],
                  )
                ],
              ),
            )
          )
        ],
      );
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