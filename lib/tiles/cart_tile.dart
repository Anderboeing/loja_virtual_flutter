import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/cart_model.dart';

class CartTile extends StatelessWidget {
  const CartTile(this._cartProduct, {super.key});

  final CartProduct _cartProduct;

  @override
  Widget build(BuildContext context) {
    // Os dados do produto já foram carregados pelo CartModel._loadCartItems()
    // antes de notifyListeners() ser chamado. Basta exibir os dados.
    final productData = _cartProduct.productData;

    if (productData == null) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Container(
          height: 70.0,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            width: 120.0,
            child: (productData.images.isEmpty)
              ? const Center(child: Icon(Icons.image_not_supported))
              : Image.network(
                  productData.images[0],
                  fit: BoxFit.cover,
                ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productData.title,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                  ),
                  Text(
                    "Tamanho: ${_cartProduct.size}",
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "R\$ ${productData.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                        onPressed: _cartProduct.quantity > 1
                          ? () => CartModel.of(context).decProduct(_cartProduct)
                          : null,
                      ),
                      Text(_cartProduct.quantity.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: Theme.of(context).primaryColor,
                        onPressed: () => CartModel.of(context).incProduct(_cartProduct),
                      ),
                      ElevatedButton(
                        child: Text("Remover", style: TextStyle(color: Colors.grey[500])),
                        onPressed: () => CartModel.of(context).removeCartItem(_cartProduct),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}